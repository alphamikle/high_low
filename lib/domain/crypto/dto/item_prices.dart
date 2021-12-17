import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/types/types.dart';

part 'item_prices.g.dart';

@immutable
@JsonSerializable()
class ItemPrices {
  const ItemPrices({
    required this.price,
    required this.diff1h,
    required this.diff24h,
  });

  factory ItemPrices.fromJson(Json json) => _$ItemPricesFromJson(json);

  final double price;

  @JsonKey(name: 'percent_change_1h')
  final double diff1h;

  @JsonKey(name: 'percent_change_24h')
  final double diff24h;

  Json toJson() => _$ItemPricesToJson(this);
}
