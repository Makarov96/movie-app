import 'package:flutter_test/flutter_test.dart';

import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/data/api_mock/api_mock.dart';

void main() {
  test(
    'should be return a success case',
    () async {
      // Arrange
      const expectedPage = 1;
      final expectedData = {'results': []}; // Example movie data
      final expectedResult = HttpResult<MovieResultModel>.ok(
          MovieResultModel.fromJson(expectedData), 201);

      when(() => ApiMockInit.mockHttp.send(
            '/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$expectedPage&sort_by=popularity.desc',
            parser: (statusCode, value) => MovieResultModel.fromJson(value),
          )).thenAnswer((_) => Future.value(expectedResult));

      final movieApi = MovieApi(http: ApiMockInit.mockHttp);

      // Act
      final result = await movieApi.getMovies(page: expectedPage);

      // Assert
      verify(() => ApiMockInit.mockHttp.send(
            '/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$expectedPage&sort_by=popularity.desc',
            parser: (statusCode, value) => MovieResultModel.fromJson(value),
          )).called(1);
      expect(result, expectedResult);
    },
  );

  test(
    'should be return a failure case',
    () async {
      // Arrange
      const expectedPage = 2;
      final expectedError = Exception('Failed to fetch movies');

      when(() => ApiMockInit.mockHttp.send(
            '/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$expectedPage&sort_by=popularity.desc',
            parser: (statusCode, value) => MovieResultModel.fromJson(value),
          )).thenThrow(expectedError);

      final movieApi = MovieApi(http: ApiMockInit.mockHttp);

      // Act
      try {
        await movieApi.getMovies(page: expectedPage);
        fail('Expected an exception');
      } on Exception catch (error) {
        // Assert
        expect(error, expectedError);
      }

      verify(() => ApiMockInit.mockHttp.send(
            '/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$expectedPage&sort_by=popularity.desc',
            parser: (statusCode, value) => MovieResultModel.fromJson(value),
          )).called(1);
    },
  );
}
