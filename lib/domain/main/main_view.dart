import 'dart:math';

import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('High Low'),
          ),
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
    );
  }
}
