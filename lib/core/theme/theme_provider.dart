import 'package:chat/core/constants/app_constants.dart';
import 'package:chat/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ThemeProvider extends ChangeNotifier {
  final SharedPreferences _preferences = getIt();
  ThemeMode appTheme = ThemeMode.system;
  void changeTheme(ThemeMode newTheme) {
    appTheme = newTheme;
    _preferences.setString(AppConstants.kTheme, appTheme.name);
    notifyListeners();
  }

  ThemeMode loadPreferences() {
    var theme = _preferences.getString(AppConstants.kTheme);
    switch (theme) {
      case 'dark':
        return appTheme = ThemeMode.dark;
      case 'light':
        return appTheme = ThemeMode.light;
      default:
        return appTheme = ThemeMode.system;
    }
  }
}
