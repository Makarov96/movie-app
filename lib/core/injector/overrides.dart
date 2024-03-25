import 'package:kueski_challenge/core/injector/environment.dart';

import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

List<Override> overrides(Environment env, SharedPreferences prefs) => [
      Providers.enviroment.overrideWithValue(env),
      PrefsInjector.prefsProvider.overrideWithValue(prefs),
    ];
