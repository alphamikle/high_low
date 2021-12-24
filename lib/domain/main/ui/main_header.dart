import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalo_locale/lib.dart';

import '../../../service/theme/app_theme.dart';
import '../../../service/ui/inputs/text_input.dart';
import '../../../service/ui/loaders/circle_indicator.dart';
import '../logic/main_frontend.dart';

const double _searchFieldHeight = 77;

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: _MainHeaderDelegate(height: MediaQuery.of(context).padding.top + _searchFieldHeight),
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
        child: TextInput(
          hint: Messages.of(context).main.search.hint,
          controller: mainFrontend.searchController,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleIndicator(
              color: AppTheme.of(context).titleColor,
              visible: mainFrontend.isStocksLoading,
            ),
          ),
          backgroundColor: AppTheme.of(context).inputColor,
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
