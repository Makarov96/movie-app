import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieApi extends MovieRepository {
  final Http _http;

  const MovieApi({
    required Http http,
  }) : _http = http;

  @override
  Future<HttpResult<List<MovieEntity>>> getMovies({int page = 1}) async {
    final result = await _http.send<List<MovieEntity>>(
      '/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc',
      parser: (statucCode, value) {
        final moveResult = MovieResult.fromJson(value);
        return moveResult.results;
      },
    );

    return result;
  }
}
