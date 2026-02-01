import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_localizations.dart';

class NutritionInfoCard extends StatelessWidget {
  final NutritionalInfo nutrition;
  final bool isDarkMode;
  final String languageCode;

  const NutritionInfoCard({
    super.key,
    required this.nutrition,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(languageCode);
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Card(
      color: isDarkMode ? AppColors.darkCard : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.nutritionalInfo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NutrientColumn(
                  value: '${nutrition.calories}',
                  label: loc.calories,
                  color: AppColors.caloriesColor,
                  icon: Icons.local_fire_department,
                  isDarkMode: isDarkMode,
                ),
                _NutrientColumn(
                  value: '${nutrition.protein}g',
                  label: loc.protein,
                  color: AppColors.proteinColor,
                  icon: Icons.fitness_center,
                  isDarkMode: isDarkMode,
                ),
                _NutrientColumn(
                  value: '${nutrition.carbs}g',
                  label: loc.carbs,
                  color: AppColors.carbsColor,
                  icon: Icons.bakery_dining,
                  isDarkMode: isDarkMode,
                ),
                _NutrientColumn(
                  value: '${nutrition.fats}g',
                  label: loc.fats,
                  color: AppColors.fatsColor,
                  icon: Icons.water_drop,
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NutrientColumn extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;
  final bool isDarkMode;

  const _NutrientColumn({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}

class NutritionSummaryBar extends StatelessWidget {
  final NutritionalInfo nutrition;
  final bool isDarkMode;
  final String languageCode;

  const NutritionSummaryBar({
    super.key,
    required this.nutrition,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniNutrient(
            '${nutrition.calories}',
            'kcal',
            AppColors.caloriesColor,
          ),
          Container(
            height: 30,
            width: 1,
            color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          _buildMiniNutrient(
            '${nutrition.protein}g',
            'P',
            AppColors.proteinColor,
          ),
          Container(
            height: 30,
            width: 1,
            color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          _buildMiniNutrient(
            '${nutrition.carbs}g',
            'C',
            AppColors.carbsColor,
          ),
          Container(
            height: 30,
            width: 1,
            color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          _buildMiniNutrient(
            '${nutrition.fats}g',
            'F',
            AppColors.fatsColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniNutrient(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}
