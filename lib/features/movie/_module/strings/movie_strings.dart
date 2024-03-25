final class MovieStrings {
  static const alternativeImage =
      'https://firebasestorage.googleapis.com/v0/b/palm-1ff69.appspot.com/o/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg?alt=media&token=339eb46b-e821-425f-92e2-ad8ffd4a6bf0';

  static const _version = '/3/';
  static const query1 =
      '${_version}discover/movie?include_adult=false&include_video=false&language=en-US&page=';
  static const query2Sort = '&sort_by=popularity.desc';
  static const query3Release =
      '&sort_by=popularity.desc&with_release_type=2|3&release_date.gte=2024-02-14&release_date.lte=';
  static const recoveryImagePath = 'http://image.tmdb.org/t/p/w500/';

  static String buildFavoriteUrl({
    required String userId,
    required String apiKey,
    required String sessionId,
  }) =>
      '$_version/account/$userId/favorite?api_key=$apiKey&session_id=$sessionId';
  static String buildGetFavoriteUrl({
    required String userId,
    required String apiKey,
    required String sessionId,
    required int page,
  }) =>
      '$_version/account/$userId/favorite/movies?api_key=$apiKey&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$page';
}
