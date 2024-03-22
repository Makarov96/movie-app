import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';

import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/movie_bloc.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/playing_movies_bloc.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/switch_animation_grid.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

final class MovieInjector {
  static final movieRepository = Provider<MovieRepository>(
    (ref) => MovieApi(
      http: ref.read(Providers.httpProvider),
    ),
  );

  static final movieBloc = StateNotifierProvider.autoDispose<MovieBloc,
      AsyncValue<List<MovieEntity>>>(
    (ref) => MovieBloc(
      movieRepository: ref.read(movieRepository),
    ),
  );

  static final playingMoviesBloc = StateNotifierProvider.autoDispose<
      PlayingMoviesBloc, AsyncValue<List<MovieEntity>>>(
    (ref) => PlayingMoviesBloc(
      movieRepository: ref.read(movieRepository),
    ),
  );

  static final switchAnimation = ChangeNotifierProvider(
    (ref) => SwitchAnimationgrid(),
  );
}
