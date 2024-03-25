import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

void main() {
  group('FavoritesMoviesChecker with Riverpod', () {
    test('reads from overridden prefsProvider', () async {
      SharedPreferences.setMockInitialValues(
          {KueskiPreferencesKey.showScreen: true});
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          PrefsInjector.prefsProvider.overrideWith((ref) => sharedPreferences),
        ],
      );

      final checker =
          container.read(PrefsInjector.favoriteMoviesCheckerProvider);

      await checker.saveShowFavoriteScreen(show: true);

      expect(checker.getShowFavoriteScreen(), true);
    });
  });
}
