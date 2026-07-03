import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData _base(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: AppColors.primaryGreen,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData light = _base(Brightness.light).copyWith(
    scaffoldBackgroundColor: const Color(0xFFF0F4F0),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryGreen,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryGreenSurface,
      onPrimaryContainer: AppColors.primaryGreenDark,
      secondary: AppColors.primaryGreen,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD1FAE5),
      onSecondaryContainer: Color(0xFF065F46),
      tertiary: AppColors.accentBlue,
      onTertiary: Colors.white,
      surface: Color(0xFFFFFFFF),
      onSurface: AppColors.lightText,
      onSurfaceVariant: AppColors.lightTextSecondary,
      outline: Color(0xFFD4DED4),
      outlineVariant: Color(0xFFE8F0E8),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: Color(0xFF991B1B),
      surfaceContainerHighest: Color(0xFFF0F7F0),
      surfaceContainerLow: Color(0xFFF5FAF5),
      surfaceContainer: Color(0xFFEAF3EA),
      surfaceContainerHigh: Color(0xFFE0EDE0),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: AppColors.lightText),
      displayMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: AppColors.lightText),
      displaySmall: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
          color: AppColors.lightText),
      headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
          color: AppColors.lightText),
      headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.lightText),
      headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.lightText),
      titleLarge: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: AppColors.lightText),
      titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.lightText),
      titleSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.lightText),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppColors.lightText),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.lightText),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.lightTextSecondary),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.lightText),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.lightTextSecondary),
      labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: AppColors.lightTextSecondary),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: AppColors.lightText),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.75),
      indicatorColor: AppColors.primaryGreen.withOpacity(0.15),
      indicatorShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
              letterSpacing: 0.3);
        }
        return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.lightTextSecondary,
            letterSpacing: 0.3);
      }),
      iconTheme: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryGreen, size: 24);
        }
        return const IconThemeData(
            color: AppColors.lightTextSecondary, size: 22);
      }),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white.withOpacity(0.75),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0F7F0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD4DED4))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.primaryGreen, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(
          color: AppColors.lightTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.w600,
          fontSize: 13),
      prefixIconColor: AppColors.lightTextSecondary,
      suffixIconColor: AppColors.lightTextSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.primaryGreen.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        side: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFEAF3EA),
      selectedColor: AppColors.primaryGreen.withOpacity(0.15),
      labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText),
      secondaryLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextSecondary),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), side: BorderSide.none),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    ),
    dividerTheme: const DividerThemeData(
        color: Color(0xFFE8F0E8), thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.lightText),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      contentTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.lightText),
      subtitleTextStyle:
          const TextStyle(fontSize: 13, color: AppColors.lightTextSecondary),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFD4DED4)))),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
    ),
  );

  static ThemeData dark = _base(Brightness.dark).copyWith(
    scaffoldBackgroundColor: const Color(0xFF0A1A0A),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryGreen,
      onPrimary: Color(0xFF052E16),
      primaryContainer: Color(0xFF065F46),
      onPrimaryContainer: AppColors.primaryGreenLight,
      secondary: AppColors.primaryGreen,
      onSecondary: Color(0xFF052E16),
      surface: Color(0xFF162816),
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: Color(0xFF2D4A2D),
      outlineVariant: Color(0xFF1E3A1E),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFECACA),
      surfaceContainerHighest: Color(0xFF1E331E),
      surfaceContainerLow: Color(0xFF0F1F0F),
      surfaceContainer: Color(0xFF1E331E),
      surfaceContainerHigh: Color(0xFF2D4A2D),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.darkText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: AppColors.darkText),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: const Color(0xFF162816).withOpacity(0.85),
      indicatorColor: AppColors.primaryGreen.withOpacity(0.2),
      indicatorShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
              letterSpacing: 0.3);
        }
        return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.darkTextSecondary,
            letterSpacing: 0.3);
      }),
      iconTheme: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryGreen, size: 24);
        }
        return const IconThemeData(
            color: AppColors.darkTextSecondary, size: 22);
      }),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF162816).withOpacity(0.85),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E331E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2D4A2D))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              const BorderSide(color: AppColors.primaryGreen, width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(
          color: AppColors.darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(
          color: AppColors.primaryGreen,
          fontWeight: FontWeight.w600,
          fontSize: 13),
      prefixIconColor: AppColors.darkTextSecondary,
      suffixIconColor: AppColors.darkTextSecondary,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1E331E),
      selectedColor: AppColors.primaryGreen.withOpacity(0.2),
      labelStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkText),
      secondaryLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), side: BorderSide.none),
    ),
    dividerTheme: const DividerThemeData(
        color: Color(0xFF1E3A1E), thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF162816),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      contentTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
          fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkText),
      subtitleTextStyle:
          const TextStyle(fontSize: 13, color: AppColors.darkTextSecondary),
    ),
  );
}
