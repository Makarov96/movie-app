import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/presenter/component/favorite/view/bloc/add_favorite_movie.dart';

extension StatusListener on Never {
  static showSnackBar(
    AddFavoriteMovieBloc? previous,
    AddFavoriteMovieBloc current,
    BuildContext context,
  ) {
    switch (current.status) {
      case Status.init:
        return;
      case Status.loading:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading ...')),
        );
        return;
      case Status.error:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')),
        );
        return;
      case Status.success:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You got it! 🙆')),
        );
        return;
    }
  }
}
