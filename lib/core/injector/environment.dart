enum Environment {
  dev(),
  staging(),
  prod();

  const Environment();

  bool get enableLogging => this != Environment.prod;
  String get readAccess =>
      const String.fromEnvironment('MOVIE_API_KEY_READ_ACCESS');
  String get baseUrl => const String.fromEnvironment('BASE_URL');
  String get sessionID => const String.fromEnvironment('SESSION_ID');
  String get accountID => const String.fromEnvironment('ACCOUNT_ID');
  String get apiKey => const String.fromEnvironment('API_KEY');
}
