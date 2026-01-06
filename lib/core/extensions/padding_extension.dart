import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding horizontalPadding(double padding) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: padding),
      child: this,
    );
  }

  Padding verticalPadding(double padding) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: padding),
      child: this,
    );
  }

  Padding allPadding(double padding) {
    return Padding(padding: EdgeInsetsGeometry.all(padding), child: this);
  }
}
