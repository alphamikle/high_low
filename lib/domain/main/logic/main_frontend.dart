import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isolator/isolator.dart';
import 'package:isolator/src/maybe.dart';

import '../../../service/di/di.dart';
import '../../../service/di/registrations.dart';
import '../../../service/tools/localization_wrapper.dart';
import '../../crypto/dto/stock_item.dart';
import '../../notification/logic/notification_service.dart';
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

const int _magicVariable = 42;

class MainFrontend with Frontend, ChangeNotifier {
  late final NotificationService _notificationService;
  late final LocalizationWrapper _localizationWrapper;

  final List<StockItem> stocks = [];
  bool isLaunching = true;
  bool isStocksLoading = false;
  bool errorOnLoadingStocks = false;
  bool isSecretFounded = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  bool _isInLaunchProcess = false;
  bool _isLaunched = false;
  String _prevSearch = '';

  Future<void> loadStocks() async {
    errorOnLoadingStocks = false;
    final Maybe<List<StockItem>> stocks = await run(event: MainEvent.loadStocks);
    if (stocks.hasValue) {
      _update(() {
        this.stocks.clear();
        this.stocks.addAll(stocks.value);
      });
    }
    if (stocks.hasError) {
      _update(() {
        errorOnLoadingStocks = true;
      });
      await _notificationService.showSnackBar(content: _localizationWrapper.loc.main.errors.loadingError);
    }
  }

  void resetSecret() => _update(() {
        isSecretFounded = false;
      });

  Future<void> launch({
    required NotificationService notificationService,
    required LocalizationWrapper localizationWrapper,
  }) async {
    if (!isLaunching || _isLaunched || _isInLaunchProcess) {
      return;
    }
    _notificationService = notificationService;
    _localizationWrapper = localizationWrapper;

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

  void _setFilteredStocks({required MainEvent event, required List<StockItem> data}) {
    _update(() {
      stocks.clear();
      stocks.addAll(data);
      isSecretFounded = data.length == _magicVariable;
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
    whenEventCome(MainEvent.startLoadingStocks).run(_startLoadingStocks);
    whenEventCome(MainEvent.endLoadingStocks).run(_endLoadingStocks);
    whenEventCome(MainEvent.updateFilteredStocks).run(_setFilteredStocks);
  }
}
