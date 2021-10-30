import 'dart:math';

import 'package:flutter/material.dart';
import 'package:high_low/domain/main/logic/main_frontend.dart';
import 'package:high_low/domain/main/ui/main_header.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    Provider.of<MainFrontend>(context, listen: false).launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, MainFrontend state, Widget? child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: state.isLaunching
              ? Center(
                  child: Text('Loading...'),
                )
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    child!,
                    for (int i = 0; i < 10; i++)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            color: Colors.red.withOpacity(0.15),
                            height: Random().nextDouble() * (100 - 80) + 80,
                          ),
                        ),
                      )
                  ],
                ),
        ),
        child: const MainHeader(),
      ),
    );
  }
}
