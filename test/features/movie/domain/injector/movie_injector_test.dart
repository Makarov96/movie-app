import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/data/api_mock/api_mock.dart';
import '../../../../common/helper/provider_scoper_mock.dart';

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
final _mockMovieResult = MovieResultEntity(
    page: 0, results: mockData, totalPages: 0, totalResults: 0);

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);

  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);
  @override
  Future<HttpResult<bool>> addFavoriteMovie(
          {required FavoriteMovieModel movie}) async =>
      HttpResult<bool>.ok(true, 200);
}

class MockMovie extends Mock implements MovieApi {
  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);

  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) async =>
      HttpResult<MovieResultEntity>.ok(_mockMovieResult, 200);

  @override
  Future<HttpResult<bool>> addFavoriteMovie(
          {required FavoriteMovieModel movie}) async =>
      HttpResult<bool>.ok(true, 200);
}

void main() {
  late MovieRepository mockRepository;

  setUp(
    () {
      mockRepository = MockMovieRepository();
    },
  );
  group(
    'test injectors ',
    () {
      test(
        'called the main method try Bloc',
        () async {
          //arrange
          final container = createContainer(
            overrides: [
              Providers.httpProvider
                  .overrideWith((ref) => ApiMockInit.mockSuccessHttp),
              MovieInjector.movieRepository
                  .overrideWith((ref) => mockRepository),
            ],
          );

          //act
          final reader = container.read(MovieInjector.playingMoviesBloc);

          //Assert
          expect(reader.value, isA<Null>());
        },
      );
      test(
        'called the main method try Movie Api',
        () async {
          //arrange
          final container = createContainer(
            overrides: [
              Providers.httpProvider
                  .overrideWith((ref) => ApiMockInit.mockSuccessHttp),
              Providers.enviroment.overrideWith((ref) => Environment.dev),
            ],
          );
          final reader = container.read(MovieInjector.movieRepository);

          //act

          final succesCase = await reader.getMovies();
          //Assert

          expect(succesCase, isA<HttpResult<MovieResultEntity>>());
        },
      );
      test(
        'should be return a movie respository',
        () async {
          //arrange
          final container = createContainer(
            overrides: [
              MovieInjector.movieRepository.overrideWith((ref) => MovieApi(
                  http: ApiMockInit.mockSuccessHttp, env: Environment.dev)),
            ],
          );

          //act
          final reader = container.read(MovieInjector.movieRepository);

          //Assert

          final succesCase = await reader.getMovies();
          expect(succesCase, isA<HttpResult<MovieResultEntity>>());
        },
      );
      test(
        'should be return a movie respository',
        () async {
          //arrange
          final container = createContainer(
            overrides: [
              MovieInjector.movieRepository
                  .overrideWith((ref) => mockRepository),
            ],
          );

          //act
          final reader = container.read(MovieInjector.movieRepository);

          //Assert

          expect(reader, isA<MovieRepository>());

          final succesCase = await reader.getMovies();
          expect(succesCase, isA<HttpResult<MovieResultEntity>>());
        },
      );
    },
  );
}
