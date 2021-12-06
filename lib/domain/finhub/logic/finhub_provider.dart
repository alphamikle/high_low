import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../dto/item_prices.dart';
import '../dto/stock_item.dart';

part 'finhub_provider.g.dart';

@RestApi(baseUrl: 'https://finnhub.io/api/v1/')
abstract class FinhubProvider {
  factory FinhubProvider(Dio dio, {String? baseUrl}) = _FinhubProvider;

  @GET('stock/symbol')
  Future<List<StockItem>> fetchListOfStocks({
    @Query('token') required String token,
    @Query('exchange') required String exchange,
  });

  @GET('/quote')
  Future<ItemPrices> fetchStockItemPrices({
    @Query('token') required String token,
    @Query('symbol') required String symbol,
  });
}
