import 'package:flutter/foundation.dart';
import 'package:high_low/service/logs/logs.dart';
import 'package:high_low/service/types/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_item.g.dart';

/*
{
  "currency": "USD",
  "description": "ENVIRONMENTAL CONTROL CORP",
  "displaySymbol": "EVCC",
  "figi": "BBG000HWWS67",
  "mic": "OOTC",
  "symbol": "EVCC",
  "type": "Common Stock"
}
 */
@immutable
@JsonSerializable()
class StockItem {
  const StockItem({
    required this.currency,
    required this.description,
    required this.displaySymbol,
    required this.figi,
    required this.mic,
    required this.symbol,
    required this.type,
  });

  factory StockItem.fromJson(Json json) => _$StockItemFromJson(json);

  final String currency;
  final String description;
  final String displaySymbol;
  final String figi;
  final String mic;
  final String symbol;
  final String type;

  Json toJson() => _$StockItemToJson(this);

  @override
  String toString() => prettyJson(toJson());
}
