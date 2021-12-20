import 'package:flutter/material.dart';
import 'package:high_low/service/ui/loaders/circle_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yalo_locale/lib.dart';

import '../../../service/theme/app_theme.dart';
import '../logic/main_frontend.dart';

const double _searchFieldHeight = 77;

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    print('TOP HEADER PADDING: $topPadding');
    return SliverPersistentHeader(
      floating: true,
      delegate: _MainHeaderDelegate(height: topPadding + _searchFieldHeight),
    );
  }
}

class _MainHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MainHeaderDelegate({
    required this.height,
  });

  final double height;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final MainFrontend mainFrontend = Provider.of(context);

    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
        style: BorderStyle.none,
        width: 1,
      ),
    );

    return Container(
      height: minExtent,
      color: AppTheme.of(context).headerColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: 8,
          top: MediaQuery.of(context).padding.top + 8,
          right: 8,
          bottom: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppTheme.of(context).inputColor,
                  border: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  errorBorder: border,
                  focusedBorder: border,
                  focusedErrorBorder: border,
                  isDense: true,
                  hintText: Messages.of(context).main.search.hint,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleIndicator(
                      color: AppTheme.of(context).titleColor,
                      visible: mainFrontend.isStocksLoading,
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 30,
                    maxWidth: 30,
                  ),
                ),
                style: TextStyle(
                  color: AppTheme.of(context).titleColor,
                  fontWeight: FontWeight.w500,
                ),
                controller: mainFrontend.searchController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleIndicator(
                  color: AppTheme.of(context).titleColor,
                  visible: mainFrontend.isStocksLoading || true,
                ),
              ),
            ),
 */
