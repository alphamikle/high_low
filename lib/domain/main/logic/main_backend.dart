import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:isolator/isolator.dart';

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

class MainBackend extends Backend<MainEvent> {
  MainBackend({
    required BackendArgument<void> argument,
    required FinhubProvider finHubProvider,
  })  : _finHubProvider = finHubProvider,
        super(argument);

  final FinhubProvider _finHubProvider;
  final List<StockItem> _stocks = [];
  final Map<StockSymbol, StockItemPriceData> _prices = {};
  final Set<StockSymbol> _loadingPrices = {};
  final Queue<AsyncCallback> _pricesOperations = Queue();
  bool _isQueueHandling = false;
  Timer? _searchTimer;
  String _prevSearchSubString = '';

  Future<void> _loadStocks() async {
    send(MainEvent.startLoadingStocks);
    final List<StockItem> stocks = await _finHubProvider.fetchListOfStocks(
      token: Config.finhubToken,
      exchange: 'US',
    );
    stocks.sort(_stocksSortingPredicate);
    _stocks.clear();
    _stocks.addAll(stocks);
    await sendChunks(MainEvent.loadStocks, _stocks);
    send(MainEvent.endLoadingStocks);
  }

  Future<void> _loadStockItemPrice(StockSymbol symbol) async {
    if (_needToLoadStockPrices(symbol)) {
      _loadingPrices.add(symbol);
      send(MainEvent.priceOperationAddedToQueue, symbol);
      _pricesOperations.addLast(() async {
        send(MainEvent.priceOperationStartLoading, symbol);
        bench.start('Loading prices for symbol = $symbol');
        final ItemPrices itemPrices = await _finHubProvider.fetchStockItemPrices(
          token: Config.finhubToken,
          symbol: symbol,
        );
        bench.end('Loading prices for symbol = $symbol');
        final StockItemPriceData priceData = StockItemPriceData(
          createdAt: DateTime.now(),
          stockItem: _stocks.firstWhere((StockItem me) => me.symbol == symbol),
          prices: itemPrices,
        );
        _prices[symbol] = priceData;
        send(MainEvent.priceOperationEndLoading, symbol);
        send(MainEvent.loadStockItemPrices, priceData);
        _loadingPrices.remove(symbol);
      });
      unawaited(_pricesOperationsHandler());
    }
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

  void _filterStocks(String searchSubString) {
    if (_prevSearchSubString == searchSubString) {
      return;
    }
    _prevSearchSubString = searchSubString;
    send(MainEvent.startLoadingStocks);
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      _searchTimer = null;
      final List<StockItem> filteredStocks = _stocks.where(_stockFilterPredicate(searchSubString)).toList();
      await sendChunks(MainEvent.filterStocks, filteredStocks);
      send(MainEvent.endLoadingStocks);
    });
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
  Map<MainEvent, Function> get operations => {
        MainEvent.loadStocks: _loadStocks,
        MainEvent.loadStockItemPrices: _loadStockItemPrice,
        MainEvent.filterStocks: _filterStocks,
      };
}
