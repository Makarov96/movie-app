import 'dart:convert';

import 'package:kueski_challenge/features/movie/_module/strings/movie_strings.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

extension AddExtract on MovieEntity {
  String get fullPath => posterPath == MovieStrings.alternativeImage
      ? MovieStrings.alternativeImage
      : '${MovieStrings.recoveryImagePath}$posterPath';
  String get fullbdPath => backdropPath == MovieStrings.alternativeImage
      ? backdropPath
      : '${MovieStrings.recoveryImagePath}$backdropPath';
}

extension Exist on List<int> {
  bool existMovie({required int movieId}) {
    final map = asMap();
    return map.values.any((checker) => checker == movieId);
  }
}
