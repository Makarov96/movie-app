import 'package:flutter_test/flutter_test.dart';
import 'package:kueski_challenge/features/movie/presenter/movie/bloc/switch_animation_grid.dart';

import 'package:mocktail/mocktail.dart';

class MockSwitchAnimationgrid extends Mock implements SwitchAnimationgrid {}

void main() {
  late SwitchAnimationgrid switchAnimationGridProvider;
  setUp(
    () {
      switchAnimationGridProvider = SwitchAnimationgrid();
    },
  );
  group('SwitchAnimationgrid tests', () {
    test('toggle() method should invert switchToGrid', () {
      switchAnimationGridProvider.toggle();

      expect(switchAnimationGridProvider.switchToGrid, true);
    });

    test('toggle() method should invert switchToGrid', () {
      switchAnimationGridProvider.switchToGrid = true;
      switchAnimationGridProvider.toggle();

      expect(switchAnimationGridProvider.switchToGrid, false);
    });

    test('togglePM() method should invert switchToGridPM', () {
      switchAnimationGridProvider.togglePM();

      expect(switchAnimationGridProvider.switchToGridPM, true);
    });
    test('togglePM() method should invert switchToGridPM', () {
      switchAnimationGridProvider.switchToGridPM = true;
      switchAnimationGridProvider.togglePM();

      expect(switchAnimationGridProvider.switchToGridPM, false);
    });
  });
}
