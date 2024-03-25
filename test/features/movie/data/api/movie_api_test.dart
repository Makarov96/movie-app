import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/features/movie/_module/strings/movie_strings.dart';

import 'package:kueski_challenge/features/movie/data/api/movie_api.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_result.dart';

import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/data/api_mock/api_mock.dart';

void main() {
  const userID = '123456789';
  const apiKey = '123456789';
  const sessionId = '123456789';
  const favoriteMovie = FavoriteMovieModel(mediaId: 123);
  group('get movies', () {
    test(
      'should be return a success case',
      () async {
        // Arrange
        const expectedPage = 1;
        final expectedData = {
          'results': [
            {
              "adult": false,
              "backdrop_path": "/1XDDXPXGiI8id7MrUxK36ke7gkX.jpg",
              "genre_ids": [28, 12, 16, 35, 10751],
              "id": 1011985,
              "original_language": "en",
              "original_title": "Kung Fu Panda 4",
              "overview":
                  "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
              "popularity": 5263.595,
              "poster_path": "/wkfG7DaExmcVsGLR4kLouMwxeT5.jpg",
              "release_date": "2024-03-02",
              "title": "Kung Fu Panda 4",
              "video": false,
              "vote_average": 6.935,
              "vote_count": 279
            }
          ]
        };
        var path =
            '${MovieStrings.query1}$expectedPage${MovieStrings.query2Sort}';
        final expectedResult = HttpResult<MovieResultModel>.ok(
            MovieResultModel.fromJson(expectedData), 201);

        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenAnswer((_) => Future.value(expectedResult));

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        final result = await movieApi.getMovies(page: expectedPage);

        // Assert
        verify(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).called(1);
        expect(result, expectedResult);

        expect(result.okValue, expectedResult.okValue);
      },
    );

    test(
      'should be return a failure case',
      () async {
        // Arrange
        const expectedPage = 2;
        final expectedError = Exception('Failed to fetch movies');
        var path =
            '${MovieStrings.query1}$expectedPage${MovieStrings.query2Sort}';
        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenThrow(expectedError);

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        try {
          await movieApi.getMovies(page: expectedPage);
          fail('Expected an exception');
        } on Exception catch (error) {
          // Assert
          expect(error, expectedError);
        }

        verify(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).called(1);
      },
    );
  });

  group('get playing movies', () {
    test(
      'should be return a success case',
      () async {
        // Arrange
        const expectedPage = 1;
        final expectedData = {'results': []};
        var path =
            '${MovieStrings.query1}$expectedPage${MovieStrings.query2Sort}';
        final expectedResult = HttpResult<MovieResultModel>.ok(
            MovieResultModel.fromJson(expectedData), 201);

        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenAnswer((_) => Future.value(expectedResult));

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        final result = await movieApi.playingMovies(page: expectedPage);

        // Assert
        verify(() => ApiMockInit.mockHttp.send(
              path,
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
        var path =
            '${MovieStrings.query1}$expectedPage${MovieStrings.query2Sort}';
        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenThrow(expectedError);

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        try {
          await movieApi.playingMovies(page: expectedPage);
          fail('Expected an exception');
        } on Exception catch (error) {
          // Assert
          expect(error, expectedError);
        }

        verify(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).called(1);
      },
    );
  });

  group('add favorites movies', () {
    test(
      'should be return a success case',
      () async {
        // Arrange
        final expectedResult = HttpResult<bool>.ok(true, 200);
        var path = MovieStrings.buildFavoriteUrl(
            userId: userID, apiKey: apiKey, sessionId: sessionId);

        when(() => ApiMockInit.mockHttp.send(
              method: HttpMethod.post,
              body: favoriteMovie.toJson(),
              path,
              parser: (statusCode, value) => statusCode <= 400,
            )).thenAnswer((_) => Future.value(HttpResult<bool>.ok(true, 200)));

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        final result = await movieApi.addFavoriteMovie(movie: favoriteMovie);

        // Assert

        expect(result, isA<Ok<bool>>());
        expect(result, expectedResult);
      },
    );

    test(
      'should be return a failure case',
      () async {
        // Arrange

        final expectedError = Exception('Failed to fetch movies');
        var path = MovieStrings.buildFavoriteUrl(
            userId: userID, apiKey: apiKey, sessionId: sessionId);

        when(() => ApiMockInit.mockHttp.send(
              method: HttpMethod.post,
              body: favoriteMovie.toJson(),
              path,
              parser: (statusCode, value) => statusCode <= 400,
            )).thenThrow(expectedError);

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        try {
          await movieApi.addFavoriteMovie(movie: favoriteMovie);
          fail('Expected an exception');
        } on Exception catch (error) {
          // Assert
          expect(error, expectedError);
        }
      },
    );
  });

  group('get favorites movies', () {
    test(
      'should be return a success case',
      () async {
        // Arrange
        const expectedPage = 1;
        final expectedData = {'results': []};
        var path = MovieStrings.buildGetFavoriteUrl(
          userId: userID,
          apiKey: apiKey,
          sessionId: sessionId,
          page: expectedPage,
        );

        final expectedResult = HttpResult<MovieResultModel>.ok(
            MovieResultModel.fromJson(expectedData), 201);

        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenAnswer((_) => Future.value(expectedResult));

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        final result = await movieApi.getFavoritesMovies(page: expectedPage);

        // Assert

        expect(result, expectedResult);

        expect(result.okValue, expectedResult.okValue);
      },
    );

    test(
      'should be return a failure case',
      () async {
        // Arrange
        const expectedPage = 2;
        final expectedError = Exception('Failed to fetch movies');
        var path = MovieStrings.buildGetFavoriteUrl(
          userId: userID,
          apiKey: apiKey,
          sessionId: sessionId,
          page: expectedPage,
        );
        when(() => ApiMockInit.mockHttp.send(
              path,
              parser: (statusCode, value) => MovieResultModel.fromJson(value),
            )).thenThrow(expectedError);

        final movieApi =
            MovieApi(http: ApiMockInit.mockHttp, env: Environment.dev);

        // Act
        try {
          await movieApi.getFavoritesMovies(page: expectedPage);
          fail('Expected an exception');
        } on Exception catch (error) {
          // Assert
          expect(error, expectedError);
        }
      },
    );
  });
}
