import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

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
  releaseDate: DateTime.now(), // Example release date (December 1st, 2023)
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

class WidgetUnderTest {
  static Widget appTest(Widget element, {bool failure = false}) {
    return ProviderScope(
      overrides: [
        failure
            ? MovieInjector.movieRepository
                .overrideWithValue(MockFailureMovieRepository())
            : MovieInjector.movieRepository
                .overrideWithValue(MockMovieRepository())
      ],
      child: TranslationProvider(
          child: _AppTestWhioutDefaultBundle(
        child: element,
      )),
    );
  }
}

class _AppTestWhioutDefaultBundle extends StatelessWidget {
  const _AppTestWhioutDefaultBundle({
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: child,
      ),
    );
  }
}
