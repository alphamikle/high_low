import 'dart:convert';

import 'package:dio/dio.dart';

import '../dto/stock_response.dart';
import 'crypto_provider.dart';

class CryptoProviderWeb implements CryptoProvider {
  CryptoProviderWeb(this.dio, {this.baseUrl});

  final Dio dio;
  final String? baseUrl;

  @override
  Future<StockResponse> fetchLatestData({required String token, int limit = 100}) async {
    final json = {
      'method': 'GET',
      'url': 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=$limit',
      'apiNode': 'US',
      'contentType': '',
      'content': '',
      'headers': 'X-CMC_PRO_API_KEY: $token',
      'errors': '',
      'curlCmd': "curl --location --request GET 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=$limit' --header 'X-CMC_PRO_API_KEY: $token'",
      'codeCmd': '',
      'lang': '',
      'auth': {'auth': 'noAuth', 'bearerToken': '', 'basicUsername': '', 'basicPassword': '', 'customHeader': '', 'encrypted': ''},
      'compare': false,
      'idnUrl': 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=$limit'
    };
    final response = await dio.post('https://apius.reqbin.com/api/v1/requests', data: {
      'id': '0',
      'name': '',
      'errors': '',
      'json': jsonEncode(json),
      'deviceId': '',
      'sessionId': '',
    });
    return StockResponse.fromJson(jsonDecode(response.data['Content']));
  }
}
