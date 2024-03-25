class Routes {
  const Routes({
    required this.name,
    required this.path,
  });

  const Routes.movieRecommended()
      : name = 'movie-recommended',
        path = '/movie-recommended';
  const Routes.splash()
      : name = 'splash-screen',
        path = '/';

  const Routes.movie()
      : name = 'movie',
        path = '/movie';

  const Routes.movieDetails()
      : name = 'movie-details',
        path = 'movie-details';
  final String name;
  final String path;
}
