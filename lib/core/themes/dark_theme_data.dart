import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/core/themes/app_text_theme.dart';

ThemeData buildDarkTheme(ThemeData base) {
  return base.copyWith(
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
    textTheme: buildTextTheme(AppColors.darkText, AppColors.darkTextSecondary),
    appBarTheme: const AppBarTheme(
      elevation: 0, scrolledUnderElevation: 0.5, centerTitle: false,
      backgroundColor: Colors.transparent, foregroundColor: AppColors.darkText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'Rudaw', inherit: false, fontSize: 20, fontWeight: FontWeight.w700,
        letterSpacing: -0.25, color: AppColors.darkText, textBaseline: TextBaseline.alphabetic,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.darkSurface.withOpacity(0.85),
      indicatorColor: AppColors.primary.withOpacity(0.2),
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent, height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
        fontFamily: 'Rudaw', inherit: false, fontSize: 11,
        fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
        color: s.contains(WidgetState.selected) ? AppColors.primary : AppColors.darkTextSecondary,
        letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic,
      )),
      iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
        color: s.contains(WidgetState.selected) ? AppColors.primary : AppColors.darkTextSecondary,
        size: s.contains(WidgetState.selected) ? 24 : 22,
      )),
    ),
    cardTheme: CardThemeData(
      elevation: 0, color: AppColors.darkCard, surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias, shadowColor: Colors.black.withOpacity(0.3),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: AppColors.darkSurfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.darkOutline)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, color: AppColors.darkTextSecondary, fontSize: 14, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic),
      floatingLabelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13, textBaseline: TextBaseline.alphabetic),
      prefixIconColor: AppColors.darkTextSecondary, suffixIconColor: AppColors.darkTextSecondary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary, foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurfaceContainer,
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.darkText,
      labelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkText, textBaseline: TextBaseline.alphabetic),
      secondaryLabelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkTextSecondary, textBaseline: TextBaseline.alphabetic),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide.none),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.darkOutline, thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText, textBaseline: TextBaseline.alphabetic),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
      contentTextStyle: TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 14, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      showDragHandle: true, surfaceTintColor: Colors.transparent,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkText, textBaseline: TextBaseline.alphabetic),
      subtitleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, color: AppColors.darkTextSecondary, textBaseline: TextBaseline.alphabetic),
    ),
  );
}
