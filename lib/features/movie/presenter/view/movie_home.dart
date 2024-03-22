import 'package:flutter/material.dart';

import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/bloc/movie_bloc.dart';
import 'package:kueski_challenge/features/movie/presenter/view/page/playing_movies_page.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieHome extends StatelessWidget {
  const MovieHome({super.key});
  static Widget builder(BuildContext _, GoRouterState __) {
    return const MovieHome();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'All Moview',
              ),
              Tab(
                text: 'Playing Now',
              ),
            ],
          ),
        ),
        body: const MovieLayoutHome(),
      ),
    );
  }
}

class MovieLayoutHome extends StatefulWidget {
  const MovieLayoutHome({super.key});

  @override
  State<MovieLayoutHome> createState() => _MovieLayoutHomeState();
}

class _MovieLayoutHomeState extends State<MovieLayoutHome> {
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        MoviesPage(),
        PlayingMoviesPage(),
      ],
    );
  }
}

class MoviesPage extends ConsumerStatefulWidget {
  const MoviesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesPageState();
}

class _MoviesPageState extends ConsumerState<MoviesPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (MovieBloc.currentPage < MovieBloc.totalPages) {
        ref.read(MovieInjector.movieBloc.notifier).getMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Consumer(
            builder: (context, ref, widget) {
              final value = ref.watch(MovieInjector.switchAnimation);
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      value.toggle();
                    },
                    icon: Icon(
                      value.switchToGrid ? Icons.filter_none : Icons.grid_on,
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const MovieListOrGrid(),
      ],
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class MovieListOrGrid extends ConsumerWidget {
  const MovieListOrGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieBloc = ref.watch(MovieInjector.movieBloc);
    final switcher = ref.watch(MovieInjector.switchAnimation);

    return movieBloc.when(
      data: (data) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switcher.switchToGrid ? 2 : 1,
              mainAxisSpacing: 20,
              mainAxisExtent: switcher.switchToGrid ? 300 : 400,
              crossAxisSpacing: switcher.switchToGrid ? 20 : 0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final currentIndex = index;
              final beforeIndex = index - 1;

              return Align(
                child: AnimatedOpacity(
                  key: Key(data[index].id.toString()),
                  opacity: currentIndex != beforeIndex ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: MovieItem(
                    movie: data[index],
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (e, s) => const SliverToBoxAdapter(
        child: CircularProgressIndicator(),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MovieItem extends ConsumerWidget {
  const MovieItem({super.key, required this.movie, required this.onPressed});
  final MovieEntity movie;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'http://image.tmdb.org/t/p/w500/${movie.backdropPath}',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
      ),
      width: 300,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton.small(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: onPressed,
              backgroundColor: Colors.white.withOpacity(
                0.4,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
          Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              children: [
                BadgeIcon(
                  icon: Icons.group_rounded,
                  text: movie.popularity.toStringAsFixed(3),
                ),
                BadgeIcon(
                  icon: Icons.how_to_vote_outlined,
                  text: movie.voteCount.toStringAsFixed(3),
                ),
                BadgeIcon(
                  icon: Icons.percent_outlined,
                  text: movie.voteAverage.toStringAsFixed(3),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    super.key,
    required this.icon,
    required this.text,
    this.backgroundColor = Colors.indigo,
  });
  final IconData icon;
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
