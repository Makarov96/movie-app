import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_detail/presenter/widgets/image_header.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_detail/presenter/widgets/movie_detail_layout.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  static Widget builder(BuildContext _, GoRouterState state) {
    final movie = state.extra as MovieEntity;
    return MovieDetailView(
      movie: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ImageHader(
                movie: movie,
                sizeOf: sizeOf,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          KueskiDraggable(
            child: MovieDetailLayout(movie: movie),
          )
        ],
      ),
    );
  }
}
