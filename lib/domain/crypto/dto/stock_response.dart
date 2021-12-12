import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/types/types.dart';
import 'stock_item.dart';

part 'stock_response.g.dart';

@immutable
@JsonSerializable()
class StockResponse {
  const StockResponse({
    required this.data,
  });

  factory StockResponse.fromJson(Json json) => _$StockResponseFromJson(json);

  final List<StockItem> data;

  Json toJson() => _$StockResponseToJson(this);
}

/*
{
    "status": {
        "timestamp": "2021-12-11T03:45:45.907Z",
        "error_code": 0,
        "error_message": null,
        "elapsed": 27,
        "credit_count": 1,
        "notice": null,
        "total_count": 8169
    },
    "data": [
        {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "slug": "bitcoin",
            "num_market_pairs": 8257,
            "date_added": "2013-04-28T00:00:00.000Z",
            "tags": [
            ...
 */
