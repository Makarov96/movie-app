import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class MovieResultEntity extends Equatable {
  const MovieResultEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [
        page,
        results,
        totalPages,
        totalResults,
      ];
}
