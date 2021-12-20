import '../dto/stock_response.dart';

abstract class CryptoProvider {
  Future<StockResponse> fetchLatestData({
    required String token,
    int limit = 100,
  });
}
