import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionInfoCard extends StatelessWidget {
  final NutritionalInfo nutrition;

  const NutritionInfoCard({
    super.key,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                loc.nutritionalInfo,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutrientColumn(
                value: '${nutrition.calories}',
                label: loc.calories,
                color: AppColors.caloriesColor,
                icon: Icons.local_fire_department_rounded,
              ),
              _NutrientColumn(
                value: '${nutrition.protein}g',
                label: loc.protein,
                color: AppColors.proteinColor,
                icon: Icons.fitness_center_rounded,
              ),
              _NutrientColumn(
                value: '${nutrition.carbs}g',
                label: loc.carbs,
                color: AppColors.carbsColor,
                icon: Icons.bakery_dining_rounded,
              ),
              _NutrientColumn(
                value: '${nutrition.fats}g',
                label: loc.fats,
                color: AppColors.fatsColor,
                icon: Icons.water_drop_rounded,
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

  const _NutrientColumn({
    required this.value,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class NutritionSummaryBar extends StatelessWidget {
  final NutritionalInfo nutrition;

  const NutritionSummaryBar({
    super.key,
    required this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniNutrient('${nutrition.calories}', 'kcal', AppColors.caloriesColor, theme),
          Container(
            height: 30,
            width: 1,
            color: theme.colorScheme.outline,
          ),
          _buildMiniNutrient('${nutrition.protein}g', 'P', AppColors.proteinColor, theme),
          Container(
            height: 30,
            width: 1,
            color: theme.colorScheme.outline,
          ),
          _buildMiniNutrient('${nutrition.carbs}g', 'C', AppColors.carbsColor, theme),
          Container(
            height: 30,
            width: 1,
            color: theme.colorScheme.outline,
          ),
          _buildMiniNutrient('${nutrition.fats}g', 'F', AppColors.fatsColor, theme),
        ],
      ),
    );
  }

  Widget _buildMiniNutrient(String value, String label, Color color, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
