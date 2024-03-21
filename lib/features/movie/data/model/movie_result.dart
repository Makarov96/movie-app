import 'package:kueski_challenge/features/movie/data/model/movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieResult extends Equatable {
  const MovieResult({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
        page: json["page"] ?? 0,
        results: List<MovieEntity>.from(
            (json["results"] ?? []).map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  @override
  List<Object> get props => [
        page,
        results,
        totalPages,
        totalResults,
      ];
}
