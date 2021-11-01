import 'package:flutter/cupertino.dart';
import 'package:high_low/service/logs/logs.dart';
import 'package:high_low/service/types/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_prices.g.dart';

/*
{
  "c": 261.74,
  "h": 263.31,
  "l": 260.68,
  "o": 261.07,
  "pc": 259.45,
  "t": 1582641000
}
 */
@immutable
@JsonSerializable()
class ItemPrices {
  const ItemPrices({
    this.currentPrice,
    this.change,
    this.percentChange,
    this.highestPriceOfTheDay,
    this.lowestPriceOfTheDay,
    this.openPriceOfTheDay,
    this.previousDayClosePrice,
    this.timestamp,
  });

  factory ItemPrices.fromJson(Json json) => _$ItemPricesFromJson(json);

  @JsonKey(name: 'c')
  final double? currentPrice;

  @JsonKey(name: 'd')
  final double? change;

  @JsonKey(name: 'dp')
  final double? percentChange;

  @JsonKey(name: 'h')
  final double? highestPriceOfTheDay;

  @JsonKey(name: 'l')
  final double? lowestPriceOfTheDay;

  @JsonKey(name: 'o')
  final double? openPriceOfTheDay;

  @JsonKey(name: 'pc')
  final double? previousDayClosePrice;

  @JsonKey(name: 't')
  final int? timestamp;

  Json toJson() => _$ItemPricesToJson(this);

  @override
  String toString() => prettyJson(toJson());
}
