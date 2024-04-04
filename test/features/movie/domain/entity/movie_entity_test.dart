import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieEntity extends Mock implements MovieEntity {}

void main() {
  MockMovieEntity mockMovieEntity = MockMovieEntity();

  group('MovieEntity', () {
    test('supports value comparisons', () {
      // Create two MovieEntity instances with different values
      final movie1 = MovieEntity(
        adult: true,
        backdropPath: 'path/to/backdrop.jpg',
        genreIds: const [1, 2, 3],
        id: 123,
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'A thrilling overview',
        popularity: 8.5,
        posterPath: 'path/to/poster.jpg',
        releaseDate: DateTime(2023),
        title: 'The Movie Title',
        video: false,
        voteAverage: 4.2,
        voteCount: 1000,
      );

      final movie2 = MovieEntity(
        adult: false,
        backdropPath: 'different/path.jpg',
        genreIds: const [4, 5, 6],
        id: 456,
        originalLanguage: 'es',
        originalTitle: 'Un Título Original',
        overview: 'Una descripción emocionante',
        popularity: 7.8,
        posterPath: 'another/poster.jpg',
        releaseDate: DateTime(2024),
        title: 'Un Título Distinto',
        video: true,
        voteAverage: 3.9,
        voteCount: 2500,
      );

      // Assert that they are not equal
      expect(movie1, isNot(equals(movie2)));

      // Create another instance with the same values as movie1
      final movie1Duplicate = MovieEntity(
        adult: true,
        backdropPath: 'path/to/backdrop.jpg',
        genreIds: const [1, 2, 3],
        id: 123,
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'A thrilling overview',
        popularity: 8.5,
        posterPath: 'path/to/poster.jpg',
        releaseDate: DateTime(2023),
        title: 'The Movie Title',
        video: false,
        voteAverage: 4.2,
        voteCount: 1000,
      );

      // Assert that they are equal
      expect(movie1, equals(movie1Duplicate));
    });
  });

  test(
    'should be return all okay',
    () {
      when(() => mockMovieEntity.adult).thenReturn(true);
      when(() => mockMovieEntity.backdropPath)
          .thenReturn('path/to/backdrop.jpg');
      when(() => mockMovieEntity.genreIds).thenReturn(const [1, 2, 3]);
      when(() => mockMovieEntity.id).thenReturn(123);
      when(() => mockMovieEntity.originalLanguage).thenReturn('en');
      when(() => mockMovieEntity.originalTitle).thenReturn('Original Title');
      when(() => mockMovieEntity.overview).thenReturn('A thrilling overview');
      when(() => mockMovieEntity.popularity).thenReturn(8.5);
      when(() => mockMovieEntity.posterPath).thenReturn('path/to/poster.jpg');
      when(() => mockMovieEntity.releaseDate).thenReturn(DateTime(2023));
      when(() => mockMovieEntity.title).thenReturn('The Movie Title');
      when(() => mockMovieEntity.video).thenReturn(false);
      when(() => mockMovieEntity.voteAverage).thenReturn(4.2);
      when(() => mockMovieEntity.voteCount).thenReturn(1000);
    },
  );

  group('AddExtract extension tests', () {
    test('fullPosterPath constructs the correct URL', () {
      final mockMovie = MockMovieEntity();
      when(() => mockMovie.posterPath).thenReturn('posterPathValue');

      const expectedPosterPath =
          'http://image.tmdb.org/t/p/w500/posterPathValue';
      expect(mockMovie.fullPath, expectedPosterPath);
      verify(() => mockMovie.posterPath);
    });

    test('fullBackDropPath constructs the correct URL', () {
      final mockMovie = MockMovieEntity();
      when(() => mockMovie.backdropPath).thenReturn('backdropPathValue');

      const expectedBackdropPath =
          'http://image.tmdb.org/t/p/w500/backdropPathValue';
      expect(mockMovie.fullbdPath, expectedBackdropPath);
      verify(() => mockMovie.backdropPath);
    });
  });
}
