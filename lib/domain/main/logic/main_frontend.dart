import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:isolator/isolator.dart';
import 'package:isolator/next/maybe.dart';

import '../../../service/di/di.dart';
import '../../../service/di/registrations.dart';
import '../../../service/types/types.dart';
import '../../finhub/dto/stock_item.dart';
import '../model/stock_item_price_data.dart';
import 'main_backend.dart';

enum MainEvent {
  init,
  loadStocks,
  startLoadingStocks,
  endLoadingStocks,
  loadStockItemPrices,
  filterStocks,
  priceOperationAddedToQueue,
  priceOperationStartLoading,
  priceOperationEndLoading,
}

class MainFrontend with Frontend, ChangeNotifier {
  bool isLaunching = true;
  bool isStocksLoading = false;
  final List<StockItem> stocks = [];
  final Map<StockSymbol, StockItemPriceData> prices = {};
  final Set<StockSymbol> _pricesLoadingBlocker = {};
  final Set<StockSymbol> pricesOperationsWaitingQueue = {};
  final Set<StockSymbol> pricesOperationsLoadingQueue = {};

  int counter = 0;
  TextEditingController searchController = TextEditingController();

  bool _isInLaunchProcess = false;
  bool _isLaunched = false;
  Timer? _pricesNotifierTimer;

  void loadStocks() => run(event: MainEvent.loadStocks);

  Future<void> loadStockItemPrice(StockSymbol symbol) async {
    if (_pricesLoadingBlocker.contains(symbol)) {
      return;
    }
    _pricesLoadingBlocker.add(symbol);
    final Maybe<Object?> response = await run(event: MainEvent.loadStockItemPrices, data: symbol);
    counter++;
    print('[$counter] [loadStockItemPrice] $symbol : $response');
  }

  Future<void> launch() async {
    if (!isLaunching || _isLaunched || _isInLaunchProcess) {
      return;
    }
    _isInLaunchProcess = true;
    searchController.addListener(_filterStocks);
    await initBackend(initializer: _launch);
    _isInLaunchProcess = false;
    _isLaunched = true;
    _update(() => isLaunching = false);
  }

  void _filterStocks() => run(event: MainEvent.filterStocks, data: searchController.text);

  void _setLoadedStocks({required MainEvent event, required List<StockItem> data}) {
    _update(() {
      stocks.clear();
      stocks.addAll(data);
    });
  }

  void _startLoadingStocks({required MainEvent event, void data}) {
    _update(() {
      isStocksLoading = true;
    });
  }

  void _endLoadingStocks({required MainEvent event, void data}) {
    _update(() {
      isStocksLoading = false;
    });
  }

  void _setStockItemPrices({required MainEvent event, required StockItemPriceData data}) {
    print('GET: _setStockItemPrices: ${data.stockItem.symbol}');
    prices[data.stockItem.symbol] = data;
    _pricesNotifierTimer?.cancel();
    _pricesNotifierTimer = Timer(const Duration(milliseconds: 250), () {
      _pricesNotifierTimer = null;
      _update(() {});
    });
  }

  void _update(VoidCallback dataChanger) {
    dataChanger();
    notifyListeners();
  }

  void _addSymbolOfOperationToWaitingQueue({required MainEvent event, required StockSymbol data}) {
    _update(() => pricesOperationsWaitingQueue.add(data));
  }

  void _addSymbolOfOperationToLoadingQueue({required MainEvent event, required StockSymbol data}) {
    _update(() => pricesOperationsLoadingQueue.add(data));
  }

  void _makeSymbolOperationLoaded({required MainEvent event, required StockSymbol data}) {
    _update(() {
      pricesOperationsWaitingQueue.remove(data);
      pricesOperationsLoadingQueue.remove(data);
      _pricesLoadingBlocker.remove(data);
    });
  }

  static MainBackend _launch(BackendArgument<void> argument) {
    initDependencies();
    return MainBackend(argument: argument, finHubProvider: Di.get());
  }

  @override
  void initActions() {
    whenEventCome(MainEvent.loadStocks).run(_setLoadedStocks);
    whenEventCome(MainEvent.startLoadingStocks).run(_startLoadingStocks);
    whenEventCome(MainEvent.endLoadingStocks).run(_endLoadingStocks);
    whenEventCome(MainEvent.loadStockItemPrices).run(_setStockItemPrices);
    whenEventCome(MainEvent.filterStocks).run(_setLoadedStocks);
    whenEventCome(MainEvent.priceOperationAddedToQueue).run(_addSymbolOfOperationToWaitingQueue);
    whenEventCome(MainEvent.priceOperationStartLoading).run(_addSymbolOfOperationToLoadingQueue);
    whenEventCome(MainEvent.priceOperationEndLoading).run(_makeSymbolOperationLoaded);
  }
}
