import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/_module/strings/movie_strings.dart';

void main() {
  const String baseForTest = "https://api.steven.test.org";
  group('MovieStrings', () {
    test('alternativeImage is a valid URL', () {
      const url = MovieStrings.alternativeImage;
      expect(Uri.parse(url).isAbsolute, true);
    });

    test('query1 is a well-formed URL fragment', () {
      const fragment = MovieStrings.query1;

      expect(fragment.contains('include_adult=false'), true);
      expect(fragment.contains('include_video=false'), true);
      expect(fragment.contains('language=en-US'), true);
      expect(fragment.contains('page='), true);
    });

    test('buildFavoriteUrl creates a correct URL', () {
      const userId = '12345';
      const apiKey = 'YOUR_API_KEY';
      const sessionId = 'SESSION_ID';

      final url =
          '$baseForTest${MovieStrings.buildFavoriteUrl(userId: userId, apiKey: apiKey, sessionId: sessionId)}';

      expect(Uri.parse(url).isAbsolute, true);
      expect(url.contains('/account/$userId/favorite'), true);
      expect(url.contains('api_key=$apiKey'), true);
      expect(url.contains('session_id=$sessionId'), true);
    });

    test('buildGetFavoriteUrl creates a correct URL', () {
      const userId = '12345';
      const apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
      const sessionId = 'SESSION_ID'; // Replace with your actual session ID
      const page = 2;

      final url =
          '$baseForTest${MovieStrings.buildGetFavoriteUrl(userId: userId, apiKey: apiKey, sessionId: sessionId, page: page)}';

      expect(Uri.parse(url).isAbsolute, true);
      expect(url.contains('/account/$userId/favorite/movies'), true);
      expect(url.contains('api_key=$apiKey'), true);
      expect(url.contains('session_id=$sessionId'), true);
      expect(url.contains('page=$page'), true);
    });
  });
}
