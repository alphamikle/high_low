import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:isolator/isolator.dart';
import 'package:isolator/next/utils.dart';

import '../../../service/config/config.dart';
import '../../../service/logs/benchmark.dart';
import '../../../service/queue/queue_operation.dart';
import '../../../service/types/types.dart';
import '../../finhub/dto/item_prices.dart';
import '../../finhub/dto/stock_item.dart';
import '../../finhub/logic/finhub_provider.dart';
import '../model/stock_item_price_data.dart';
import 'main_frontend.dart';

const int _queueSize = 5;

typedef StockItemFilter = bool Function(StockItem);

class MainBackend extends Backend {
  MainBackend({
    required BackendArgument<void> argument,
    required FinhubProvider finHubProvider,
  })  : _finHubProvider = finHubProvider,
        super(argument: argument);

  final FinhubProvider _finHubProvider;
  final List<StockItem> _stocks = [];
  final Map<StockSymbol, StockItemPriceData> _prices = {};
  final Set<StockSymbol> _loadingPrices = {};
  final Queue<AsyncCallback> _pricesOperations = Queue();
  bool _isQueueHandling = false;
  Timer? _searchTimer;
  String _prevSearchSubString = '';

  Future<ActionResponse<void>> _loadStocks({required MainEvent event, void data}) async {
    await send(event: MainEvent.startLoadingStocks);
    final List<StockItem> stocks = await _finHubProvider.fetchListOfStocks(
      token: Config.finhubToken,
      exchange: 'US',
    );
    print(1);
    stocks.sort(_stocksSortingPredicate);
    _stocks.clear();
    _stocks.addAll(stocks);
    bench.start('Send ${_stocks.length} items by chunks');
    await send(
      event: MainEvent.loadStocks,
      data: ActionResponse.chunks(
        Chunks(
          data: _stocks,
          updateAfterFirstChunk: true,
          size: 400,
          delay: const Duration(milliseconds: 1),
        ),
      ),
    );
    bench.end('Send ${_stocks.length} items by chunks');
    await send(event: MainEvent.endLoadingStocks);
    return ActionResponse.empty();
  }

  Future<ActionResponse<void>> _loadStockItemPrice({required MainEvent event, required StockSymbol data}) async {
    if (_needToLoadStockPrices(data)) {
      _loadingPrices.add(data);
      await send(event: MainEvent.priceOperationAddedToQueue, data: ActionResponse.value(data));
      _pricesOperations.addLast(() async {
        await send(event: MainEvent.priceOperationStartLoading, data: ActionResponse.value(data));
        bench.start('Loading prices for symbol = $data');
        try {
          final ItemPrices itemPrices = await _finHubProvider.fetchStockItemPrices(
            token: Config.finhubToken,
            symbol: data,
          );
          bench.end('Loading prices for symbol = $data');
          final StockItemPriceData priceData = StockItemPriceData(
            createdAt: DateTime.now(),
            stockItem: _stocks.firstWhere((StockItem me) => me.symbol == data),
            prices: itemPrices,
          );
          _prices[data] = priceData;
          await send(event: MainEvent.priceOperationEndLoading, data: ActionResponse.value(data));
          await send(event: MainEvent.loadStockItemPrices, data: ActionResponse.value(priceData));
          _loadingPrices.remove(data);
        } catch (error) {
          print('Error on loading item prices: $error');
          await wait(5000);
        } finally {
          await send(event: MainEvent.priceOperationEndLoading, data: ActionResponse.value(data));
          _loadingPrices.remove(data);
        }
      });
      unawaited(_pricesOperationsHandler());
    }
    return ActionResponse.empty();
  }

  bool _needToLoadStockPrices(StockSymbol symbol) {
    return !_loadingPrices.contains(symbol) && (!_prices.containsKey(symbol) || DateTime.now().difference(_prices[symbol]!.createdAt).inHours > 1);
  }

  Future<void> _pricesOperationsHandler() async {
    if (!_isQueueHandling) {
      _isQueueHandling = true;
      final List<QueueOperation> operations = [];
      while (_pricesOperations.isNotEmpty) {
        operations.removeWhere((QueueOperation me) => me.isCompleted);
        while (_pricesOperations.isNotEmpty && operations.length < _queueSize) {
          operations.add(QueueOperation(_pricesOperations.removeFirst()()));
        }
        await Future.any(operations.map((QueueOperation me) => me.operation));
      }
      _isQueueHandling = false;
    }
  }

  ActionResponse<void> _filterStocks({required MainEvent event, required String data}) {
    final String searchSubString = data;
    if (_prevSearchSubString == searchSubString) {
      return ActionResponse.empty();
    }
    _prevSearchSubString = searchSubString;
    send(event: MainEvent.startLoadingStocks);
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      _searchTimer = null;
      final List<StockItem> filteredStocks = _stocks.where(_stockFilterPredicate(searchSubString)).toList();
      await send(event: MainEvent.filterStocks, data: ActionResponse.chunks(Chunks(data: filteredStocks, updateAfterFirstChunk: true)));
      await send(event: MainEvent.endLoadingStocks);
    });
    return ActionResponse.empty();
  }

  int _stocksSortingPredicate(StockItem first, StockItem second) => first.symbol.compareTo(second.symbol);

  StockItemFilter _stockFilterPredicate(String searchSubString) {
    final String query = searchSubString.toLowerCase();
    return (StockItem item) {
      if (searchSubString.isEmpty) {
        return true;
      }
      return item.symbol.toLowerCase().contains(query) ||
          item.type.contains(query) ||
          item.currency.contains(query) ||
          item.mic.contains(query) ||
          item.displaySymbol.contains(query) ||
          item.figi.contains(query) ||
          item.description.contains(query);
    };
  }

  @override
  void initActions() {
    whenEventCome(MainEvent.loadStocks).run(_loadStocks);
    whenEventCome(MainEvent.loadStockItemPrices).run(_loadStockItemPrice);
    whenEventCome(MainEvent.filterStocks).run(_filterStocks);
  }
}
