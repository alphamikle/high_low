import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalo_locale/lib.dart';

import 'service/di/di.dart';
import 'service/theme/app_theme.dart';

class HighLowApp extends StatelessWidget {
  const HighLowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      // DevicePreview settings
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // Other params
      routeInformationParser: Di.get<RouteInformationParser<Object>>(),
      routerDelegate: Di.get<RouterDelegate<Object>>(),
      backButtonDispatcher: Di.get<BackButtonDispatcher>(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: Theme.of(context).copyWith(
        splashColor: AppTheme(context).titleColor,
        splashFactory: InkRipple.splashFactory,
        textTheme: GoogleFonts.exo2TextTheme(textTheme),
      ),
      onGenerateTitle: (BuildContext context) => Messages.of(context).common.appTitle,
    );
  }
}
