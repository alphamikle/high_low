import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainFrontend()),
        Provider(create: (BuildContext context) => AppTheme(context)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HighLowApp();
  }
}
