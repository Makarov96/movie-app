import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/features/movie/_module/keys/movie_keys.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/component/favorite/view/favorite_button.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/movie_bloc.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MoviesPage extends ConsumerStatefulWidget {
  const MoviesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesPageState();
}

class _MoviesPageState extends ConsumerState<MoviesPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final movieBloc = ref.watch(MovieInjector.movieBloc);
    final switcher = ref.watch(MovieInjector.switchAnimation);

    return movieBloc.when(
      data: (data) {
        return KueskieSliverGridToList(
          key: Moviekeys.sliverGridToList,
          contorller: scrollController,
          data: data,
          trigger: () {
            if (MovieBloc.currentPage < MovieBloc.totalPages) {
              ref.read(MovieInjector.movieBloc.notifier).getMovies();
            }
          },
          toggle: switcher.switchToGrid,
          gridToggle: () => switcher.toggle(),
          itemBuilder: (context, currentIndex, movie) {
            return KueskieCard(
              key: Moviekeys.kueskiCard,
              favorite: FavoriteButton(
                movieEntity: movie,
              ),
              onPressedCard: () => context
                  .pushNamed(const Routes.movieDetails().path, extra: movie),
              imagePath: movie.fullbdPath,
              title: movie.title,
              popularity: movie.popularity,
              voteCount: movie.voteCount,
              voteAverage: movie.voteAverage,
              movieId: 'movie-page-${movie.id}',
            );
          },
        );
      },
      loading: () => const ErrorOrLoadingLayout(),
      error: (e, s) => ErrorOrLoadingLayout(
        key: Moviekeys.errorOrLoadingLayout,
        message: context.texts.home.errorMessage,
      ),
    );
  }
}
