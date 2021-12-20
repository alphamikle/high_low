import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:isolator/isolator.dart';

import '../../../service/di/di.dart';
import '../../../service/di/registrations.dart';
import '../../crypto/dto/stock_item.dart';
import 'main_backend.dart';

enum MainEvent {
  init,
  loadStocks,
  startLoadingStocks,
  endLoadingStocks,
  filterStocks,
  updateFilteredStocks,
}

int launchCount = 0;

class MainFrontend with Frontend, ChangeNotifier {
  bool isLaunching = true;
  bool isStocksLoading = false;
  final List<StockItem> stocks = [];
  TextEditingController searchController = TextEditingController();

  bool _isInLaunchProcess = false;
  bool _isLaunched = false;
  String _prevSearch = '';

  Future<void> loadStocks() => run(event: MainEvent.loadStocks);

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

  void _filterStocks() {
    if (_prevSearch != searchController.text) {
      _prevSearch = searchController.text;
      run(event: MainEvent.filterStocks, data: searchController.text);
    }
  }

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

  void _update(VoidCallback dataChanger) {
    dataChanger();
    notifyListeners();
  }

  static MainBackend _launch(BackendArgument<void> argument) {
    initDependencies();
    return MainBackend(argument: argument, cryptoProvider: Di.get());
  }

  @override
  void initActions() {
    whenEventCome(MainEvent.loadStocks).run(_setLoadedStocks);
    whenEventCome(MainEvent.startLoadingStocks).run(_startLoadingStocks);
    whenEventCome(MainEvent.endLoadingStocks).run(_endLoadingStocks);
    whenEventCome(MainEvent.updateFilteredStocks).run(_setLoadedStocks);
  }
}
