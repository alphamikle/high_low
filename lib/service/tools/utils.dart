import 'dart:math';

import 'package:intl/intl.dart';

abstract class Utils {
  static String formatAsCurrency(num value, {int digits = 2, String? symbol}) {
    final formatter = NumberFormat.compactSimpleCurrency(decimalDigits: digits, name: symbol);
    return formatter.format(value);
  }

  static int countZeroAfterComma(num value) {
    final RegExp zeroRegExp = RegExp(r'^0[.,](?<zero>0+)\d+$');
    final RegExpMatch? match = zeroRegExp.firstMatch(value.toString());
    final String? zeroMatch = match?.namedGroup('zero');
    if (zeroMatch == null || zeroMatch.isEmpty) {
      return 0;
    }
    return zeroMatch.length;
  }

  static int randomIntBetween(int from, int to) {
    assert(from <= to);
    final double random = Random().nextDouble();
    return from + (random * (to - from + 1)).floor();
  }
}
