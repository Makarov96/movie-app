import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/movie_bloc.dart';
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
