import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

final dateTimeNow = DateTime.now();
final _mockEntity = MovieEntity(
  adult: false,
  backdropPath: '/ruKNVJFViAyR4jguVboFXTskMOe.jpg',
  genreIds: const [12, 28], // Example genre IDs (Comedy, Action)
  id: 12345,
  originalLanguage: 'en', // English
  originalTitle: 'The Mock Movie',
  overview:
      'This is a mock overview for a movie entity used for testing purposes.',
  popularity: 8.2,
  posterPath: '/qGz5rffXhegQH5PGUDiObqoOt06.jpg',
  releaseDate: dateTimeNow, // Example release date (December 1st, 2023)
  title: 'Mock Movie Title',
  video: false,
  voteAverage: 7.8,
  voteCount: 1234,
);
final mockData = [
  _mockEntity,
];
final _mockMovieResult = MovieResultModel(
    page: 0, results: mockData, totalPages: 0, totalResults: 0);

final class MockHttp extends Mock implements Http {
  @override
  Future<HttpResult<T>> send<T>(
    String path, {
    required T Function(int statusCode, dynamic data) parser,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> headers = const {},
    Map<String, dynamic>? body,
    String contentType = Headers.jsonContentType,
    bool autoDecodeReponse = true,
    Duration? receiveTimeout,
    bool cancel = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(#checkApiResponse, null),
      ) as Future<HttpResult<T>>);
}

final class MockHttpSuccess implements Http {
  @override
  Future<HttpResult<T>> send<T>(
    String path, {
    required T Function(int statusCode, dynamic data) parser,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> headers = const {},
    Map<String, dynamic>? body,
    String contentType = Headers.jsonContentType,
    bool autoDecodeReponse = true,
    Duration? receiveTimeout,
    bool cancel = false,
  }) async =>
      ((HttpResult<MovieResultModel>.ok(_mockMovieResult, 200))
          as HttpResult<T>);
}

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);

  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);

  @override
  Future<HttpResult<MovieResultEntity>> getFavoritesMovies(
          {int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);
  @override
  Future<HttpResult<bool>> addFavoriteMovie(
          {required FavoriteMovieModel movie}) async =>
      HttpResult<bool>.ok(true, 200);
}

final unexpected = Exception('unexpected-error');

class MockFailureMovieRepository extends Mock implements MovieRepository {
  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.err(400, unexpected);

  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.err(400, unexpected);

  @override
  Future<HttpResult<MovieResultEntity>> getFavoritesMovies(
          {int page = 1}) async =>
      HttpResult<MovieResultEntity>.err(400, unexpected);
  @override
  Future<HttpResult<bool>> addFavoriteMovie(
          {required FavoriteMovieModel movie}) async =>
      HttpResult<bool>.err(400, unexpected);
}

final class ApiMockInit {
  static final MockHttp mockHttp = MockHttp();
  static final MockHttpSuccess mockSuccessHttp = MockHttpSuccess();
}

final class ApiDataMock {
  static MovieEntity getMovieEntity() => _mockEntity;
  static MovieResultModel getMovieEntityResult() => _mockMovieResult;
}

final class MovieRepositoryMock {
  static MovieRepository mockSuccessRepository() => MockMovieRepository();
  static MovieRepository mockFailureRepository() =>
      MockFailureMovieRepository();
}
