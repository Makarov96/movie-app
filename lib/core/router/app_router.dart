import 'package:kueski_challenge/core/router/routes.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: Routes.home().path,
      routes: AppRouter.routes,
    );
  },
);

final class AppRouter {
  const AppRouter._();

  static List<GoRoute> get routes => [];
}
