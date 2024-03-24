class Routes {
  const Routes({
    required this.name,
    required this.path,
  });

  const Routes.home()
      : name = 'home',
        path = '/';

  const Routes.movie()
      : name = 'movie',
        path = '/';

  const Routes.movieDetails()
      : name = 'movie-details',
        path = 'movie-details';
  final String name;
  final String path;
}
