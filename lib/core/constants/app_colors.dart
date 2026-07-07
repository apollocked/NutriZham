import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF28C6B);
  static const Color primaryDark = Color(0xFFCC6D4F);
  static const Color primaryLight = Color(0xFFFFD8CA);
  static const Color primaryContainer = Color(0xFFFFF5F0);
  static const Color primarySoft = Color(0xFFFFEFE8);

  static const List<Color> primaryGradient = [
    Color(0xFFF28C6B),
    Color(0xFF4FAE83),
  ];

  static const Color accentTeal = Color(0xFF2F6D68);
  static const Color accentOrange = Color(0xFFF0A24B);
  static const Color accentBlue = Color(0xFF4A8FBF);
  static const Color accentViolet = Color(0xFF7E6BBE);
  static const Color accentRed = Color(0xFFE95D4A);
  static const Color accentCyan = Color(0xFF3DA9A0);

  static const Color lightBackground = Color(0xFFFCFAF8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF6F1EA);
  static const Color lightSurfaceHigh = Color(0xFFEEE6DD);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E2726);
  static const Color lightTextSecondary = Color(0xFF6F7874);
  static const Color lightOutline = Color(0xFFE2DCD5);
  static const Color lightOutlineVariant = Color(0xFFF0E8E0);

  static const Color darkBackground = Color(0xFF171B1A);
  static const Color darkSurface = Color(0xFF202625);
  static const Color darkSurfaceContainer = Color(0xFF2A3330);
  static const Color darkSurfaceHigh = Color(0xFF33403D);
  static const Color darkCard = Color(0xFF202625);
  static const Color darkText = Color(0xFFF5F2EC);
  static const Color darkTextSecondary = Color(0xFF9CA8A3);
  static const Color darkOutline = Color(0xFF3A4541);
  static const Color darkOutlineVariant = Color(0xFF2A3330);

  static const Color caloriesColor = Color(0xFFE95D4A);
  static const Color proteinColor = Color(0xFF2F6D68);
  static const Color carbsColor = Color(0xFFF0A24B);
  static const Color fatsColor = Color(0xFF7E6BBE);

  static const Color success = Color(0xFF2F6D68);
  static const Color error = Color(0xFFE95D4A);
  static const Color warning = Color(0xFFF0A24B);
  static const Color info = Color(0xFF4A8FBF);

  static const Color starActive = Color(0xFFF0A24B);
  static const Color starInactive = Color(0xFFE2DCD5);

  static const Color breakfastColor = Color(0xFFF0A24B);
  static const Color lunchColor = Color(0xFFF28C6B);
  static const Color dinnerColor = Color(0xFF2F6D68);
  static const Color snackColor = Color(0xFF7E6BBE);
  static const Color bulkingColor = Color(0xFFE95D4A);
  static const Color cuttingColor = Color(0xFF3DA9A0);

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
        return const Color(0xFFFFF1D8);
      case 'lunch':
        return const Color(0xFFFFF0E8);
      case 'dinner':
        return const Color(0xFFE8F5F1);
      case 'snack':
        return const Color(0xFFF1ECFF);
      case 'bulking':
        return const Color(0xFFFFE8E3);
      case 'cutting':
        return const Color(0xFFE7F7F3);
      default:
        return const Color(0xFFF6F1EA);
    }
  }
}
