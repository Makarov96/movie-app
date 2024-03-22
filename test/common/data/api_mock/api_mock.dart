import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

final class MockHttp extends Mock implements Http {
  @override
  Future<HttpResult<T>> send<T>(
    String path, {
    required T Function(int statusCode, dynamic data) parser,
    HttpMethod method = HttpMethod.get,
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> headers = const {},
    Map<String, dynamic>? body,
    String contentType = Headers.jsonContentType,
    bool autoDecodeReponse = true,
    Duration? receiveTimeout,
    bool cancel = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(#checkApiResponse, null),
      ) as Future<HttpResult<T>>);
}

final class ApiMockInit {
  static final MockHttp mockHttp = MockHttp();
}
