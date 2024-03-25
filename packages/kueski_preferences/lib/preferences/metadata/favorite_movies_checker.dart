import 'dart:developer';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class FavoritesMoviesChecker {
  final SharedPreferences _preferences;

  FavoritesMoviesChecker({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  Future<void> saveShowFavoriteScreen({required bool show}) async {
    try {
      await _preferences.setBool(KueskiPreferencesKey.showScreen, show);
      await _preferences.reload();
    } catch (e) {
      log(e.toString());
    }
  }

  bool getShowFavoriteScreen() {
    try {
      return _preferences.getBool(KueskiPreferencesKey.showScreen) ?? false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
