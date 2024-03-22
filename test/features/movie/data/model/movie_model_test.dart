import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/data/model/movie_model.dart';

void main() {
  final dateTimeNow = DateTime.now();
  group(
    'test all cases',
    () {
      test('toMap converts MovieEntity properties to a Map', () {
        // Create a mock MovieEntity
        final mockMovieEntity = MovieModel(
          adult: false,
          backdropPath: '/path/to/backdrop.jpg',
          genreIds: const [28, 12, 878],
          id: 12345,
          originalLanguage: 'en',
          originalTitle: 'The Mock Movie',
          overview: 'A thrilling mock movie about...',
          popularity: 8.5,
          posterPath: '/path/to/poster.jpg',
          releaseDate: dateTimeNow,
          title: 'The Mock Movie',
          video: false,
          voteAverage: 7.8,
          voteCount: 1234,
        );

        // No need to mock JsonMapper for toMap (it doesn't use it)
        final movieModel = MovieModel.fromMap(mockMovieEntity.toMap());

        final expectedMap = {
          'adult': false,
          'backdrop_path': '/path/to/backdrop.jpg',
          'genre_ids': [28, 12, 878],
          'id': 12345,
          'original_language': 'en',
          'original_title': 'The Mock Movie',
          'overview': 'A thrilling mock movie about...',
          'popularity': 8.5,
          'poster_path': '/path/to/poster.jpg',
          'release_date': dateTimeNow.toString(),
          'title': 'The Mock Movie',
          'video': false,
          'vote_average': 7.8,
          'vote_count': 1234,
        };

        expect(movieModel.toMap(), expectedMap);
      });
    },
  );
}
