import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF059669);
  static const Color primaryGreenDark = Color(0xFF047857);
  static const Color primaryGreenLight = Color(0xFFA7F3D0);
  static const Color primaryGreenSurface = Color(0xFFECFDF5);

  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentCyan = Color(0xFF06B6D4);

  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightDivider = Color(0xFFE2E8F0);

  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkDivider = Color(0xFF334155);

  static const Color caloriesColor = Color(0xFFEF4444);
  static const Color proteinColor = Color(0xFF3B82F6);
  static const Color carbsColor = Color(0xFFF59E0B);
  static const Color fatsColor = Color(0xFF8B5CF6);

  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static const Color starActive = Color(0xFFF59E0B);
  static const Color starInactive = Color(0xFFCBD5E1);

  static const List<Color> primaryGradient = [
    Color(0xFF059669),
    Color(0xFF10B981),
    Color(0xFF34D399),
  ];

  static const List<Color> primaryGradientDark = [
    Color(0xFF047857),
    Color(0xFF059669),
  ];

  static const Color breakfastColor = Color(0xFFF59E0B);
  static const Color lunchColor = Color(0xFF059669);
  static const Color dinnerColor = Color(0xFF3B82F6);
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
        return primaryGreen;
    }
  }

  static Color getCategoryBackground(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return const Color(0xFFFEF3C7);
      case 'lunch':
        return const Color(0xFFD1FAE5);
      case 'dinner':
        return const Color(0xFFDBEAFE);
      case 'snack':
        return const Color(0xFFEDE9FE);
      case 'bulking':
        return const Color(0xFFFEE2E2);
      case 'cutting':
        return const Color(0xFFCFFAFE);
      default:
        return const Color(0xFFF1F5F9);
    }
  }
}
