import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';

void main() {
  final mockMovieEntity = MovieEntity(
    adult: false,
    backdropPath: '/path/to/backdrop.jpg',
    genreIds: const [28, 12, 878],
    id: 12345,
    originalLanguage: 'en',
    originalTitle: 'The Mock Movie',
    overview: 'A thrilling mock movie about...',
    popularity: 8.5,
    posterPath: '/path/to/poster.jpg',
    releaseDate: DateTime(2024, 03, 22),
    title: 'The Mock Movie',
    video: false,
    voteAverage: 7.8,
    voteCount: 1234,
  );
  group('MovieResultEntity', () {
    test('creates an instance with provided values', () {
      const page = 1;
      final results = [mockMovieEntity];
      const totalPages = 10;
      const totalResults = 100;

      final entity = MovieResultEntity(
        page: page,
        results: results,
        totalPages: totalPages,
        totalResults: totalResults,
      );

      expect(entity.page, page);
      expect(entity.results, results);
      expect(entity.totalPages, totalPages);
      expect(entity.totalResults, totalResults);
    });

    test('correctly implements props for equality comparison', () {
      final entity1 = MovieResultEntity(
        page: 1,
        results: [mockMovieEntity],
        totalPages: 10,
        totalResults: 100,
      );

      final entity2 = MovieResultEntity(
        page: 1,
        results: [mockMovieEntity],
        totalPages: 10,
        totalResults: 100,
      );

      expect(entity1, entity2);
    });
  });
}
