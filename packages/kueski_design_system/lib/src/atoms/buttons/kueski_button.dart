import 'package:flutter/material.dart';

class KueskiButton extends StatelessWidget {
  const KueskiButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    required this.isStretch,
  });
  final String? text;
  final VoidCallback onPressed;
  final bool isStretch;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return isStretch
        ? ElevatedButton(
            onPressed: onPressed,
            child: Icon(
              icon ?? Icons.star,
              color: Colors.pink.withOpacity(0.5),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(text ?? ''),
          );
  }
}
