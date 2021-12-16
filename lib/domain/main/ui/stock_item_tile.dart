import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../service/theme/app_theme.dart';
import '../../../service/tools/utils.dart';
import '../../crypto/dto/stock_item.dart';

class StockItemTile extends StatelessWidget {
  const StockItemTile({
    required this.item,
    Key? key,
  }) : super(key: key);

  final StockItem item;

  @override
  Widget build(BuildContext context) {
    final TextStyle priceStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: item.usdPrices.diff24h >= 0 ? AppTheme.of(context).priceUpColor : AppTheme.of(context).priceDownColor,
      fontSize: 14,
    );
    final double price = item.usdPrices.price;
    final int zeros = Utils.countZeroAfterComma(price);
    final String prettyPrice = zeros == 0 ? Utils.formatAsCurrency(price) : '\$${price.toStringAsExponential(2)}';

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppTheme.of(context).headerColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Image.network(
                  item.imageUrl(128),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  item.symbol.toUpperCase(),
                  style: TextStyle(
                    color: AppTheme.of(context).titleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                item.name,
                style: TextStyle(
                  color: AppTheme.of(context).subtitleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            prettyPrice,
            style: priceStyle.copyWith(
              color: AppTheme.of(context).subtitleColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '${Utils.formatAsCurrency(item.usdPrices.diff24h, symbol: '')}%',
            style: priceStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
