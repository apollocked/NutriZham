import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Updated minimalist palette
  static const Color primaryGreen = Color(0xFF10B981); // Emerald green
  static const Color primaryGreenDark = Color(0xFF059669); // Dark green
  static const Color primaryGreenLight = Color(0xFFD1FAE5); // Light green

  // Accent Colors - Muted minimalist versions
  static const Color accentOrange = Color(0xFFF59E0B); // Amber
  static const Color accentBlue = Color(0xFF3B82F6); // Blue
  static const Color accentPurple = Color(0xFF8B5CF6); // Purple
  static const Color accentRed = Color(0xFFEF4444); // Red

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF); // Pure white
  static const Color lightSurface = Color(0xFFF9FAFB); // Very light gray
  static const Color lightCard = Color(0xFFFFFFFF); // White
  static const Color lightText = Color(0xFF111827); // Almost black
  static const Color lightTextSecondary = Color(0xFF6B7280); // Medium gray
  static const Color lightDivider = Color(0xFFE5E7EB); // Light gray

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111827); // Almost black
  static const Color darkSurface = Color(0xFF1F2937); // Dark gray
  static const Color darkCard = Color(0xFF1F2937); // Dark gray
  static const Color darkText = Color(0xFFF9FAFB); // Almost white
  static const Color darkTextSecondary = Color(0xFF9CA3AF); // Light gray
  static const Color darkDivider = Color(0xFF374151); // Medium-dark gray

  // Nutrition Colors
  static const Color caloriesColor = Color(0xFFEF4444); // Red
  static const Color proteinColor = Color(0xFF3B82F6); // Blue
  static const Color carbsColor = Color(0xFFF59E0B); // Amber
  static const Color fatsColor = Color(0xFF8B5CF6); // Purple

  // Status Colors
  static const Color success = Color(0xFF10B981); // Emerald green
  static const Color error = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color info = Color(0xFF3B82F6); // Blue

  // Rating Colors
  static const Color starActive = Color(0xFFF59E0B); // Amber
  static const Color starInactive = Color(0xFFD1D5DB); // Light gray

  // Gradient Colors - Keeping but lighter
  static const List<Color> primaryGradient = [
    Color(0xFF10B981),
    Color(0xFF34D399),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF111827),
    Color(0xFF374151),
  ];

  // Category Colors
  static const Color breakfastColor = Color(0xFFF59E0B); // Amber
  static const Color lunchColor = Color(0xFF10B981); // Emerald
  static const Color dinnerColor = Color(0xFF3B82F6); // Blue
  static const Color snackColor = Color(0xFF8B5CF6); // Purple
  static const Color bulkingColor = Color(0xFFEF4444); // Red
  static const Color cuttingColor = Color(0xFF06B6D4); // Cyan

  // Helper method to get category color
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

  // New helper for subtle background colors (can be used for minimalist icons)
  static Color getCategoryBackground(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return const Color(0xFFFEF3C7); // Amber 50
      case 'lunch':
        return const Color(0xFFD1FAE5); // Emerald 100
      case 'dinner':
        return const Color(0xFFDBEAFE); // Blue 100
      case 'snack':
        return const Color(0xFFE0E7FF); // Indigo 100
      case 'bulking':
        return const Color(0xFFFEE2E2); // Red 50
      case 'cutting':
        return const Color(0xFFCFFAFE); // Cyan 50
      default:
        return const Color(0xFFF3F4F6); // Neutral 100
    }
  }
}
