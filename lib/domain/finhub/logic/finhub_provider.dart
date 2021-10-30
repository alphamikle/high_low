import 'package:dio/dio.dart';
import 'package:high_low/domain/main/dto/stock_item.dart';
import 'package:high_low/service/config/config.dart';

class FinhubProvider {
  FinhubProvider({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<StockItem>> fetchListOfStocks() async {
    final Response<dynamic> response = await _dio.get('https://finnhub.io/api/v1/stock/symbol?exchange=US&token=${Config.finhubToken}');
    final List<StockItem> items = (response.data as List<dynamic>).map((me) => StockItem.fromJson(me)).toList();
    return items;
  }
}
