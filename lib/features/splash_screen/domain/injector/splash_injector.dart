import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

import 'package:kueski_challenge/features/splash_screen/bloc/favorite_movie_checker_bloc.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

extension SplashInjector on Never {
  static final movieRepository = Provider<MovieRepository>(
    (ref) => MovieApi(
        http: ref.read(Providers.httpProvider),
        env: ref.read(Providers.enviroment)),
  );

  static final checker = StateNotifierProvider.autoDispose<FavoriteMovieChecker,
      AsyncValue<List<MovieEntity>>>(
    (ref) => FavoriteMovieChecker(
      movieRepository: ref.read(movieRepository),
    ),
  );
}
