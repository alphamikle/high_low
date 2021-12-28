// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockItem _$StockItemFromJson(Map<String, dynamic> json) => StockItem(
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      price: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      priceDiffInPercents:
          (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$StockItemToJson(StockItem instance) => <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'current_price': instance.price,
      'price_change_percentage_24h': instance.priceDiffInPercents,
    };
