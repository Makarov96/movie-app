import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.movieEntity,
    required this.isStretch,
  });
  final MovieEntity movieEntity;
  final bool isStretch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cointains =
        ref.read(MovieInjector.getFavoriteMovies).value?.contains(movieEntity);
    return KueskiButton(
      isStretch: isStretch,
      onPressed: () async {
        await ref.read(MovieInjector.addFavoriteMovie).addFavoriteMovie(
            id: movieEntity.id, toggle: !(cointains ?? false));
      },
      text: context.texts.component.addFAvorites,
    );
  }
}
