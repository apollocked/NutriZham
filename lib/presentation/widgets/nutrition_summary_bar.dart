import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';

class NutritionSummaryBar extends StatelessWidget {
  final NutritionalInfo nutrition;

  const NutritionSummaryBar({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniNutrient(
              '${nutrition.calories}', 'kcal', AppColors.caloriesColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withOpacity(0.3)),
          _buildMiniNutrient(
              '${nutrition.protein}g', 'P', AppColors.proteinColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withOpacity(0.3)),
          _buildMiniNutrient('${nutrition.carbs}g', 'C', AppColors.carbsColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withOpacity(0.3)),
          _buildMiniNutrient('${nutrition.fats}g', 'F', AppColors.fatsColor),
        ],
      ),
    );
  }

  Widget _buildMiniNutrient(String value, String label, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 14, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
