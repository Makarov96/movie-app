import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/presenter/view/page/movie_page.dart';
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
