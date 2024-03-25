import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/router.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/presenter/component/favorite/listener/status_listener.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/view/page/movie_page.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/view/page/playing_movies_page.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
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
          title: Text(context.texts.home.title),
          bottom: TabBar(
            tabs: [
              Tab(
                text: context.texts.home.movies,
              ),
              Tab(
                text: context.texts.home.playingMovies,
              ),
            ],
          ),
        ),
        body: const MovieLayoutHome(),
        drawer: Consumer(builder: (context, ref, widget) {
          return KueskiDrawer(
            title: context.texts.home.title,
            listTiles: [
              ListTile(
                title: Text(context.texts.home.favorites),
                leading: const Icon(Icons.favorite),
                onTap: () async {
                  context.pushNamed(const Routes.movieRecommended().name,
                      extra: false);
                  Navigator.of(context).pop();
                  //   await ref.read(MovieInjector.getFavoriteMovies).getList();
                },
              ),
              // Add more menu items here
            ],
          );
        }),
      ),
    );
  }
}

class MovieLayoutHome extends ConsumerWidget {
  const MovieLayoutHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      MovieInjector.addFavoriteMovie,
      (previous, current) {
        StatusListener.showSnackBar(previous, current, context);
      },
    );
    return const TabBarView(
      children: [
        MoviesPage(),
        PlayingMoviesPage(),
      ],
    );
  }
}
