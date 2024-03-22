import 'package:flutter/material.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class KueskieCard extends StatelessWidget {
  const KueskieCard({
    super.key,
    this.isFavorite = false,
    this.onFavoritePressed,
    this.onPressedCard,
    required this.imagePath,
    required this.title,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
    required this.movieId,
  });

  final VoidCallback? onFavoritePressed;
  final VoidCallback? onPressedCard;
  final String imagePath;
  final String title;
  final double popularity;
  final int voteCount;
  final double voteAverage;
  final bool isFavorite;
  final String movieId;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: onPressedCard,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imagePath,
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
                Text(
                  title,
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
                        text: popularity.toStringAsFixed(3),
                      ),
                      BadgeIcon(
                        icon: Icons.how_to_vote_outlined,
                        text: voteCount.toStringAsFixed(3),
                      ),
                      BadgeIcon(
                        icon: Icons.percent_outlined,
                        text: voteAverage.toStringAsFixed(3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton.small(
            heroTag: Key(movieId),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: onFavoritePressed,
            backgroundColor: Colors.white.withOpacity(
              0.4,
            ),
            child: Icon(
              Icons.star,
              color: isFavorite ? Colors.yellow : Colors.white.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
