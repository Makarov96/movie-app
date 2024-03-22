import 'package:flutter/material.dart';
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
      ),
    );
  }
}

class MovieLayoutHome extends StatelessWidget {
  const MovieLayoutHome({super.key});

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
