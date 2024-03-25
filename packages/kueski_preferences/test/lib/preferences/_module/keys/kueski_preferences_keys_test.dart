import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_preferences/preferences/_module/keys/kueski_preferences_keys.dart';

void main() {
  group('KueskiPreferencesKey', () {
    test('showScreen key is correct', () {
      expect(KueskiPreferencesKey.showScreen, 'show-screen');
    });
  });
}
