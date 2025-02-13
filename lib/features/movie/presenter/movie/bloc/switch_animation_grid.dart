import 'package:flutter/material.dart';

class SwitchAnimationgrid extends ChangeNotifier {
  var switchToGrid = false;
  void toggle() {
    if (switchToGrid) {
      switchToGrid = false;
    } else {
      switchToGrid = true;
    }

    notifyListeners();
  }

  var switchToGridPM = false;
  void togglePM() {
    if (switchToGridPM) {
      switchToGridPM = false;
    } else {
      switchToGridPM = true;
    }

    notifyListeners();
  }
}
