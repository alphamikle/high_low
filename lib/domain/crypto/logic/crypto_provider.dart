import 'package:dio/dio.dart';
import 'package:high_low/domain/crypto/dto/stock_response.dart';
import 'package:high_low/service/logs/benchmark.dart';
import 'package:retrofit/http.dart';

part 'crypto_provider.g.dart';

@RestApi(baseUrl: 'https://pro-api.coinmarketcap.com/v1/')
abstract class CryptoProvider {
  factory CryptoProvider(Dio dio, {String? baseUrl}) = _CryptoProvider;

  @GET('cryptocurrency/listings/latest')
  Future<StockResponse> fetchLatestData({
    @Header('X-CMC_PRO_API_KEY') required String token,
    @Query('limit') int limit = 100,
  });
}
