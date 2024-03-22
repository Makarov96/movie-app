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
}
