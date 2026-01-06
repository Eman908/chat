import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.system;

  void changeTheme(ThemeMode newTheme) {
    appTheme = newTheme;
    notifyListeners();
  }
}
