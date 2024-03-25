import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/core/utils/date_utils.dart';
import 'package:kueski_challenge/features/movie/_module/strings/movie_strings.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieApi extends MovieRepository {
  final Http _http;
  final Environment _env;

  const MovieApi({
    required Http http,
    required Environment env,
  })  : _http = http,
        _env = env;

  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 0}) async {
    var path = '${MovieStrings.query1}$page${MovieStrings.query2Sort}';
    final result = await _http.send<MovieResultModel>(
      path,
      parser: (statucCode, value) => MovieResultModel.fromJson(value),
    );

    return result;
  }

  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) async {
    var path =
        '${MovieStrings.query1}$page${MovieStrings.query3Release}${DateTimeFormatter.formattedDate}';
    final result = await _http.send<MovieResultModel>(
      path,
      parser: (statucCode, value) => MovieResultModel.fromJson(value),
    );

    return result;
  }

  @override
  Future<HttpResult<bool>> addFavoriteMovie({
    required FavoriteMovieModel movie,
  }) async {
    final path = MovieStrings.buildFavoriteUrl(
      userId: _env.accountID,
      apiKey: _env.apiKey,
      sessionId: _env.sessionID,
    );
    final result = await _http.send(path,
        method: HttpMethod.post,
        body: movie.toJson(),
        parser: (statusCode, _) => statusCode <= 400);
    return result;
  }

  @override
  Future<HttpResult<MovieResultEntity>> getFavoritesMovies(
      {int page = 0}) async {
    final path = MovieStrings.buildGetFavoriteUrl(
        userId: _env.accountID,
        apiKey: _env.apiKey,
        sessionId: _env.sessionID,
        page: page);
    final result = await _http.send(path,
        parser: (statucCode, value) => MovieResultModel.fromJson(value));
    return result;
  }
}
