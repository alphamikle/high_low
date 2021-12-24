import 'package:flutter/material.dart';
import 'package:isolator/src/frontend/frontend_event_subscription.dart';
import 'package:provider/provider.dart';
import 'package:yalo_assets/lib.dart';
import 'package:yalo_locale/lib.dart';

import '../../../service/theme/app_theme.dart';
import '../../../service/tools/utils.dart';
import '../../crypto/dto/stock_item.dart';
import '../../notification/logic/notification_service.dart';
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

  void _onSearchEnd(MainEvent event) {
    final MainFrontend mainFrontend = Provider.of<MainFrontend>(context, listen: false);
    final LocalizationMessages loc = Messages.of(context);
    final int stocksCount = mainFrontend.stocks.length;
    final String content =
        mainFrontend.isSecretFounded ? loc.main.search.secret : loc.main.search.result(stocksCount);
    Provider.of<NotificationService>(context, listen: false).showSnackBar(
      content: content,
      backgroundColor: AppTheme.of(context, listen: false).okColor,
    );
  }

  Future<void> _launchMainFrontend() async {
    final MainFrontend mainFrontend = Provider.of(context, listen: false);
    await mainFrontend.launch(
        notificationService: Provider.of(context, listen: false),
        localizationWrapper: Provider.of(context, listen: false));
    await mainFrontend.loadStocks();
  }

  @override
  void initState() {
    super.initState();
    _launchMainFrontend();
    _eventSubscription = Provider.of<MainFrontend>(context, listen: false).subscribeOnEvent(
      listener: _onSearchEnd,
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
    final Assets assets = Provider.of<Assets>(context, listen: false);
    final AppTheme theme = AppTheme.of(context);
    final MaterialStateProperty<Color> buttonColor =
        MaterialStateProperty.resolveWith((states) => theme.buttonColor);
    final ButtonStyle buttonStyle = ButtonStyle(
      foregroundColor: buttonColor,
      overlayColor: MaterialStateProperty.resolveWith((states) => theme.splashColor),
      shadowColor: buttonColor,
    );
    final List<String> notFoundImages = [
      assets.notFound1,
      assets.notFound2,
      assets.notFound3,
      assets.notFound4,
    ].map((e) => e.replaceFirst('assets/', '')).toList();
    final List<String> secretImages = [
      assets.secret1,
      assets.secret2,
      assets.secret3,
      assets.secret4,
      assets.secret5,
      assets.secret6,
      assets.secret7,
      assets.secret8,
    ].map((e) => e.replaceFirst('assets/', '')).toList();

    Widget body;

    if (_mainFrontend.isLaunching) {
      body = Center(
        child: Text(Messages.of(context).main.loading),
      );
    } else if (_mainFrontend.errorOnLoadingStocks) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.asset(
                    notFoundImages[Utils.randomIntBetween(0, notFoundImages.length - 1)]),
              ),
              TextButton(
                onPressed: _mainFrontend.loadStocks,
                style: buttonStyle,
                child: Text(Messages.of(context).main.repeat),
              ),
            ],
          ),
        ),
      );
    } else if (_mainFrontend.isSecretFounded) {
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:
                    Image.asset(secretImages[Utils.randomIntBetween(0, secretImages.length - 1)]),
              ),
              TextButton(
                onPressed: _mainFrontend.resetSecret,
                style: buttonStyle,
                child: Text(Messages.of(context).main.repeat),
              ),
            ],
          ),
        ),
      );
    } else {
      body = CustomScrollView(
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
      );
    }

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: body,
      ),
    );
  }
}
