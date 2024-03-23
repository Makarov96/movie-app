import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/injector/environment.dart';
import 'package:kueski_challenge/core/injector/providers.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';
import 'package:mocktail/mocktail.dart';

import '../../common/helper/provider_scoper_mock.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group(
    'should be return a success case',
    () {
      test('When is implemented', () {
        final container = createContainer(
          overrides: [
            Providers.enviroment.overrideWith(
              (ref) => Environment.dev,
            )
          ],
        );
        final reader = container.read(Providers.enviroment);
        expect('', reader.apiKey);
        expect(true, reader.enableLogging);
        expect('', reader.baseUrl);
      });

      test(
        'when is unimplemented',
        () {
          final containerWrong = createContainer(
            overrides: [],
          );
          try {
            containerWrong.read(Providers.enviroment);
          } catch (e) {
            expect(e, isA<UnimplementedError>());
          }
        },
      );
    },
  );

  group(
    'test of http provider',
    () {
      test(
        'should be return a http isntace',
        () {
          final container = createContainer(
            overrides: [
              Providers.enviroment.overrideWith(
                (ref) => Environment.dev,
              ),
              Providers.httpProvider.overrideWith(
                (ref) {
                  final env = ref.read(Providers.enviroment);
                  final enableLogging = env.enableLogging;
                  final dio = MockDio();
                  return Http(dio: dio, enableLogging: enableLogging);
                },
              ),
            ],
          );

          final reader = container.read(Providers.httpProvider);
          expect(reader, isA<Http>());
        },
      );
      test(
        'should be return a provider without override',
        () {
          final container = createContainer(
            overrides: [
              Providers.enviroment.overrideWith(
                (ref) => Environment.dev,
              ),
            ],
          );

          final reader = container.read(Providers.httpProvider);
          expect(reader, isA<Http>());
        },
      );
    },
  );
}
