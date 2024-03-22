enum Environment {
  dev(),
  staging(),
  prod();

  const Environment();

  bool get enableLogging => this != Environment.prod;
  String get apiKey =>
      const String.fromEnvironment('MOVIE_API_KEY_READ_ACCESS');
  String get baseUrl => const String.fromEnvironment('BASE_URL');
}
