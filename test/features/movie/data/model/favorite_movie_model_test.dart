import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/data/model/favorite_movie_model.dart';

void main() {
  group('FavoriteMovieModel', () {
    test('constructor creates model with defaults', () {
      const model = FavoriteMovieModel(mediaId: 12345);

      expect(model.mediaType, 'movie');
      expect(model.mediaId, 12345);
      expect(model.favorite, true);
    });

    test('constructor sets all properties', () {
      const mediaType = 'tv';
      const mediaId = 54321;
      const favorite = false;

      const model = FavoriteMovieModel(
        mediaId: mediaId,
        mediaType: mediaType,
        favorite: favorite,
      );

      expect(model.mediaType, mediaType);
      expect(model.mediaId, mediaId);
      expect(model.favorite, favorite);
    });

    test('fromJson parses JSON correctly', () {
      const json = {
        "media_type": "tv",
        "media_id": 98765,
        "favorite": false,
      };

      final model = FavoriteMovieModel.fromJson(json);

      expect(model.mediaType, json["media_type"]);
      expect(model.mediaId, json["media_id"]);
      expect(model.favorite, json["favorite"]);
    });

    test('toJson converts model to JSON correctly', () {
      const mediaType = 'movie';
      const mediaId = 12345;
      const favorite = true;

      const model = FavoriteMovieModel(
        mediaId: mediaId,
        mediaType: mediaType,
        favorite: favorite,
      );

      final json = model.toJson();

      expect(json["media_type"], mediaType);
      expect(json["media_id"], mediaId);
      expect(json["favorite"], favorite);
    });
  });
}
