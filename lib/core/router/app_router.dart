import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/view/movie_home.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_detail/presenter/view/movie_detail_view.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_recomended/presenter/view/movie_recomended_screen.dart';
import 'package:kueski_challenge/features/splash_screen/presenter/view/splash_screen.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: const Routes.splash().path,
      routes: AppRouter.routes,
    );
  },
);

final class AppRouter {
  const AppRouter._();

  static List<GoRoute> get routes => [
        GoRoute(
          path: const Routes.splash().path,
          name: const Routes.splash().name,
          builder: SplashScreen.builder,
        ),
        GoRoute(
          path: const Routes.movieRecommended().path,
          name: const Routes.movieRecommended().name,
          builder: MovieRecommended.builder,
        ),
        GoRoute(
          path: const Routes.movie().path,
          name: const Routes.movie().name,
          builder: MovieHome.builder,
          routes: [
            GoRoute(
              path: const Routes.movieDetails().path,
              name: const Routes.movieDetails().name,
              builder: MovieDetailView.builder,
            ),
          ],
        ),
      ];
}
