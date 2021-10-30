import 'package:flutter/cupertino.dart';

class AppTheme {
  AppTheme.of(BuildContext context) : _context = context;

  final BuildContext _context;

  Color get headerColor {
    return const Color.fromRGBO(247, 247, 247, 1);
  }
}
