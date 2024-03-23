import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

extension Providers on Never {
  static final enviroment = Provider<Environment>(
    (ref) => throw UnimplementedError(),
  );
  static final httpProvider = Provider<Http>(
    (ref) {
      final env = ref.read(enviroment);
      final enableLogging = env.enableLogging;
      final dio = Dio(BaseOptions(
        baseUrl: env.baseUrl,
        headers: KueskieHeaders.addEntry({'Authorization': env.apiKey}),
      ));
      dio.interceptors.addAll([
        RetryInterceptor(dio: dio, enableLogging: enableLogging),
      ]);
      return Http(dio: dio, enableLogging: enableLogging);
    },
  );
}
