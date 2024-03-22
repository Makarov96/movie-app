import 'package:kueski_challenge/features/movie/data/model/movie_model.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_result_entity.dart';

class MovieResultModel extends MovieResultEntity {
  const MovieResultModel({
    required super.page,
    required super.results,
    required super.totalPages,
    required super.totalResults,
  });

  factory MovieResultModel.fromJson(Map<String, dynamic> json) =>
      MovieResultModel(
        page: json["page"] ?? 0,
        results: List<MovieEntity>.from(
            (json["results"] ?? []).map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );
}
