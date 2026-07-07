import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrizham/core/themes/light_theme_data.dart';
import 'package:nutrizham/core/themes/dark_theme_data.dart';

class AppTheme {
  static final ThemeData light = buildLightTheme(_base(Brightness.light));
  static final ThemeData dark = buildDarkTheme(_base(Brightness.dark));

  static ThemeData _base(Brightness brightness) {
    return ThemeData(
      fontFamily: 'Rudaw',
      useMaterial3: true,
      brightness: brightness,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
