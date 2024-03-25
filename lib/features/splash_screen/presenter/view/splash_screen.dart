import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/router.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static Widget builder(BuildContext _, GoRouterState state) =>
      const SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      MovieInjector.getFavoriteMovies,
      (previus, current) {
        if (current.items.isNotEmpty) {
          context.pushReplacementNamed(const Routes.movieRecommended().name,
              extra: true);
          return;
        } else {
          context.pushReplacementNamed(const Routes.movie().name);
          return;
        }
      },
    );
    return const Scaffold(
      body: Center(
        child: ErrorOrLoadingLayout(),
      ),
    );
  }
}
