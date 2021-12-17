import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/types/types.dart';
import 'item_prices.dart';

part 'stock_item.g.dart';

// BTC, ETH etc.
typedef CryptoSymbol = String;

/* Example of data:
{
  "id": 1,
  "name": "Bitcoin",
  "symbol": "BTC",
  "max_supply": 21000000,
  "circulating_supply": 18897568,
  "total_supply": 18897568,
  "platform": null,
  "cmc_rank": 1,
  "last_updated": "2021-12-11T03:44:02.000Z",
  "quote": {
    "USD": {
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
    }
  }
}
 */
@immutable
@JsonSerializable()
class StockItem {
  const StockItem({
    required this.id,
    required this.name,
    required this.symbol,
    required this.prices,
  });

  factory StockItem.fromJson(Json json) => _$StockItemFromJson(json);

  final int id;
  final String name;
  final CryptoSymbol symbol;

  @JsonKey(name: 'quote')
  final Map<CryptoSymbol, ItemPrices> prices;

  ItemPrices get usdPrices => prices['USD']!;

  String imageUrl(int size) {
    assert(size > 0 && size < 250);
    return 'https://s2.coinmarketcap.com/static/img/coins/${size}x$size/$id.png';
  }

  Json toJson() => _$StockItemToJson(this);
}
