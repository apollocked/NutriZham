import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE11D48);
  static const Color primaryDark = Color(0xFFBE123C);
  static const Color primaryLight = Color(0xFFFDA4AF);
  static const Color primaryContainer = Color(0xFFFFF1F2);
  static const Color primarySoft = Color(0xFFFFE4E6);

  static const List<Color> primaryGradient = [
    Color(0xFFE11D48),
    Color(0xFFFB7185),
  ];

  static const Color accentTeal = Color(0xFF0D9488);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentCyan = Color(0xFF06B6D4);

  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF4F4F5);
  static const Color lightSurfaceHigh = Color(0xFFE4E4E7);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF18181B);
  static const Color lightTextSecondary = Color(0xFF71717A);
  static const Color lightOutline = Color(0xFFD4D4D8);
  static const Color lightOutlineVariant = Color(0xFFE4E4E7);

  static const Color darkBackground = Color(0xFF09090B);
  static const Color darkSurface = Color(0xFF18181B);
  static const Color darkSurfaceContainer = Color(0xFF27272A);
  static const Color darkSurfaceHigh = Color(0xFF3F3F46);
  static const Color darkCard = Color(0xFF18181B);
  static const Color darkText = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFA1A1AA);
  static const Color darkOutline = Color(0xFF3F3F46);
  static const Color darkOutlineVariant = Color(0xFF27272A);

  static const Color caloriesColor = Color(0xFFEF4444);
  static const Color proteinColor = Color(0xFF0D9488);
  static const Color carbsColor = Color(0xFFF59E0B);
  static const Color fatsColor = Color(0xFF8B5CF6);

  static const Color success = Color(0xFF0D9488);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static const Color starActive = Color(0xFFF59E0B);
  static const Color starInactive = Color(0xFFD4D4D8);

  static const Color breakfastColor = Color(0xFFF59E0B);
  static const Color lunchColor = Color(0xFFE11D48);
  static const Color dinnerColor = Color(0xFF0D9488);
  static const Color snackColor = Color(0xFF8B5CF6);
  static const Color bulkingColor = Color(0xFFEF4444);
  static const Color cuttingColor = Color(0xFF06B6D4);

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return breakfastColor;
      case 'lunch':
        return lunchColor;
      case 'dinner':
        return dinnerColor;
      case 'snack':
        return snackColor;
      case 'bulking':
        return bulkingColor;
      case 'cutting':
        return cuttingColor;
      default:
        return primary;
    }
  }

  static Color getCategoryBackground(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return const Color(0xFFFEF3C7);
      case 'lunch':
        return const Color(0xFFFFE4E6);
      case 'dinner':
        return const Color(0xFFCCFBF1);
      case 'snack':
        return const Color(0xFFEDE9FE);
      case 'bulking':
        return const Color(0xFFFEE2E2);
      case 'cutting':
        return const Color(0xFFCFFAFE);
      default:
        return const Color(0xFFF4F4F5);
    }
  }
}
