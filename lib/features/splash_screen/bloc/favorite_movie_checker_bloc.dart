import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class FavoriteMovieChecker
    extends StateNotifier<AsyncValue<List<MovieEntity>>> {
  final MovieRepository _movieRepository;

  FavoriteMovieChecker({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const AsyncValue.loading()) {
    checkerList();
  }

  Future<void> checkerList() async {
    final either = await _movieRepository.getFavoritesMovies(page: 1);

    if (mounted) {
      either.when(
        (statusCode, error) =>
            state = AsyncValue.error(error ?? Exception(), StackTrace.current),
        () => state = const AsyncValue.loading(),
        (response) => state = AsyncValue.data(response.results),
      );
    }
  }
}
