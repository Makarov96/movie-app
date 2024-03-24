import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/router/routes.dart';

void main() {
  test('Routes.home creates Route with correct name and path', () {
    const route = Routes.home();
    expect(route.name, 'home');
    expect(route.path, '/');
  });

  test('Routes.movie creates Route with correct name and path', () {
    const route = Routes.movie();
    expect(route.name, 'movie');
    expect(route.path, '/'); // Consider testing if a specific path is needed
  });

  test('Routes.movieDetails creates Route with correct name and path', () {
    const route = Routes.movieDetails();
    expect(route.name, 'movie-details');
    expect(route.path, 'movie-details');
  });
  test('Routes.custom with empty path creates Route with expected values', () {
    const route = Routes(name: 'custom', path: '');
    expect(route.name, 'custom');
    expect(route.path, '');
  });
}
