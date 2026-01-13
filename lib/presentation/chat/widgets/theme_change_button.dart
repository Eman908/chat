import 'package:chat/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return IconButton(
      onPressed: () {
        ThemeMode newTheme;
        switch (provider.appTheme) {
          case ThemeMode.dark:
            newTheme = ThemeMode.light;
            break;
          case ThemeMode.light:
            newTheme = ThemeMode.system;
            break;
          case ThemeMode.system:
            newTheme = ThemeMode.dark;
        }
        provider.changeTheme(newTheme);
      },
      icon: Icon(
        provider.appTheme == ThemeMode.dark
            ? Icons.dark_mode
            : provider.appTheme == ThemeMode.light
            ? Icons.light_mode
            : Icons.brightness_auto,
      ),
    );
  }
}
