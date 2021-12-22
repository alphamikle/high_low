import 'dart:async';

import '../../crypto/logic/crypto_provider.dart';
import 'package:isolator/isolator.dart';

import '../../crypto/dto/stock_item.dart';
import 'main_frontend.dart';

typedef StockItemFilter = bool Function(StockItem);

class MainBackend extends Backend {
  MainBackend({
    required BackendArgument<void> argument,
    required CryptoProvider cryptoProvider,
  })  : _cryptoProvider = cryptoProvider,
        super(argument: argument);

  final CryptoProvider _cryptoProvider;
  final List<StockItem> _stocks = [];
  Timer? _searchTimer;

  Future<ActionResponse<StockItem>> _loadStocks({required MainEvent event, void data}) async {
    await send(event: MainEvent.startLoadingStocks, sendDirectly: true);
    try {
      final List<StockItem> stockItems = await _cryptoProvider.fetchLatestData();
      _stocks.clear();
      _stocks.addAll(stockItems);
    } catch (error) {
      await send(event: MainEvent.endLoadingStocks, sendDirectly: true);
      rethrow;
    }
    await send(event: MainEvent.endLoadingStocks, sendDirectly: true);
    return ActionResponse.list(_stocks);
  }

  ActionResponse<StockItem> _filterStocks({required MainEvent event, required String data}) {
    final String searchSubString = data;
    send(event: MainEvent.startLoadingStocks);
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      _searchTimer = null;
      final List<StockItem> filteredStocks = _stocks.where(_stockFilterPredicate(searchSubString)).toList();
      await send(
        event: MainEvent.updateFilteredStocks,
        data: ActionResponse.list(filteredStocks),
      );
      await send(event: MainEvent.endLoadingStocks);
    });
    return ActionResponse.empty();
  }

  StockItemFilter _stockFilterPredicate(String searchSubString) {
    final RegExp filterRegExp = RegExp(searchSubString, caseSensitive: false, unicode: true);
    return (StockItem item) {
      if (searchSubString.isEmpty) {
        return true;
      }
      return filterRegExp.hasMatch(item.symbol) || filterRegExp.hasMatch(item.name);
    };
  }

  @override
  void initActions() {
    whenEventCome(MainEvent.loadStocks).run(_loadStocks);
    whenEventCome(MainEvent.filterStocks).run(_filterStocks);
  }
}
