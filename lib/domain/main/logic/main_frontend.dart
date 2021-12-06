import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:isolator/isolator.dart';

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

class MainFrontend with Frontend<MainEvent>, ChangeNotifier {
  bool isLaunching = true;
  bool isStocksLoading = false;
  final List<StockItem> stocks = [];
  final Map<StockSymbol, StockItemPriceData> prices = {};
  final Set<StockSymbol> pricesOperationsWaitingQueue = {};
  final Set<StockSymbol> pricesOperationsLoadingQueue = {};
  TextEditingController searchController = TextEditingController();

  bool _isInLaunchProcess = false;
  bool _isLaunched = false;
  Timer? _pricesNotifierTimer;

  void loadStocks() => send(MainEvent.loadStocks);

  void loadStockItemPrice(StockSymbol symbol) => send(MainEvent.loadStockItemPrices, symbol);

  Future<void> launch() async {
    if (!isLaunching || _isLaunched || _isInLaunchProcess) {
      return;
    }
    _isInLaunchProcess = true;
    searchController.addListener(_filterStocks);
    await initBackend(_launch, backendType: MainBackend);
    _isInLaunchProcess = false;
    _isLaunched = true;
    _update(() => isLaunching = false);
  }

  void _filterStocks() => send(MainEvent.filterStocks, searchController.text);

  void _setLoadedStocks(List<StockItem> stocks) {
    _update(() {
      this.stocks.clear();
      this.stocks.addAll(stocks);
    });
  }

  void _startLoadingStocks() {
    _update(() {
      isStocksLoading = true;
    });
  }

  void _endLoadingStocks() {
    _update(() {
      isStocksLoading = false;
    });
  }

  void _setStockItemPrices(StockItemPriceData priceData) {
    prices[priceData.stockItem.symbol] = priceData;
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

  void _addSymbolOfOperationToWaitingQueue(StockSymbol symbol) {
    _update(() => pricesOperationsWaitingQueue.add(symbol));
  }

  void _addSymbolOfOperationToLoadingQueue(StockSymbol symbol) {
    _update(() => pricesOperationsLoadingQueue.add(symbol));
  }

  void _makeSymbolOperationLoaded(StockSymbol symbol) {
    _update(() {
      pricesOperationsWaitingQueue.remove(symbol);
      pricesOperationsLoadingQueue.remove(symbol);
    });
  }

  static Future<void> _launch(BackendArgument<void> argument) async {
    initDependencies();
    MainBackend(argument: argument, finHubProvider: Di.get());
  }

  @override
  Map<MainEvent, Function> get tasks => {
        MainEvent.loadStocks: _setLoadedStocks,
        MainEvent.startLoadingStocks: _startLoadingStocks,
        MainEvent.endLoadingStocks: _endLoadingStocks,
        MainEvent.loadStockItemPrices: _setStockItemPrices,
        MainEvent.filterStocks: _setLoadedStocks,
        MainEvent.priceOperationAddedToQueue: _addSymbolOfOperationToWaitingQueue,
        MainEvent.priceOperationStartLoading: _addSymbolOfOperationToLoadingQueue,
        MainEvent.priceOperationEndLoading: _makeSymbolOperationLoaded,
      };
}
