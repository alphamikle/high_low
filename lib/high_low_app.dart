import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:yalo_locale/lib.dart';

import 'service/di/di.dart';

class HighLowApp extends StatelessWidget {
  const HighLowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // DevicePreview settings
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // Other params
      routeInformationParser: Di.get<RouteInformationParser<Object>>(),
      routerDelegate: Di.get<RouterDelegate<Object>>(),
      backButtonDispatcher: Di.get<BackButtonDispatcher>(),
      theme: Theme.of(context).copyWith(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      onGenerateTitle: (BuildContext context) => Messages.of(context).common.appTitle,
    );
  }
}
