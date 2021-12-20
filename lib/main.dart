import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:high_low/service/di/di.dart';
import 'package:high_low/service/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'domain/main/logic/main_frontend.dart';
import 'high_low_app.dart';
import 'service/di/registrations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  initDependencies();
  runApp(
    DevicePreview(
      enabled: kIsWeb || Platform.isWindows,
      builder: (BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Di.get<MainFrontend>()),
          Provider(create: (BuildContext context) => AppTheme(context)),
        ],
        child: const HighLowApp(),
      ),
    ),
  );
}
