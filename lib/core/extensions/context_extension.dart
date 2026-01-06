import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
  double get heightSized => MediaQuery.sizeOf(this).height;
  double get widthSized => MediaQuery.sizeOf(this).width;
}
