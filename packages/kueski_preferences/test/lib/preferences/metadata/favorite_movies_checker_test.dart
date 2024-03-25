import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late FavoritesMoviesChecker checker;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    checker = FavoritesMoviesChecker(preferences: mockSharedPreferences);
  });

  group('saveShowFavoriteScreen', () {
    test('calls setBool with correct key and value', () async {
      const show = true;
      checker.saveShowFavoriteScreen(show: show);

      verify(() => mockSharedPreferences.setBool(
          KueskiPreferencesKey.showScreen, show)).called(1);
    });

    test('logs error if setBool throws', () async {
      try {
        when(() => mockSharedPreferences.setBool(any(), any()))
            .thenThrow(Exception('Error'));
      } catch (e) {
        checker.saveShowFavoriteScreen(show: true);

        verify(() => log('Exception: Error')).called(1);
      }
    });
  });

  group('getShowFavoriteScreen', () {
    test('calls getBool with correct key', () {
      checker.getShowFavoriteScreen();

      verify(() =>
              mockSharedPreferences.getBool(KueskiPreferencesKey.showScreen))
          .called(1);
    });

    test('returns false if getBool throws', () {
      try {
        when(() => mockSharedPreferences.getBool(any()))
            .thenThrow(Exception('Error'));
      } catch (e) {
        expect(checker.getShowFavoriteScreen(), false);
        verify(() => log('Exception: Error')).called(1);
      }
    });

    test('returns false if getBool returns null', () {
      when(() => mockSharedPreferences.getBool(any())).thenReturn(null);

      expect(checker.getShowFavoriteScreen(), false);
    });

    test('returns true if getBool returns true', () {
      when(() => mockSharedPreferences.getBool(any())).thenReturn(true);

      expect(checker.getShowFavoriteScreen(), true);
    });
  });
}
