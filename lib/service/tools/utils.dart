import 'package:intl/intl.dart';

abstract class Utils {
  static String formatAsCurrency(num value) {
    final formatter = NumberFormat.compactSimpleCurrency();
    return formatter.format(value);
  }
}
