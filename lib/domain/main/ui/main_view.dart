import 'package:flutter/material.dart';
import 'package:high_low/service/theme/app_theme.dart';
import 'package:isolator/next/frontend/frontend_event_subscription.dart';
import 'package:provider/provider.dart';
import 'package:yalo_locale/lib.dart';

import '../../crypto/dto/stock_item.dart';
import '../logic/main_frontend.dart';
import 'main_header.dart';
import 'stock_item_tile.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainFrontend get _mainFrontend => Provider.of(context);
  late final FrontendEventSubscription<MainEvent> _eventSubscription;

  Widget _stockItemBuilder(BuildContext context, int index) {
    final StockItem item = _mainFrontend.stocks[index];
    final bool isFirst = index == 0;
    final bool isLast = index == _mainFrontend.stocks.length - 1;

    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        top: isFirst ? 8 : 0,
        right: 8,
        bottom: isLast ? MediaQuery.of(context).padding.bottom + 8 : 8,
      ),
      child: StockItemTile(item: item),
    );
  }

  void _onLoadingDone(MainEvent event) {
    final AppTheme appTheme = AppTheme.of(context, listen: false);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: appTheme.titleColor,
        content: Text(
          Messages.of(context).main.search.result(Provider.of<MainFrontend>(context, listen: false).stocks.length),
          style: TextStyle(color: appTheme.headerColor),
        ),
      ),
    );
  }

  Future<void> _launchMainFrontend() async {
    final MainFrontend mainFrontend = Provider.of(context, listen: false);
    await mainFrontend.launch();
    await mainFrontend.loadStocks();
  }

  @override
  void initState() {
    super.initState();
    _launchMainFrontend();
    _eventSubscription = Provider.of<MainFrontend>(context, listen: false).subscribeOnEvent(
      listener: _onLoadingDone,
      event: MainEvent.updateFilteredStocks,
      onEveryEvent: true,
    );
  }

  @override
  void dispose() {
    _eventSubscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _mainFrontend.isLaunching
            ? Center(
                child: Text(Messages.of(context).main.loading),
              )
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const MainHeader(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      _stockItemBuilder,
                      childCount: _mainFrontend.stocks.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
