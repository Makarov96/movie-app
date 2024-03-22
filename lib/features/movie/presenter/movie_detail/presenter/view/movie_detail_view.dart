import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/date_utils.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_detail/presenter/widgets/image_header.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: sizeOf.height * 0.02,
                ),
                Row(
                  children: [
                    KueskiNetworkCacheImage(
                      imageUrl: movie.posterPath,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(
                      width: sizeOf.width * 0.05,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ComboText(
                            text: 'Polularity:',
                            value: movie.popularity.toStringAsFixed(2),
                          ),
                          ComboText(
                            text: 'Votes:',
                            value: movie.voteCount.toStringAsFixed(2),
                          ),
                          ComboText(
                            text: 'Votes Average:',
                            value: movie.voteAverage.toStringAsFixed(2),
                          ),
                          ComboText(
                            text: 'Original title:',
                            value: movie.originalTitle,
                          ),
                          ComboText(
                            text: 'Release date:',
                            value: movie.releaseDate.yyyymmddFromat,
                          ),
                          ComboText(
                            text: 'Original Language:',
                            value: movie.originalLanguage,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeOf.height * 0.05,
                ),
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.overview,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
