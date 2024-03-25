import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

class GetFavoriteList extends ChangeNotifier {
  final MovieRepository _movieRepository;

  GetFavoriteList({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  static int currentPage = 0;
  static int totalPages = 0;
  List<MovieEntity> items = [];
  List<int> cpMovies = [];
  ({Status status, List<MovieEntity> movies}) status =
      (status: Status.init, movies: <MovieEntity>[]);

  Future<void> getList() async {
    status = (status: Status.init, movies: <MovieEntity>[]);
    final either =
        await _movieRepository.getFavoritesMovies(page: currentPage += 1);

    either.when(
      (statusCode, error) =>
          status = (status: Status.error, movies: <MovieEntity>[]),
      () => status = status = (status: Status.loading, movies: <MovieEntity>[]),
      (response) {
        totalPages = response.totalPages;
        items = response.results;
        cpMovies = items.map((e) => e.id).toList();
        status = (status: Status.success, movies: items);
      },
    );

    notifyListeners();
  }

  void addNewFavoriteMovie(MovieEntity movie) {
    if (cpMovies.existMovie(movieId: movie.id)) {
      cpMovies = cpMovies..remove(movie.id);
    } else {
      cpMovies.add(movie.id);
    }

    notifyListeners();
  }
}
