import 'package:kueski_challenge/core/utils/date_utils.dart';
import 'package:kueski_challenge/features/movie/_module/strings/movie_strings.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieApi extends MovieRepository {
  final Http _http;

  const MovieApi({
    required Http http,
  }) : _http = http;

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
}
