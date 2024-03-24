import 'package:flutter/material.dart';

class KueskiFavoriteButton extends StatelessWidget {
  const KueskiFavoriteButton({
    super.key,
    required this.id,
    required this.onPressed,
    required this.isFavorite,
  });
  final String id;
  final VoidCallback onPressed;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: Key(id),
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
        color: isFavorite ? Colors.yellow : Colors.white.withOpacity(0.6),
      ),
    );
  }
}
