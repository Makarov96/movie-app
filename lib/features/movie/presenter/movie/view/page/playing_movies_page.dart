import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/playing_movies_bloc.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class PlayingMoviesPage extends ConsumerStatefulWidget {
  const PlayingMoviesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlayingMoviesPageState();
}

class _PlayingMoviesPageState extends ConsumerState<PlayingMoviesPage> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final movieBloc = ref.watch(MovieInjector.playingMoviesBloc);
    final switcher = ref.watch(MovieInjector.switchAnimation);
    return movieBloc.when(
      data: (data) {
        return KueskieSliverGridToList(
          contorller: scrollController,
          data: data,
          trigger: () {
            if (PlayingMoviesBloc.currentPage < PlayingMoviesBloc.totalPages) {
              ref
                  .read(MovieInjector.playingMoviesBloc.notifier)
                  .playingMovies();
            }
          },
          toggle: switcher.switchToGridPM,
          gridToggle: () => switcher.togglePM(),
          itemBuilder: (context, currentInde, movie) {
            return KueskieCard(
              onFavoritePressed: () async {},
              onPressedCard: () =>
                  context.pushNamed(Routes.movieDetails().path, extra: movie),
              imagePath: movie.fullbdPath,
              title: movie.title,
              popularity: movie.popularity,
              voteCount: movie.voteCount,
              voteAverage: movie.voteAverage,
              movieId: 'playing-movie-${movie.id}',
            );
          },
        );
      },
      error: (e, s) => const CircularProgressIndicator(),
      loading: () => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
