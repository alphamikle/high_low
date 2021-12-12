import 'dart:async';

import 'package:high_low/domain/crypto/dto/stock_response.dart';
import 'package:isolator/isolator.dart';

import '../../../service/config/config.dart';
import '../../../service/logs/benchmark.dart';
import '../../crypto/dto/stock_item.dart';
import '../../crypto/logic/crypto_provider.dart';
import 'main_frontend.dart';

typedef StockItemFilter = bool Function(StockItem);

class MainBackend extends Backend {
  MainBackend({
    required BackendArgument<void> argument,
    required CryptoProvider CryptoProvider,
  })  : _cryptoProvider = CryptoProvider,
        super(argument: argument);

  final CryptoProvider _cryptoProvider;
  final List<StockItem> _stocks = [];
  Timer? _searchTimer;
  String _prevSearchSubString = '';

  Future<ActionResponse<void>> _loadStocks({required MainEvent event, void data}) async {
    await send(event: MainEvent.startLoadingStocks);
    final StockResponse response = await _cryptoProvider.fetchLatestData(token: Config.apiToken);
    final List<StockItem> stocks = response.data;
    _stocks.clear();
    _stocks.addAll(stocks);
    bench.start('Send ${_stocks.length} items');
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
        sendDirectly: false,
      );
    }
    bench.end('Send ${_stocks.length} items');
    await send(event: MainEvent.endLoadingStocks, sendDirectly: true);
    return ActionResponse.empty();
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
      await send(
        event: MainEvent.filterStocks,
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
