import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kueski_challenge/app/view/app.dart';
import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/core/injector/overrides.dart';
import 'package:kueski_challenge/features/splash_screen/domain/injector/splash_injector.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

Future<void> bootstrap(Environment environment) async {
  final enableLogging = environment.enableLogging;
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final prefs = await SharedPreferences.getInstance();

      LocaleSettings.useDeviceLocale();
      GoRouter.optionURLReflectsImperativeAPIs = true;
      final container =
          ProviderContainer(overrides: overrides(environment, prefs));
      container.read(SplashInjector.checker);
      final app = UncontrolledProviderScope(
        container: container,
        child: TranslationProvider(child: const App()),
      );

      runApp(app);
      FlutterError.onError = (details) {
        if (enableLogging) {
          log(details.exceptionAsString(), stackTrace: details.stack);
        }
      };
    },
    (error, stack) {
      if (enableLogging) {
        log(error.toString(), stackTrace: stack);
      }
    },
  );
}
