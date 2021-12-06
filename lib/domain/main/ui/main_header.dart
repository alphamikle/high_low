import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/theme/app_theme.dart';
import '../../../service/ui/loaders/circle_indicator.dart';
import '../logic/main_frontend.dart';

const double _headerHeight = 130;

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: _MainHeaderDelegate(),
    );
  }
}

class _MainHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => _headerHeight;

  @override
  double get minExtent => _headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final MainFrontend mainFrontend = Provider.of(context, listen: false);

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
        child: Stack(
          children: [
            TextFormField(
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
                hintText: 'Search',
              ),
              style: TextStyle(
                color: AppTheme.of(context).textColor,
                fontWeight: FontWeight.w500,
              ),
              controller: mainFrontend.searchController,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Consumer(
                  builder: (BuildContext context, MainFrontend state, Widget? child) => CircleIndicator(
                    color: AppTheme.of(context).textColor,
                    visible: state.isStocksLoading,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
