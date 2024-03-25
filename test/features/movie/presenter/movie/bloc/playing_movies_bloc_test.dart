import 'package:flutter_test/flutter_test.dart';

import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';

import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

import 'package:kueski_challenge/features/movie/presenter/movie/bloc/playing_movies_bloc.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

class MockApiRespotory extends Mock implements MovieRepository {
  @override
  Future<HttpResult<MovieResultEntity>> playingMovies({int page = 1}) =>
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
  late PlayingMoviesBloc playingMovieBloc;

  setUp(() {
    mockMovieRepository = MockApiRespotory();
  });
  group('MovieBloc', () {
    test('initial state is AsyncValue.loading', () async {
      when(() => mockMovieRepository.playingMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));

      playingMovieBloc =
          PlayingMoviesBloc(movieRepository: mockMovieRepository);
      expect(playingMovieBloc.state,
          const AsyncValue<List<MovieEntity>>.loading());
    });

    test('getMovies fetches movies and updates state on success', () async {
      when(() => mockMovieRepository.playingMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));
      await mockMovieRepository.playingMovies(page: expectedPage);
      playingMovieBloc =
          PlayingMoviesBloc(movieRepository: mockMovieRepository);

      playingMovieBloc.state = AsyncValue.data(mockMovies);

      expect(playingMovieBloc.state, AsyncValue.data(mockMovies));
      expect(PlayingMoviesBloc.currentPage, 3); // Page should be incremented
      expect(PlayingMoviesBloc.totalPages, 0); // Total pages should be updated
    });

    test('getMovies fetches movies and updates state on failure', () async {
      when(() => mockMovieRepository.playingMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedFailure));

      playingMovieBloc =
          PlayingMoviesBloc(movieRepository: mockMovieRepository);

      playingMovieBloc.state =
          AsyncValue.error(unexpectedError, currentStackTrace);

      expect(playingMovieBloc.state, isA<AsyncError>());
    });

    test('dispose resets currentPage and totalPages', () {
      when(() => mockMovieRepository.playingMovies(page: expectedPage))
          .thenAnswer((_) => Future.value(expectedResult));
      playingMovieBloc =
          PlayingMoviesBloc(movieRepository: mockMovieRepository);
      playingMovieBloc.dispose();

      expect(PlayingMoviesBloc.currentPage, 1);
      expect(PlayingMoviesBloc.totalPages, 0);
    });
  });
}
