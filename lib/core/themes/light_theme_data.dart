import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/core/themes/app_text_theme.dart';

ThemeData buildLightTheme(ThemeData base) {
  return base.copyWith(
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
    textTheme: buildTextTheme(AppColors.lightText, AppColors.lightTextSecondary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.lightText,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'Rudaw', inherit: false, fontSize: 20, fontWeight: FontWeight.w700,
        letterSpacing: -0.25, color: AppColors.lightText, textBaseline: TextBaseline.alphabetic,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.lightSurface.withValues(alpha: 0.75),
      indicatorColor: AppColors.primary.withValues(alpha: 0.12),
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      surfaceTintColor: Colors.transparent,
      height: 68,
      labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
        fontFamily: 'Rudaw', inherit: false, fontSize: 11,
        fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
        color: s.contains(WidgetState.selected) ? AppColors.primary : AppColors.lightTextSecondary,
        letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic,
      )),
      iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
        color: s.contains(WidgetState.selected) ? AppColors.primary : AppColors.lightTextSecondary,
        size: s.contains(WidgetState.selected) ? 24 : 22,
      )),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.lightCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black.withValues(alpha: 0.04),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.lightOutline)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.error, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.error, width: 1.5)),
      labelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, color: AppColors.lightTextSecondary, fontSize: 14, fontWeight: FontWeight.w500, textBaseline: TextBaseline.alphabetic),
      floatingLabelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13, textBaseline: TextBaseline.alphabetic),
      prefixIconColor: AppColors.lightTextSecondary,
      suffixIconColor: AppColors.lightTextSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, foregroundColor: Colors.white,
        elevation: 0, shadowColor: AppColors.primary.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary, foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w600, textBaseline: TextBaseline.alphabetic),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 14, fontWeight: FontWeight.w600, textBaseline: TextBaseline.alphabetic),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.lightSurfaceContainer,
      selectedColor: AppColors.primary.withValues(alpha: 0.12),
      checkmarkColor: AppColors.primary,
      labelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.lightText, textBaseline: TextBaseline.alphabetic),
      secondaryLabelStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.lightTextSecondary, textBaseline: TextBaseline.alphabetic),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide.none),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.lightOutline, thickness: 1, space: 1),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.lightText, textBaseline: TextBaseline.alphabetic),
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
      titleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.lightText, textBaseline: TextBaseline.alphabetic),
      subtitleTextStyle: const TextStyle(fontFamily: 'Rudaw', inherit: false, fontSize: 13, color: AppColors.lightTextSecondary, textBaseline: TextBaseline.alphabetic),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.lightOutline),
        )),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
    ),
  );
}
