import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kueski_challenge/core/injector/environment.dart';

class Providers {
  const Providers._();
  static final enviroment = Provider<Environment>(
    (ref) => throw UnimplementedError(),
  );
}
