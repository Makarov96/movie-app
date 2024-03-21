import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kueski_challenge/core/injector/environment.dart';

import 'package:kueski_challenge/core/injector/providers.dart';

List<Override> overrides(Environment env) => [
      Providers.enviroment.overrideWithValue(env),
    ];
