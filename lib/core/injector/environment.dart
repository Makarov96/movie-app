enum Environment {
  dev(),
  staging(),
  prod();

  const Environment();

  bool get enableLogging => this != Environment.prod;
  String get apiKey => const String.fromEnvironment('MOVIE_API_KEY');
  String get baseUrl => const String.fromEnvironment('baseUrl');
}
