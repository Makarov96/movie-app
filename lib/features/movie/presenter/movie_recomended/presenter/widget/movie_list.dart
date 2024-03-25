import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieList extends ConsumerWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var record = ref.watch(MovieInjector.getFavoriteMovies).status;

    return switch (record.status) {
      Status.init => const SizedBox.shrink(),
      Status.loading => const ErrorOrLoadingLayout(),
      Status.error => ErrorOrLoadingLayout(
          message: context.texts.recommended.errorMessage,
        ),
      Status.success => ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ).copyWith(bottom: 200),
          itemCount: record.movies.length,
          itemBuilder: (context, index) => KueskiHorizontalCard(
            model: CardModel(
              url: record.movies[index].fullbdPath,
              primaryTitle: record.movies[index].title,
              title: context.texts.details.popularity,
              subTitle: record.movies[index].popularity.toStringAsFixed(0),
              title2: context.texts.details.votes,
              subTitle2: record.movies[index].voteCount.toStringAsFixed(0),
              title3: context.texts.details.votesAverage,
              subTitle3: record.movies[index].voteAverage.toStringAsFixed(2),
            ),
            onTap: () => context.pushNamed(
              const Routes.movieDetails().name,
              extra: record.movies[index],
            ),
          ),
        ),
    };
  }
}
