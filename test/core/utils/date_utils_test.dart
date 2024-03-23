import 'package:flutter_test/flutter_test.dart';

import 'package:kueski_challenge/core/utils/date_utils.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

void main() {
  group('DateTimeFormatter tests', () {
    test('formattedDate returns the current date in yyyy-MM-dd format', () {
      // Stub DateTime.now() to control the returned value for testing
      final now = DateFormat('yyyy-MM-dd').format(DateTime.now());

      expect(DateTimeFormatter.formattedDate, now);
    });
  });

  group('DateTimeExtension tests', () {
    test('yyyymmddFromat returns the date in yyyy-MM-dd format', () {
      final dateTime = DateTime(2024, 03, 22);
      expect(dateTime.yyyymmddFromat, '2024-03-22');
    });
  });
}
