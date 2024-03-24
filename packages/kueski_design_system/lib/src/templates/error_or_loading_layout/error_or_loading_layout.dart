import 'package:flutter/material.dart';

class ErrorOrLoadingLayout extends StatelessWidget {
  const ErrorOrLoadingLayout({super.key, this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        message == null
            ? const CircularProgressIndicator()
            : Text(message ?? ''),
      ],
    );
  }
}
