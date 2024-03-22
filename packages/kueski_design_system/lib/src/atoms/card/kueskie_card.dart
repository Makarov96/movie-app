import 'package:flutter/material.dart';
import 'package:kueski_design_system/kueski_design_system.dart';

class KueskieCard extends StatelessWidget {
  const KueskieCard({
    super.key,
    required this.onFavoritePressed,
    required this.imagePath,
    required this.title,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
  });

  final VoidCallback onFavoritePressed;
  final String imagePath;
  final String title;
  final double popularity;
  final int voteCount;
  final double voteAverage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'http://image.tmdb.org/t/p/w500/$imagePath',
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
              onPressed: onFavoritePressed,
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
    );
  }
}
