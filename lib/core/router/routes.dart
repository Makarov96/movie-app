class Routes {
  const Routes({
    required this.name,
    required this.path,
  });

  Routes.home()
      : name = 'home',
        path = '/';

  Routes.movie()
      : name = 'movie',
        path = '/';

  Routes.movieDetails()
      : name = 'movie-details',
        path = 'movie-details';
  final String name;
  final String path;
}
