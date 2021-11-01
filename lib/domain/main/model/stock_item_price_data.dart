import 'package:flutter/cupertino.dart';
import 'package:high_low/domain/finhub/dto/item_prices.dart';
import 'package:high_low/domain/finhub/dto/stock_item.dart';
import 'package:high_low/service/logs/logs.dart';
import 'package:high_low/service/types/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_item_price_data.g.dart';

@immutable
@JsonSerializable()
class StockItemPriceData {
  const StockItemPriceData({
    required this.createdAt,
    required this.stockItem,
    required this.prices,
  });

  factory StockItemPriceData.fromJson(Json json) => _$StockItemPriceDataFromJson(json);

  final DateTime createdAt;
  final StockItem stockItem;
  final ItemPrices prices;

  Json toJson() => _$StockItemPriceDataToJson(this);

  @override
  String toString() => prettyJson(toJson());
}
