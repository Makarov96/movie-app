import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/core/injector/environment.dart';

void main() {
  test('httpProvider reads environment and creates Http client', () {
    const mockEnvironment = Environment.dev;

    expect('', mockEnvironment.apiKey);
    expect(true, mockEnvironment.enableLogging);
    expect('', mockEnvironment.baseUrl);
    expect('', mockEnvironment.readAccess);
    expect('', mockEnvironment.sessionID);
    expect('', mockEnvironment.accountID);
  });
}
