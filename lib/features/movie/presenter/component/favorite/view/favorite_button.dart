import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';

import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watcher = ref
        .watch(MovieInjector.getFavoriteMovies)
        .items
        .existMovie(movieId: id);
    return KueskiFavoriteButton(
      id: id.toString(),
      onPressed: () async {
        await ref
            .read(MovieInjector.addFavoriteMovie)
            .addFavoriteMovie(id: id, toggle: !watcher);
        ref.read(MovieInjector.getFavoriteMovies).getList();
      },
      isFavorite: watcher,
    );
  }
}
