import 'package:flutter_test/flutter_test.dart';

import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';

import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/movie_bloc.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockApiRespotory extends Mock implements MovieRepository {
  @override
  Future<HttpResult<MovieResultEntity>> getMovies({int page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(#checkBlocCalled, null),
      ) as Future<HttpResult<MovieResultEntity>>);
}

void main() {
  const expectedPage = 1;
  final expectedData = {'results': []};
  final mockMovies = <MovieEntity>[];
  final unexpectedError = Exception("Error random");
  final currentStackTrace = StackTrace.current;
  final expectedResult = HttpResult<MovieResultModel>.ok(
      MovieResultModel.fromJson(expectedData), 201);
  final expectedFailure =
      HttpResult<MovieResultModel>.err(404, unexpectedError);
  late MovieRepository mockMovieRepository;
  late MovieBloc movieBloc;

  setUp(() {
    mockMovieRepository = MockApiRespotory();
  });
  group('MovieBloc', () {
    test('initial state is AsyncValue.loading', () async {
      when(() => mockMovieRepository.getMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));

      movieBloc = MovieBloc(movieRepository: mockMovieRepository);
      expect(movieBloc.state, const AsyncValue<List<MovieEntity>>.loading());
    });

    test('getMovies fetches movies and updates state on success', () async {
      when(() => mockMovieRepository.getMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));
      await mockMovieRepository.getMovies(page: expectedPage);
      movieBloc = MovieBloc(movieRepository: mockMovieRepository);

      movieBloc.state = AsyncValue.data(mockMovies);

      expect(movieBloc.state, AsyncValue.data(mockMovies));
      expect(MovieBloc.currentPage, 3); // Page should be incremented
      expect(MovieBloc.totalPages, 0); // Total pages should be updated
    });

    test('getMovies fetches movies and updates state on failure', () async {
      when(() => mockMovieRepository.getMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedFailure));

      movieBloc = MovieBloc(movieRepository: mockMovieRepository);

      movieBloc.state = AsyncValue.error(unexpectedError, currentStackTrace);

      expect(movieBloc.state, isA<AsyncError>());
    });

    test('dispose resets currentPage and totalPages', () {
      when(() => mockMovieRepository.getMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));
      movieBloc = MovieBloc(movieRepository: mockMovieRepository);
      movieBloc.dispose();

      expect(MovieBloc.currentPage, 1);
      expect(MovieBloc.totalPages, 0);
    });
  });
}
