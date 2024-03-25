import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/core/utils/status.dart';
import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/domain/entity/movie_entity.dart';
import 'package:kueski_challenge/features/movie/domain/injector/movie_injector.dart';
import 'package:kueski_challenge/features/movie/domain/repository/movie_repository.dart';
import 'package:kueski_challenge/features/movie/presenter/movie_recomended/presenter/bloc/get_favorite_list.dart';

import '../../../../../../common/data/api_mock/api_mock.dart';
import '../../../../../../common/helper/provider_scoper_mock.dart';

void main() {
  late final MovieRepository repository;
  var expectedPage = 1;
  List<int> cpMovies = [];
  const expectedTotalPage = 0;
  List<MovieEntity> items = [];
  setUp(() {
    repository = MovieApi(
      http: ApiMockInit.mockSuccessHttp,
      env: Environment.dev,
    );
  });
  group(
    'test success case',
    () {
      test(
        'should be return a copy list',
        () async {
          ({Status status, List<MovieEntity> movies}) expectedStatus =
              (status: Status.success, movies: <MovieEntity>[]);
          //arrange
          final container = createContainer(overrides: [
            MovieInjector.getFavoriteMovies.overrideWith(
              (ref) => GetFavoriteList(movieRepository: repository),
            )
          ]);

          //act
          final either = await repository.getMovies(page: expectedPage++);
          await container
              .read(MovieInjector.getFavoriteMovies)
              .getList(isListener: false);
          either.when(
            (statusCode, error) => expectedStatus =
                (status: Status.error, movies: <MovieEntity>[]),
            () => expectedStatus =
                (status: Status.loading, movies: <MovieEntity>[]),
            (response) {
              cpMovies = response.results.map((e) => e.id).toList();
              items = response.results;
              expect(expectedTotalPage, response.totalPages);

              expect(cpMovies, <int>[12345]);
              expectedStatus =
                  (status: Status.success, movies: items.toSet().toList());
              container.read(MovieInjector.getFavoriteMovies).status =
                  expectedStatus;
            },
          );

          expect(container.read(MovieInjector.getFavoriteMovies).status,
              expectedStatus);
        },
      );
    },
  );
}
