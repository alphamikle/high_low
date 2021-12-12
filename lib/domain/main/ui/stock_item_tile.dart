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
      color: AppTheme.of(context).textColor.withOpacity(0.5),
      fontSize: 12,
    );

    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: AppTheme.of(context).headerColor,
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
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            item.name,
            style: TextStyle(
              color: AppTheme.of(context).textColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              Utils.formatAsCurrency(item.usdPrices.price),
              style: priceStyle,
            ),
          ),
        ),
      ],
    );
  }
}
