import 'package:intl/intl.dart';

abstract class Utils {
  static String formatAsCurrency(num value, {int digits = 2}) {
    final formatter = NumberFormat.compactSimpleCurrency(decimalDigits: digits);
    return formatter.format(value);
  }
}
