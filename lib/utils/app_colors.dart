import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryGreenDark = Color(0xFF388E3C);
  static const Color primaryGreenLight = Color(0xFF81C784);
  
  // Accent Colors
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color accentPurple = Color(0xFF9C27B0);
  static const Color accentRed = Color(0xFFE53935);
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightDivider = Color(0xFFE0E0E0);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkDivider = Color(0xFF404040);
  
  // Nutrition Colors
  static const Color caloriesColor = Color(0xFFE53935);
  static const Color proteinColor = Color(0xFF2196F3);
  static const Color carbsColor = Color(0xFFFF9800);
  static const Color fatsColor = Color(0xFF9C27B0);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Rating Colors
  static const Color starActive = Color(0xFFFFB300);
  static const Color starInactive = Color(0xFFE0E0E0);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF4CAF50),
    Color(0xFF81C784),
  ];
  
  static const List<Color> darkGradient = [
    Color(0xFF1E1E1E),
    Color(0xFF2C2C2C),
  ];
  
  // Category Colors
  static const Color breakfastColor = Color(0xFFFF9800);
  static const Color lunchColor = Color(0xFF4CAF50);
  static const Color dinnerColor = Color(0xFF2196F3);
  static const Color snackColor = Color(0xFF9C27B0);
  static const Color bulkingColor = Color(0xFFE53935);
  static const Color cuttingColor = Color(0xFF00BCD4);
  
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
}
