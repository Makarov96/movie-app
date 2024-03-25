import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/router/routes.dart';

void main() {
  test('Routes.splash creates Route with correct name and path', () {
    const route = Routes.splash();
    expect(route.name, 'splash-screen');
    expect(route.path, '/');
  });

  test('Routes.movie creates Route with correct name and path', () {
    const route = Routes.movie();
    expect(route.name, 'movie');
    expect(route.path, '/movie');
  });

  test('Routes.recommended creates Route with correct name and path', () {
    const route = Routes.movieRecommended();
    expect(route.name, 'movie-recommended');
    expect(route.path, '/movie-recommended');
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
