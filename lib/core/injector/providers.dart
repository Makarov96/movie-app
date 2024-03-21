import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class Providers {
  const Providers._();
  static final enviroment = Provider<Environment>(
    (ref) => throw UnimplementedError(),
  );
}
