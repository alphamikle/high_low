import 'package:flutter/material.dart';
import '../../../service/theme/app_theme.dart';

class NotificationService {
  factory NotificationService({
    required ScaffoldMessengerState scaffoldMessenger,
    required AppTheme appTheme,
  }) =>
      _instance ??= NotificationService._(scaffoldMessenger: scaffoldMessenger, appTheme: appTheme);

  NotificationService._({
    required ScaffoldMessengerState scaffoldMessenger,
    required AppTheme appTheme,
  })  : _scaffoldMessenger = scaffoldMessenger,
        _appTheme = appTheme;

  static NotificationService? _instance;
  final ScaffoldMessengerState _scaffoldMessenger;
  final AppTheme _appTheme;

  Future<void> showSnackBar({
    required String content,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
  }) async {
    _scaffoldMessenger.hideCurrentSnackBar();
    _scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor ?? _appTheme.errorColor,
        duration: duration,
      ),
    );
  }
}
