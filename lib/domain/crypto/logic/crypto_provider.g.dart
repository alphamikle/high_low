// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CryptoProvider implements CryptoProvider {
  _CryptoProvider(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://pro-api.coinmarketcap.com/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<StockResponse> fetchLatestData({required token, limit = 100}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'limit': limit};
    final _headers = <String, dynamic>{r'X-CMC_PRO_API_KEY': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<StockResponse>(Options(method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options, 'cryptocurrency/listings/latest', queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    bench.start('STOCK RESPONSE DESERIALIZING');
    final value = StockResponse.fromJson(_result.data!);
    bench.end('STOCK RESPONSE DESERIALIZING');
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
