import 'logs.dart';

const int LOG_PADDING = 70;

class _Benchmark {
  final Map<String, int> _starts = <String, int>{};

  void start(dynamic id) {
    final String benchId = id.toString();
    if (_starts.containsKey(benchId)) {
      Logs.warn('Benchmark already have comparing with id=$benchId in time');
    } else {
      _starts[benchId] = DateTime.now().microsecondsSinceEpoch;
    }
  }

  double end(dynamic id) {
    final String benchId = id.toString();
    if (!_starts.containsKey(benchId)) {
      throw Exception('In Benchmark not placed comparing with id=$benchId');
    }
    final double diff = (DateTime.now().microsecondsSinceEpoch - _starts[benchId]!) / 1000;
    Logs.trace('$benchId need ${diff}ms');
    _starts.remove(benchId);
    return diff;
  }
}

final _Benchmark bench = _Benchmark();
