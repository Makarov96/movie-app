class Routes {
  const Routes({
    required this.name,
    required this.path,
  });

  Routes.home()
      : name = 'home',
        path = '/';

  final String name;
  final String path;
}
