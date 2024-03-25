import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';

import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.movieEntity,
  });
  final MovieEntity movieEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watcher = ref
        .watch(MovieInjector.getFavoriteMovies)
        .cpMovies
        .existMovie(movieId: movieEntity.id);
    return KueskiFavoriteButton(
      id: movieEntity.id.toString(),
      onPressed: () async {
        await ref
            .read(MovieInjector.addFavoriteMovie)
            .addFavoriteMovie(id: movieEntity.id, toggle: !watcher);
        ref
            .read(MovieInjector.getFavoriteMovies)
            .addNewFavoriteMovie(movieEntity);
      },
      isFavorite: watcher,
    );
  }
}
