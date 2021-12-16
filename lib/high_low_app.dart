import 'package:flutter/material.dart';

import 'service/di/di.dart';

class HighLowApp extends StatelessWidget {
  const HighLowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'High Low',
      routeInformationParser: Di.get<RouteInformationParser<Object>>(),
      routerDelegate: Di.get<RouterDelegate<Object>>(),
      backButtonDispatcher: Di.get<BackButtonDispatcher>(),
      theme: ThemeData.light(),
    );
  }
}
