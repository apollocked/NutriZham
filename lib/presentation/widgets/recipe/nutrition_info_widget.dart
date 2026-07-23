import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionInfoCard extends StatelessWidget {
  final NutritionalInfo nutrition;

  const NutritionInfoCard({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(loc.nutritionalInfo, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutrientPill(value: '${nutrition.calories}', label: loc.calories, color: AppColors.caloriesColor, icon: Icons.local_fire_department_rounded),
              _NutrientPill(value: '${nutrition.protein}g', label: loc.protein, color: AppColors.proteinColor, icon: Icons.fitness_center_rounded),
              _NutrientPill(value: '${nutrition.carbs}g', label: loc.carbs, color: AppColors.carbsColor, icon: Icons.bakery_dining_rounded),
              _NutrientPill(value: '${nutrition.fats}g', label: loc.fats, color: AppColors.fatsColor, icon: Icons.water_drop_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _NutrientPill extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _NutrientPill({
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 2),
        Text(label, style: theme.textTheme.labelMedium),
      ],
    );
  }
}
