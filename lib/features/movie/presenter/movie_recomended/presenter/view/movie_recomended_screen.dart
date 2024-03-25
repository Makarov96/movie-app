import 'package:flutter/material.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_recomended/presenter/widget/movie_list_view.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_recomended/presenter/widget/warning_banner.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieRecommended extends StatelessWidget {
  const MovieRecommended({
    super.key,
    required this.showBanner,
  });
  final bool showBanner;

  static Widget builder(BuildContext context, GoRouterState state) {
    return MovieRecommended(
      showBanner: state.extra as bool,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.texts.recommended.title),
      ),
      body: Stack(
        children: [
          const MovieList(),
          showBanner
              ? const Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: WarningBanner(),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
