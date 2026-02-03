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

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.nutritionalInfo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
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
                icon: Icons.local_fire_department_outlined,
                isDarkMode: isDarkMode,
              ),
              _NutrientColumn(
                value: '${nutrition.protein}g',
                label: loc.protein,
                color: AppColors.proteinColor,
                icon: Icons.fitness_center_outlined,
                isDarkMode: isDarkMode,
              ),
              _NutrientColumn(
                value: '${nutrition.carbs}g',
                label: loc.carbs,
                color: AppColors.carbsColor,
                icon: Icons.bakery_dining_outlined,
                isDarkMode: isDarkMode,
              ),
              _NutrientColumn(
                value: '${nutrition.fats}g',
                label: loc.fats,
                color: AppColors.fatsColor,
                icon: Icons.water_drop_outlined,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ],
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
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
            isDarkMode,
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
            isDarkMode,
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
            isDarkMode,
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
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniNutrient(
      String value, String label, Color color, bool isDarkMode) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
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
