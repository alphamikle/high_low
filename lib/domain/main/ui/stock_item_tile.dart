import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/theme/app_theme.dart';
import '../../../service/ui/loaders/circle_indicator.dart';
import '../../finhub/dto/item_prices.dart';
import '../../finhub/dto/stock_item.dart';
import '../logic/main_frontend.dart';

class StockItemTile extends StatelessWidget {
  const StockItemTile({
    required this.item,
    Key? key,
  }) : super(key: key);

  final StockItem item;

  @override
  Widget build(BuildContext context) {
    final MainFrontend mainFrontend = Provider.of(context);
    final bool isWaitingForStartOfLoading = mainFrontend.pricesOperationsWaitingQueue.contains(item.symbol);
    final bool isLoading = mainFrontend.pricesOperationsLoadingQueue.contains(item.symbol);
    final ItemPrices? prices = mainFrontend.prices[item.symbol]?.prices;
    final TextStyle priceStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: AppTheme.of(context).textColor,
      fontSize: 12,
    );

    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppTheme.of(context).headerColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              item.symbol,
              style: TextStyle(
                color: AppTheme.of(context).textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 1,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.description,
              style: TextStyle(
                color: AppTheme.of(context).textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              item.type,
              style: TextStyle(
                color: AppTheme.of(context).textColorSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isWaitingForStartOfLoading && !isLoading
                ? const CircleIndicator(color: Colors.grey)
                : isWaitingForStartOfLoading && isLoading
                    ? const CircleIndicator(color: Colors.blue)
                    : prices == null
                        ? const SizedBox()
                        : prices.currentPrice == null
                            ? Text(
                                '-',
                                style: priceStyle,
                              )
                            : Text(
                                prices.currentPrice!.toString(),
                                style: priceStyle,
                              ),
          ),
        ),
      ],
    );
  }
}
