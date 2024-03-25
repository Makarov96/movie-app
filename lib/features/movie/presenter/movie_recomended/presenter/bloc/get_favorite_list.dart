import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class GetFavoriteList extends StateNotifier<AsyncValue<List<MovieEntity>>> {
  final MovieRepository _movieRepository;

  GetFavoriteList({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const AsyncValue<List<MovieEntity>>.loading()) {
    getList();
  }

  static int currentPage = 1;
  static int totalPages = 0;
  List<MovieEntity> movies = [];

  Future<void> getList({bool refresh = false}) async {
    final either = await _movieRepository.getFavoritesMovies(
        page: refresh ? 1 : currentPage++);

    either.when(
      (statusCode, error) =>
          state = AsyncValue.error(error ?? Exception(), StackTrace.current),
      () => state = const AsyncValue.loading(),
      (response) {
        totalPages = response.totalPages;

        movies.addAll(response.results);
        state = AsyncValue.data(movies.toSet().toList());
      },
    );
  }

  void removeElementAt({required MovieEntity movie}) {
    state.value?.remove(movie);
    var removeList = [...state.value ?? []];
    state = AsyncValue.data([...removeList]);
  }

  @override
  void dispose() {
    currentPage = 1;
    totalPages = 0;
    super.dispose();
  }
}
