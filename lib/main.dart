import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'domain/main/logic/main_frontend.dart';
import 'domain/main/ui/mock_list.dart';
import 'high_low_app.dart';
import 'service/di/registrations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainFrontend()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return true
        ? const MaterialApp(
            title: 'High Low',
            home: const MockList(),
          )
        : const HighLowApp();
  }
}
