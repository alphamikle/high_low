import 'package:flutter/material.dart';
import 'package:high_low/high_low_app.dart';
import 'package:high_low/service/di/registrations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HighLowApp();
  }
}
