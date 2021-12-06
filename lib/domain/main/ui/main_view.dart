import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../finhub/dto/stock_item.dart';
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

  Widget _stockItemBuilder(BuildContext context, int index) {
    final StockItem item = _mainFrontend.stocks[index];
    final bool isFirst = index == 0;
    final bool isLast = index == _mainFrontend.stocks.length - 1;
    _mainFrontend.loadStockItemPrice(item.symbol);

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

  @override
  void initState() {
    super.initState();
    final MainFrontend mainFrontend = Provider.of(context, listen: false);
    mainFrontend.launch().then((_) => mainFrontend.loadStocks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, MainFrontend state, Widget? child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: state.isLaunching
              ? const Center(
                  child: Text('Loading...'),
                )
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    child!,
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        _stockItemBuilder,
                        childCount: _mainFrontend.stocks.length,
                      ),
                    ),
                  ],
                ),
        ),
        child: const MainHeader(),
      ),
    );
  }
}
