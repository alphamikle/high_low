import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../dto/stock_response.dart';
import 'crypto_provider.dart';

part 'crypto_provider_native.g.dart';

@RestApi(baseUrl: 'https://pro-api.coinmarketcap.com/v1/')
abstract class CryptoProviderNative implements CryptoProvider {
  factory CryptoProviderNative(Dio dio, {String? baseUrl}) = _CryptoProviderNative;

  @override
  @GET('cryptocurrency/listings/latest')
  Future<StockResponse> fetchLatestData({
    @Header('X-CMC_PRO_API_KEY') required String token,
    @Query('limit') int limit = 100,
  });
}
