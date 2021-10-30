import 'package:flutter/material.dart';
import 'package:high_low/domain/main/logic/main_frontend.dart';
import 'package:high_low/service/theme/app_theme.dart';
import 'package:provider/provider.dart';

const double _headerHeight = 120;

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(delegate: _MainHeaderDelegate());
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
    return Container(
      height: minExtent,
      color: true ? Colors.green : AppTheme.of(context).headerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<MainFrontend>(context, listen: false).loadStocks();
              },
              child: Consumer(
                builder: (BuildContext context, MainFrontend state, Widget? child) => Text(
                  state.isStocksLoading ? 'Loading...' : 'Load stocks',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
