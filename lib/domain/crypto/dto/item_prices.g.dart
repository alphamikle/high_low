// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_prices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemPrices _$ItemPricesFromJson(Map<String, dynamic> json) => ItemPrices(
      price: (json['price'] as num).toDouble(),
      diff1h: (json['percent_change_1h'] as num).toDouble(),
      diff24h: (json['percent_change_24h'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemPricesToJson(ItemPrices instance) =>
    <String, dynamic>{
      'price': instance.price,
      'percent_change_1h': instance.diff1h,
      'percent_change_24h': instance.diff24h,
    };
