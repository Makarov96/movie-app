import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieList extends ConsumerStatefulWidget {
  const MovieList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<MovieList> {
  late ScrollController controller = ScrollController()..addListener(_listener);

  _listener() {
    final offsetPosition =
        controller.offset + 75 >= controller.position.maxScrollExtent;
    final outOfRange = controller.position.outOfRange;

    if (offsetPosition && !outOfRange) {
      ref.read(MovieInjector.getFavoriteMovies.notifier).getList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(MovieInjector.getFavoriteMovies).when(
          data: (movies) => ListView.builder(
            controller: controller,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ).copyWith(bottom: 200),
            itemCount: movies.length,
            itemBuilder: (context, index) => KueskiHorizontalCard(
              model: CardModel(
                url: movies[index].fullbdPath,
                primaryTitle: movies[index].title,
                title: context.texts.details.popularity,
                subTitle: movies[index].popularity.toStringAsFixed(0),
                title2: context.texts.details.votes,
                subTitle2: movies[index].voteCount.toStringAsFixed(0),
                title3: context.texts.details.votesAverage,
                subTitle3: movies[index].voteAverage.toStringAsFixed(2),
              ),
              favorite: KueskiButton(
                icon: Icons.delete,
                isStretch: true,
                onPressed: () async {
                  await ref
                      .read(MovieInjector.addFavoriteMovie)
                      .removeFavoriteMove(
                        id: movies[index].id,
                      );
                  ref
                      .read(MovieInjector.getFavoriteMovies.notifier)
                      .removeElementAt(
                        movie: movies[index],
                      );
                },
                text: context.texts.component.addFAvorites,
              ),
              onTap: () => context.pushNamed(
                const Routes.movieDetails().name,
                extra: movies[index],
              ),
            ),
          ),
          error: (s, e) => Center(
            child: ErrorOrLoadingLayout(
              message: context.texts.recommended.errorMessage,
            ),
          ),
          loading: () => const Center(child: ErrorOrLoadingLayout()),
        );
  }
}
