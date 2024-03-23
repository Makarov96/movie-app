import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/utils/date_utils.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieDetailLayout extends StatelessWidget {
  const MovieDetailLayout({
    super.key,
    required this.movie,
  });
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Column(
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
              imageUrl: movie.fullPath,
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
                    text: context.texts.details.popularity,
                    value: movie.popularity.toStringAsFixed(2),
                  ),
                  ComboText(
                    text: context.texts.details.votes,
                    value: movie.voteCount.toStringAsFixed(2),
                  ),
                  ComboText(
                    text: context.texts.details.votesAverage,
                    value: movie.voteAverage.toStringAsFixed(2),
                  ),
                  ComboText(
                    text: context.texts.details.originalTitle,
                    value: movie.originalTitle,
                  ),
                  ComboText(
                    text: context.texts.details.releaseDate,
                    value: movie.releaseDate.yyyymmddFromat,
                  ),
                  ComboText(
                    text: context.texts.details.originalLanguage,
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
        Text(
          context.texts.details.overview,
          style: const TextStyle(
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
    );
  }
}
