import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

import '../../../common/data/api_mock/api_mock.dart';
import '../../../common/helper/provider_scoper_mock.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  group('FavoriteMovieChecker', () {
    test('fetches favorite movies successfully', () async {
      final container = createContainer(
        overrides: [
          MovieInjector.movieRepository
              .overrideWithValue(MovieRepositoryMock.mockSuccessRepository()),
        ],
      );

      final checker = container.read(MovieInjector.addFavoriteMovie);
      expect(checker.status, Status.init);

      when(() => mockMovieRepository.getFavoritesMovies(page: 1)).thenAnswer(
          (_) async => HttpResult.ok(ApiDataMock.getMovieEntityResult(), 200));
      await checker.addFavoriteMovie(id: 123, toggle: true);
      expect(checker.status, Status.success);
    });

    test('handles error during fetching', () async {
      final container = createContainer(
        overrides: [
          MovieInjector.movieRepository
              .overrideWithValue(MovieRepositoryMock.mockFailureRepository()),
        ],
      );

      final checker = container.read(MovieInjector.addFavoriteMovie);

      when(() => mockMovieRepository.getFavoritesMovies(page: 1))
          .thenAnswer((_) async => HttpResult.err(500, Exception()));
      await checker.addFavoriteMovie(id: 123, toggle: true);
      expect(checker.status, isInstanceOf<Status>());
      expect(checker.status, Status.error);
    });
  });
}
