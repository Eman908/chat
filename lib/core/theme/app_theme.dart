import 'package:chat/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.purple,
      onPrimary: AppColors.white,
      secondary: AppColors.green,
      onSecondary: AppColors.black,
      error: Colors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.purple),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.purple,
      onPrimary: AppColors.white,
      secondary: AppColors.green,
      onSecondary: AppColors.black,
      error: Colors.red,
      onError: AppColors.white,
      surface: AppColors.black,
      onSurface: AppColors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.purple),
      titleMedium: TextStyle(color: AppColors.purple),
      titleSmall: TextStyle(color: AppColors.purple),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),
    ),
  );
}
