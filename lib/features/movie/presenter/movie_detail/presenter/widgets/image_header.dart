import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class ImageHader extends StatelessWidget {
  const ImageHader({
    super.key,
    required this.movie,
    required this.sizeOf,
  });
  final MovieEntity movie;
  final Size sizeOf;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: sizeOf.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(movie.fullbdPath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          width: double.infinity,
        ),
        const SafeArea(
          child: BackButton(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
