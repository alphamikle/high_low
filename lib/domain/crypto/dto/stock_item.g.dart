// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockItem _$StockItemFromJson(Map<String, dynamic> json) => StockItem(
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      prices: (json['quote'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ItemPrices.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$StockItemToJson(StockItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'quote': instance.prices,
    };
