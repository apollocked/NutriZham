import 'package:flutter/material.dart';

const String _font = 'Rudaw';

TextStyle _style({
  required double fontSize,
  required FontWeight fontWeight,
  Color? color,
  double? letterSpacing,
}) {
  return TextStyle(
    fontFamily: _font,
    inherit: false,
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    color: color,
    textBaseline: TextBaseline.alphabetic,
  );
}

TextTheme buildTextTheme(Color primary, Color secondary) {
  return TextTheme(
    displayLarge: _style(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -1.0, color: primary),
    displayMedium: _style(fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: primary),
    displaySmall: _style(fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: -0.25, color: primary),
    headlineLarge: _style(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.25, color: primary),
    headlineMedium: _style(fontSize: 20, fontWeight: FontWeight.w600, color: primary),
    headlineSmall: _style(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
    titleLarge: _style(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.15, color: primary),
    titleMedium: _style(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: primary),
    titleSmall: _style(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: primary),
    bodyLarge: _style(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: primary),
    bodyMedium: _style(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: primary),
    bodySmall: _style(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: secondary),
    labelLarge: _style(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: primary),
    labelMedium: _style(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: secondary),
    labelSmall: _style(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: secondary),
  );
}


