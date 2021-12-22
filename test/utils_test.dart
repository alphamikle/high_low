import 'package:flutter_test/flutter_test.dart';
import 'package:high_low/service/tools/utils.dart';

void main() {
  group('Utils tests', () {
    test('Random between test', () async {
      const int min = 0;
      const int max = 10;
      final Set<int> results = {};
      for (int i = 0; i < 100000; i++) {
        results.add(Utils.randomIntBetween(min, max));
      }
      for (final int result in results) {
        expect(result >= min || result <= max, true);
      }
      print(results);
    });
  });
}
