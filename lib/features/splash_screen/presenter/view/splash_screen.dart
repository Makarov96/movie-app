import 'package:flutter/material.dart';

import 'package:kueski_challenge/features/splash_screen/domain/injector/splash_injector.dart';
import 'package:kueski_challenge/features/splash_screen/presenter/listeners/splash_listener.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static Widget builder(BuildContext _, GoRouterState state) =>
      const SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      SplashInjector.checker,
      (previus, current) =>
          SplashListener.listener(previus, current, context, ref),
    );
    return const Scaffold(
      body: Center(
        child: ErrorOrLoadingLayout(),
      ),
    );
  }
}
