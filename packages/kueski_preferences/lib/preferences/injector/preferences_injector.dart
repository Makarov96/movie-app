import 'package:mobile_dependencies/mobile_dependencies.dart';

extension PrefsInjector on Never {
  static final prefsProvider = Provider<SharedPreferences>((ref) {
    throw UnimplementedError();
  });

  static final favoriteMoviesCheckerProvider = Provider<FavoritesMoviesChecker>(
    (ref) => FavoritesMoviesChecker(preferences: ref.read(prefsProvider)),
  );
}
