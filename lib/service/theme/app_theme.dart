import 'package:flutter/cupertino.dart';

class AppTheme {
  AppTheme.of(BuildContext context) : _context = context;

  final BuildContext _context;

  Color get headerColor {
    return const Color.fromRGBO(244, 244, 244, 1);
  }

  Color get inputColor {
    return const Color.fromRGBO(255, 230, 209, 1);
  }

  Color get textColor {
    return const Color.fromRGBO(43, 48, 51, 1);
  }

  Color get textColorSecondary {
    return const Color.fromRGBO(174, 176, 177, 1);
  }
}
