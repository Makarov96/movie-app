import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/movie_bloc.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MoviesPage extends ConsumerStatefulWidget {
  const MoviesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesPageState();
}

class _MoviesPageState extends ConsumerState<MoviesPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final movieBloc = ref.watch(MovieInjector.movieBloc);
    final switcher = ref.watch(MovieInjector.switchAnimation);

    return movieBloc.when(
      data: (data) {
        return KueskieSliverGridToList(
          contorller: scrollController,
          data: data,
          trigger: () {
            if (MovieBloc.currentPage < MovieBloc.totalPages) {
              ref.read(MovieInjector.movieBloc.notifier).getMovies();
            }
          },
          toggle: switcher.switchToGrid,
          gridToggle: () => switcher.toggle(),
          itemBuilder: (context, currentInde, movie) {
            return KueskieCard(
              onFavoritePressed: () {},
              onPressedCard: () =>
                  context.pushNamed(Routes.movieDetails().path, extra: movie),
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
      error: (e, s) => const CircularProgressIndicator(),
      loading: () => const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          Text('Error trying call the api'),
        ],
      ),
    );
  }
}
