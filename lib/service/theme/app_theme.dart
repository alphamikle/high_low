import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppTheme {
  final BuildContext _context;

  AppTheme(this._context);

  static AppTheme of(BuildContext context, {bool listen = true}) {
    return Provider.of(context, listen: listen);
  }

  Color get headerColor {
    return const Color.fromRGBO(244, 244, 244, 1);
  }

  Color get inputColor {
    return const Color.fromRGBO(255, 230, 209, 1);
  }

  Color get titleColor {
    return const Color.fromRGBO(43, 48, 51, 1);
  }

  Color get subtitleColor {
    return const Color.fromRGBO(172, 174, 175, 1);
  }

  Color get priceUpColor {
    return const Color.fromRGBO(24, 181, 139, 1);
  }

  Color get priceDownColor {
    return const Color.fromRGBO(255, 70, 110, 1);
  }
}
