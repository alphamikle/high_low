import 'package:flutter/cupertino.dart';
import 'package:high_low/domain/main/dto/stock_item.dart';
import 'package:high_low/domain/main/logic/main_backend.dart';
import 'package:high_low/service/di/di.dart';
import 'package:high_low/service/di/registrations.dart';
import 'package:isolator/isolator.dart';

enum MainEvent {
  init,
  loadStocks,
}

class MainFrontend with Frontend<MainEvent>, ChangeNotifier {
  bool isLaunching = true;
  bool isStocksLoading = false;
  bool _isInLaunchProcess = false;
  bool _isLaunched = false;

  Future<void> loadStocks() async {
    _update(() => isStocksLoading = true);
    final List<StockItem> stocks = await runBackendMethod(MainEvent.loadStocks);
    _update(() => isStocksLoading = false);
  }

  Future<void> launch() async {
    if (!isLaunching || _isLaunched || _isInLaunchProcess) {
      return;
    }
    _isInLaunchProcess = true;
    await initBackend(_launch, backendType: MainBackend);
    _isInLaunchProcess = false;
    _isLaunched = true;
    _update(() => isLaunching = false);
  }

  void _update(VoidCallback dataChanger) {
    dataChanger();
    notifyListeners();
  }

  static Future<void> _launch(BackendArgument<void> argument) async {
    initDependencies();
    MainBackend(argument: argument, finHubProvider: Di.get());
  }

  @override
  Map<MainEvent, Function> get tasks => {};
}
