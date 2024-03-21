import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieHome extends StatelessWidget {
  const MovieHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MoviewLayoutHome(),
    );
  }

  static Widget builder(BuildContext _, GoRouterState __) {
    return const MovieHome();
  }
}

class MoviewLayoutHome extends StatelessWidget {
  const MoviewLayoutHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('hello world'),
      ],
    );
  }
}
