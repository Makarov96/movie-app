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
}
