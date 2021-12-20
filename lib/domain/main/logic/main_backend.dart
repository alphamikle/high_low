import 'dart:async';

import 'package:isolator/isolator.dart';

import '../../../service/config/config.dart';
import '../../crypto/dto/stock_item.dart';
import '../../crypto/dto/stock_response.dart';
import '../../crypto/logic/crypto_provider.dart';
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

  Future<ActionResponse<void>> _loadStocks({required MainEvent event, void data}) async {
    await send(event: MainEvent.startLoadingStocks, sendDirectly: true);
    late final StockResponse response;
    try {
      response = await _cryptoProvider.fetchLatestData(token: Config.apiToken);
    } catch (error) {
      // Handle error
      print(error);
      rethrow;
    }
    final List<StockItem> stocks = response.data;
    _stocks.clear();
    _stocks.addAll(stocks);
    const bool sendViaChunks = false;
    if (sendViaChunks) {
      await send(
        event: MainEvent.loadStocks,
        data: ActionResponse.chunks(
          Chunks(
            data: _stocks,
            updateAfterFirstChunk: true,
            size: 100,
            delay: const Duration(milliseconds: 8),
          ),
        ),
      );
    } else {
      await send(
        event: MainEvent.loadStocks,
        data: ActionResponse.list(_stocks),
      );
    }
    await send(event: MainEvent.endLoadingStocks, sendDirectly: true);
    return ActionResponse.empty();
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
    final String query = searchSubString.toLowerCase();
    return (StockItem item) {
      if (searchSubString.isEmpty) {
        return true;
      }
      return item.symbol.toLowerCase().contains(query) || item.name.toLowerCase().contains(query);
    };
  }

  @override
  void initActions() {
    whenEventCome(MainEvent.loadStocks).run(_loadStocks);
    whenEventCome(MainEvent.filterStocks).run(_filterStocks);
  }
}
