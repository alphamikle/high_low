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

/*
                    "price": 48394.083464545605,
                    "volume_24h": 32477191827.784477,
                    "volume_change_24h": 7.5353,
                    "percent_change_1h": 0.3400355,
                    "percent_change_24h": 0.05623531,
                    "percent_change_7d": -7.88809336,
                    "percent_change_30d": -25.12367453,
                    "percent_change_60d": -14.67776793,
                    "percent_change_90d": 6.86740691,
                    "market_cap": 914530483068.9261,
                    "market_cap_dominance": 40.8876,
                    "fully_diluted_market_cap": 1016275752755.46,
                    "last_updated": "2021-12-11T03:44:02.000Z"
 */
