import 'package:high_low/domain/finhub/logic/finhub_provider.dart';
import 'package:high_low/domain/main/dto/stock_item.dart';
import 'package:high_low/domain/main/logic/main_frontend.dart';
import 'package:isolator/isolator.dart';

class MainBackend extends Backend<MainEvent> {
  MainBackend({
    required BackendArgument<void> argument,
    required FinhubProvider finHubProvider,
  })  : _finHubProvider = finHubProvider,
        super(argument);

  final FinhubProvider _finHubProvider;

  Future<void> _loadStocks() async {
    final List<StockItem> stocks = await _finHubProvider.fetchListOfStocks();
    sendChunks(MainEvent.loadStocks, stocks);
  }

  @override
  Map<MainEvent, Function> get operations => {
        MainEvent.loadStocks: _loadStocks,
      };
}
