import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

final class MovieInjector {
  static final authProvider = Provider<MovieRepository>(
    (ref) => MovieApi(
      http: ref.read(Providers.httpProvider),
    ),
  );
}
