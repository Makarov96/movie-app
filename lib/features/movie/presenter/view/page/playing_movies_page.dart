import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/playing_movies_bloc.dart';
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
          itemBuilder: (context, currentInde, movies) {
            return KueskieCard(
              onFavoritePressed: () {},
              imagePath: movies.backdropPath,
              title: movies.title,
              popularity: movies.popularity,
              voteCount: movies.voteCount,
              voteAverage: movies.voteAverage,
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
