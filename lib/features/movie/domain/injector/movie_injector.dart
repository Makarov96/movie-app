import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_recomended/presenter/bloc/get_favorite_list.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/movie_bloc.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/playing_movies_bloc.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/switch_animation_grid.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:kueski_challenge/features/movie/presenter/component/favorite/view/bloc/add_favorite_movie.dart';

extension MovieInjector on Never {
  static final movieRepository = Provider<MovieRepository>(
    (ref) => MovieApi(
        http: ref.read(Providers.httpProvider),
        env: ref.read(Providers.enviroment)),
  );

  static final getFavoriteMovies = StateNotifierProvider.autoDispose<
      GetFavoriteList, AsyncValue<List<MovieEntity>>>(
    (ref) => GetFavoriteList(
      movieRepository: ref.read(movieRepository),
    ),
  );

  static final addFavoriteMovie = ChangeNotifierProvider(
    (ref) => AddFavoriteMovieBloc(
      movieRepository: ref.read(movieRepository),
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
