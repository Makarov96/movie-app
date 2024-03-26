import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';

class AddFavoriteMovieBloc extends ChangeNotifier {
  final MovieRepository _movieRepository;
  var status = Status.init;

  AddFavoriteMovieBloc({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  Future<void> addFavoriteMovie({
    required int id,
    required bool toggle,
  }) async {
    status = Status.init;
    final either = await _movieRepository.addFavoriteMovie(
      movie: FavoriteMovieModel(mediaId: id, favorite: toggle),
    );
    either.when(
      (statusCode, error) => status = Status.error,
      () => status = Status.loading,
      (validation) =>
          validation ? status = Status.success : status = Status.error,
    );

    notifyListeners();
  }

  Future<void> removeFavoriteMove({
    required int id,
  }) async {
    await addFavoriteMovie(id: id, toggle: false);
  }
}
