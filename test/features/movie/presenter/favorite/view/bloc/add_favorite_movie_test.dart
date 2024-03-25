import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {
  @override
  Future<HttpResult<bool>> addFavoriteMovie(
          {required FavoriteMovieModel movie}) =>
      (super.noSuchMethod(
        Invocation.method(#checkAddBloc, null),
      ) as Future<HttpResult<bool>>);

  @override
  Future<HttpResult<MovieResultEntity>> getFavoritesMovies({int page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(#checkBlocCalled, null),
      ) as Future<HttpResult<MovieResultEntity>>);
}

void main() {
  const favoriteMovie = FavoriteMovieModel(mediaId: 123);
  late MockMovieRepository mockMovieRepository;
  final unexpectedError = Exception("Error random");
  final expectedFailure = HttpResult<bool>.err(404, unexpectedError);
  final expectedFailureGetFM =
      HttpResult<MovieResultModel>.err(404, unexpectedError);
  final successCase = HttpResult<bool>.ok(true, 200);
  const expectedPage = 1;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  group('AddFavoriteMovieBloc', () {
    test('adds favorite movie with success', () async {
      final container = ProviderContainer(
        overrides: [
          MovieInjector.movieRepository.overrideWithValue(mockMovieRepository),
        ],
      );
      when(() => mockMovieRepository.addFavoriteMovie(
            movie: favoriteMovie,
          )).thenAnswer((_) => Future.value(successCase));

      final bloc = container.read(MovieInjector.addFavoriteMovie);
      mockMovieRepository.addFavoriteMovie(
        movie: favoriteMovie,
      );

      await bloc.addFavoriteMovie(id: 123, toggle: true);

      expect(bloc.status, Status.success);
    });

    test('adds favorite movie with failure', () async {
      final container = ProviderContainer(
        overrides: [
          MovieInjector.movieRepository.overrideWithValue(mockMovieRepository),
        ],
      );
      when(() => mockMovieRepository.addFavoriteMovie(
            movie: favoriteMovie,
          )).thenAnswer((_) => Future.value(expectedFailure));

      final bloc = container.read(MovieInjector.addFavoriteMovie);

      await bloc.addFavoriteMovie(id: 123, toggle: true);
      bloc.status = Status.error;
      expect(bloc.status, Status.error);
    });

    test('get favorite movies with failure', () async {
      final container = ProviderContainer(
        overrides: [
          MovieInjector.movieRepository.overrideWithValue(mockMovieRepository),
        ],
      );
      when(() => mockMovieRepository.getFavoritesMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedFailureGetFM));

      final bloc = container.read(MovieInjector.getFavoriteMovies);

      await bloc.getList(isListener: false);
      bloc.status = (movies: [], status: Status.error);
      expect(bloc.status.status, Status.error);
    });
  });
}
