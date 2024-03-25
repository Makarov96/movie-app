import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });
  setUpAll(() {
    registerFallbackValue(const FavoriteMovieModel(mediaId: 123));
  });

  group('AddFavoriteMovieBloc', () {
    testWidgets('adds favorite movie with success', (tester) async {
      final container = ProviderContainer(
        overrides: [
          MovieInjector.movieRepository.overrideWithValue(mockMovieRepository),
        ],
      );

      final bloc = container.read(MovieInjector.addFavoriteMovie);

      when(() => mockMovieRepository.addFavoriteMovie(
                movie: any(named: 'movie'),
              ))
          .thenAnswer(
              (_) async => HttpResult.ok(true, 200)); // Simulate success

      await bloc.addFavoriteMovie(id: 123, toggle: true);

      expect(bloc.status, Status.success);
    });

    testWidgets('adds favorite movie with error', (tester) async {
      final container = ProviderContainer(
        overrides: [
          MovieInjector.movieRepository.overrideWithValue(mockMovieRepository),
        ],
      );

      final bloc = container.read(MovieInjector.addFavoriteMovie);

      when(() => mockMovieRepository.addFavoriteMovie(
                movie: any(named: 'movie'),
              ))
          .thenAnswer((_) async => HttpResult.err(400, 400)); // Simulate error

      await bloc.addFavoriteMovie(id: 123, toggle: true);

      expect(bloc.status, Status.error);
    });
  });
}
