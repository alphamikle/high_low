import 'package:flutter/material.dart';
import 'package:high_low/domain/main/logic/main_frontend.dart';
import 'package:high_low/high_low_app.dart';
import 'package:high_low/service/di/registrations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return const HighLowApp();
  }
}
