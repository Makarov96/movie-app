import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

extension SplashListener on Never {
  static listener(previus, current, BuildContext context, WidgetRef ref) {
    if (ref
        .read(PrefsInjector.favoriteMoviesCheckerProvider)
        .getShowFavoriteScreen()) {
      context.pushReplacementNamed(const Routes.movie().name);
      return;
    }

    if (current.value.isNotEmpty) {
      context.pushReplacementNamed(
        const Routes.movieRecommended().name,
        extra: true,
      );
      return;
    } else {
      context.pushReplacementNamed(const Routes.movie().name);
      return;
    }
  }
}
