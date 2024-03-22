import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class PlayingMoviesBloc extends StateNotifier<AsyncValue<List<MovieEntity>>> {
  PlayingMoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(const AsyncValue<List<MovieEntity>>.loading()) {
    playingMovies();
  }
  final MovieRepository _movieRepository;
  static int currentPage = 1;
  static int totalPages = 0;
  List<MovieEntity> items = [];

  void playingMovies() async {
    final either = await _movieRepository.playingMovies(page: currentPage++);
    if (mounted) {
      either.when(
        (statusCode, error) {
          state = AsyncValue.error(
            error!,
            StackTrace.current,
          );
        },
        () {
          state = const AsyncValue.loading();
        },
        (response) {
          totalPages = response.totalPages;
          items.addAll(response.results);
          state = AsyncValue.data(items);
        },
      );
    }
  }

  @override
  void dispose() {
    currentPage = 1;
    totalPages = 0;
    super.dispose();
  }
}
