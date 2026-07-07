import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class AppTheme {
  static const _font = 'Rudaw';

  static TextStyle _style({
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

  static TextTheme _textTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: _style(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: primary),
      displayMedium: _style(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: primary),
      displaySmall: _style(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
          color: primary),
      headlineLarge: _style(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
          color: primary),
      headlineMedium:
          _style(fontSize: 20, fontWeight: FontWeight.w600, color: primary),
      headlineSmall:
          _style(fontSize: 18, fontWeight: FontWeight.w600, color: primary),
      titleLarge: _style(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: primary),
      titleMedium: _style(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: primary),
      titleSmall: _style(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: primary),
      bodyLarge: _style(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: primary),
      bodyMedium: _style(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: primary),
      bodySmall: _style(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: secondary),
      labelLarge: _style(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: primary),
      labelMedium: _style(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: secondary),
      labelSmall: _style(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: secondary),
    );
  }

  static ThemeData _base(Brightness brightness) {
    return ThemeData(
      fontFamily: _font,
      useMaterial3: true,
      brightness: brightness,
      primaryColor: AppColors.primary,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData light = _base(Brightness.light).copyWith(
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primarySoft,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.accentTeal,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE8F5F1),
      onSecondaryContainer: Color(0xFF214C43),
      tertiary: AppColors.accentOrange,
      onTertiary: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      onSurfaceVariant: AppColors.lightTextSecondary,
      outline: AppColors.lightOutline,
      outlineVariant: AppColors.lightOutlineVariant,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF991B1B),
      surfaceContainerHighest: AppColors.lightSurfaceContainer,
      surfaceContainerLow: AppColors.lightBackground,
      surfaceContainer: AppColors.lightSurfaceContainer,
      surfaceContainerHigh: AppColors.lightSurfaceHigh,
    ),
    textTheme: _textTheme(AppColors.lightText, AppColors.lightTextSecondary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: AppColors.lightText,
          textBaseline: TextBaseline.alphabetic),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.lightSurface.withOpacity(0.75),
      indicatorColor: AppColors.primary.withOpacity(0.12),
      indicatorShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const TextStyle(
              fontFamily: _font,
              inherit: false,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 0.3,
              textBaseline: TextBaseline.alphabetic);
        }
        return const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.lightTextSecondary,
            letterSpacing: 0.3,
            textBaseline: TextBaseline.alphabetic);
      }),
      iconTheme: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary, size: 24);
        }
        return const IconThemeData(
            color: AppColors.lightTextSecondary, size: 22);
      }),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.lightCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black.withOpacity(0.04),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.lightOutline)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          color: AppColors.lightTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic),
      floatingLabelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          textBaseline: TextBaseline.alphabetic),
      prefixIconColor: AppColors.lightTextSecondary,
      suffixIconColor: AppColors.lightTextSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.primary.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            textBaseline: TextBaseline.alphabetic),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            textBaseline: TextBaseline.alphabetic),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            textBaseline: TextBaseline.alphabetic),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textBaseline: TextBaseline.alphabetic),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightSurfaceContainer,
      selectedColor: AppColors.primary.withOpacity(0.12),
      checkmarkColor: AppColors.primary,
      labelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText,
          textBaseline: TextBaseline.alphabetic),
      secondaryLabelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextSecondary,
          textBaseline: TextBaseline.alphabetic),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), side: BorderSide.none),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    ),
    dividerTheme: const DividerThemeData(
        color: AppColors.lightOutline, thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.lightText,
          textBaseline: TextBaseline.alphabetic),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      contentTextStyle: TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      showDragHandle: true,
      surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText,
          textBaseline: TextBaseline.alphabetic),
      subtitleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          color: AppColors.lightTextSecondary,
          textBaseline: TextBaseline.alphabetic),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.lightOutline))),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
    ),
  );

  static ThemeData dark = _base(Brightness.dark).copyWith(
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF4C1D95),
      onPrimaryContainer: AppColors.primaryLight,
      secondary: AppColors.accentTeal,
      onSecondary: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFECACA),
      surfaceContainerHighest: AppColors.darkSurfaceContainer,
      surfaceContainerLow: AppColors.darkBackground,
      surfaceContainer: AppColors.darkSurfaceContainer,
      surfaceContainerHigh: AppColors.darkSurfaceHigh,
    ),
    textTheme: _textTheme(AppColors.darkText, AppColors.darkTextSecondary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: AppColors.darkText,
          textBaseline: TextBaseline.alphabetic),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.darkSurface.withOpacity(0.85),
      indicatorColor: AppColors.primary.withOpacity(0.2),
      indicatorShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const TextStyle(
              fontFamily: _font,
              inherit: false,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 0.3,
              textBaseline: TextBaseline.alphabetic);
        }
        return const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.darkTextSecondary,
            letterSpacing: 0.3,
            textBaseline: TextBaseline.alphabetic);
      }),
      iconTheme: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary, size: 24);
        }
        return const IconThemeData(
            color: AppColors.darkTextSecondary, size: 22);
      }),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.darkCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black.withOpacity(0.3),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.darkOutline)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          color: AppColors.darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic),
      floatingLabelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          textBaseline: TextBaseline.alphabetic),
      prefixIconColor: AppColors.darkTextSecondary,
      suffixIconColor: AppColors.darkTextSecondary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
            fontFamily: _font,
            inherit: false,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            textBaseline: TextBaseline.alphabetic),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurfaceContainer,
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.darkText,
      labelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.darkText,
          textBaseline: TextBaseline.alphabetic),
      secondaryLabelStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary,
          textBaseline: TextBaseline.alphabetic),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), side: BorderSide.none),
    ),
    dividerTheme: const DividerThemeData(
        color: AppColors.darkOutline, thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
          textBaseline: TextBaseline.alphabetic),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      contentTextStyle: TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textBaseline: TextBaseline.alphabetic),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      showDragHandle: true,
      surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.darkText,
          textBaseline: TextBaseline.alphabetic),
      subtitleTextStyle: const TextStyle(
          fontFamily: _font,
          inherit: false,
          fontSize: 13,
          color: AppColors.darkTextSecondary,
          textBaseline: TextBaseline.alphabetic),
    ),
  );
}
