import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kueski_challenge/features/movie/_module/keys/movie_keys.dart';
import 'package:kueski_challenge/main_development.dart' as app;

Future<void> restoreFlutterError(Future<void> Function() call) async {
  final originalOnError = FlutterError.onError!;
  await call();
  final overriddenOnError = FlutterError.onError!;

  // restore FlutterError.onError
  FlutterError.onError = (FlutterErrorDetails details) {
    if (overriddenOnError != originalOnError) overriddenOnError(details);
    originalOnError(details);
  };
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets(
    'should be return a main app',
    (tester) async {
      //setup

      await restoreFlutterError(() async {
        WidgetsFlutterBinding.ensureInitialized();
        app.main();
        await tester.pumpAndSettle();
      });
      //do

      //assert
      expect(find.text('Kueski Movie'), findsOneWidget);
    },
    skip: false,
    timeout: const Timeout(Duration(minutes: 1)),
  );

  testWidgets(
    'finding a card',
    (tester) async {
      //setup

      await restoreFlutterError(() async {
        WidgetsFlutterBinding.ensureInitialized();
        app.main();
        await tester.pumpAndSettle();
      });
      //do
      await Future.delayed(const Duration(seconds: 10));
      final card = find.byKey(Moviekeys.kueskiCard).first;
      await tester.tap(card);
      await tester.pumpAndSettle();
      //assert

      expect(find.text('Overview:'), findsOneWidget);
    },
    skip: false,
    timeout: const Timeout(Duration(minutes: 10)),
  );
}
