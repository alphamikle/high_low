import 'dart:convert';

import 'package:logger/logger.dart' as logger;

String _getJoinedArguments(dynamic p1, [dynamic p2, dynamic p3]) {
  String result = p1.toString();
  result += p2 == null ? '' : ' ${p2.toString()}';
  result += p3 == null ? '' : ' ${p3.toString()}';
  return result;
}

String prettyJson(Map<String, dynamic> json) {
  const JsonEncoder jsonEncoder = JsonEncoder.withIndent(' ');
  return jsonEncoder.convert(json);
}

final _logger = logger.Logger(
  printer: logger.PrefixPrinter(
    logger.PrettyPrinter(
      colors: true,
      printEmojis: false,
      methodCount: 0,
      errorMethodCount: 3,
      stackTraceBeginIndex: 0,
    ),
  ),
);

abstract class Logs {
  static void debug(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.d(_getJoinedArguments(p1, p2, p3));
  }

  static void info(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.i(_getJoinedArguments(p1, p2, p3));
  }

  static void warn(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.w(_getJoinedArguments(p1, p2, p3));
  }

  static void error(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.e(_getJoinedArguments(p1, p2, p3));
  }

  static void fatal(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.wtf(_getJoinedArguments(p1, p2, p3));
  }

  static void trace(dynamic p1, [dynamic p2, dynamic p3]) {
    _logger.v(_getJoinedArguments(p1, p2, p3));
  }

  static void pad(dynamic p1, [dynamic p2, dynamic p3]) {
    print(_getJoinedArguments(p1, p2, p3));
  }
}
