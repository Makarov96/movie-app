import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

class GetFavoriteList extends ChangeNotifier {
  final MovieRepository _movieRepository;

  GetFavoriteList({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository {
    getList();
  }

  static int currentPage = 1;
  static int totalPages = 0;
  List<MovieEntity> items = [];
  Status status = Status.init;

  void getList() async {
    status = Status.init;
    final either = await _movieRepository.getFavoritesMovies();

    either.when(
      (statusCode, error) => status = Status.error,
      () => status = Status.loading,
      (response) {
        totalPages = response.totalPages;
        items = response.results;

        status = Status.success;
      },
    );

    print(items.length);

    notifyListeners();
  }
}
