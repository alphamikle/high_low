import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/types/types.dart';
import '../logic/coin_market_cap_ids.dart';

part 'stock_item.g.dart';

const String incorrectEmptyValue = '';
const double incorrectZeroValue = 0;

// BTC, ETH etc.
typedef CryptoSymbol = String;

/* Example of data:
{
        "id": "bitcoin",
        "symbol": "btc",
        "name": "Bitcoin",
        "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        "current_price": 49292,
        "market_cap": 932226871971,
        "market_cap_rank": 1,
        "fully_diluted_valuation": 1035408428052,
        "total_volume": 25703864582,
        "high_24h": 49366,
        "low_24h": 46791,
        "price_change_24h": 2247.03,
        "price_change_percentage_24h": 4.77636,
        "market_cap_change_24h": 43928781014,
        "market_cap_change_percentage_24h": 4.94527,
        "circulating_supply": 18907287.0,
        "total_supply": 21000000.0,
        "max_supply": 21000000.0,
        "ath": 69045,
        "ath_change_percentage": -28.58958,
        "ath_date": "2021-11-10T14:24:11.849Z",
        "atl": 67.81,
        "atl_change_percentage": 72611.82769,
        "atl_date": "2013-07-06T00:00:00.000Z",
        "roi": null,
        "last_updated": "2021-12-21T23:24:12.672Z",
        "price_change_percentage_24h_in_currency": 4.7763627622868485
    }
 */
@immutable
@JsonSerializable()
class StockItem {
  const StockItem({
    required this.name,
    required this.symbol,
    required this.price,
    required this.priceDiffInPercents,
  });

  factory StockItem.fromJson(Json json) => _$StockItemFromJson(json);

  @JsonKey(defaultValue: incorrectEmptyValue)
  final String name;

  @JsonKey(defaultValue: incorrectEmptyValue)
  final CryptoSymbol symbol;

  @JsonKey(name: 'current_price', defaultValue: incorrectZeroValue)
  final double price;

  @JsonKey(name: 'price_change_percentage_24h', defaultValue: incorrectZeroValue)
  final double priceDiffInPercents;

  String imageUrl(int size) {
    assert(size > 0 && size < 250);
    final int id = coinMarketCapIds[symbol.toUpperCase()] ?? 1;
    return 'https://s2.coinmarketcap.com/static/img/coins/${size}x$size/$id.png';
  }

  bool get isValid => name != incorrectEmptyValue && symbol != incorrectEmptyValue && price != incorrectZeroValue && priceDiffInPercents != incorrectZeroValue;

  Json toJson() => _$StockItemToJson(this);
}
