import 'package:flutter/material.dart';

import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';

import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';

import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

import '../data/api_mock/api_mock.dart';

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

class WidgetUnderTest {
  static Widget appTest(Widget element,
      {bool failure = false, List<Override> overrides = const []}) {
    return ProviderScope(
      overrides: [
        !failure
            ? MovieInjector.movieRepository
                .overrideWithValue(MovieRepositoryMock.mockSuccessRepository())
            : MovieInjector.movieRepository
                .overrideWithValue(MovieRepositoryMock.mockFailureRepository()),
        ...overrides
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
