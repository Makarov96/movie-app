import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

abstract class MovieRepository {
  const MovieRepository();

  Future<HttpResult<MovieResultEntity>> getMovies({
    int page = 1,
  });

  Future<HttpResult<MovieResultEntity>> playingMovies({
    int page = 1,
  });
  Future<HttpResult<MovieResultEntity>> getFavoritesMovies({
    int page = 0,
  });
  Future<HttpResult<bool>> addFavoriteMovie({
    required FavoriteMovieModel movie,
  });
}
