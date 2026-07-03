import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionSummaryCard extends StatelessWidget {
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFats;
  final int plannedMealCount;
  final bool hasPlannedMeals;

  const NutritionSummaryCard({
    super.key,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.plannedMealCount,
    required this.hasPlannedMeals,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withOpacity(0.08), theme.colorScheme.primary.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
      ),
      child: Column(children: [
        Text(loc.todaysMeals.toUpperCase(), style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.5)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
          ),
          child: Column(children: [
            Text('$totalCalories', style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 44, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text('kcal', style: TextStyle(color: theme.colorScheme.primary, fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('$plannedMealCount ${plannedMealCount == 1 ? loc.recipeFound : loc.recipesFound}', style: theme.textTheme.bodySmall),
          ]),
        ),
        const SizedBox(height: 16),
        if (hasPlannedMeals)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MacroPill(label: 'Protein', value: '${totalProtein.toStringAsFixed(0)}g', color: AppColors.proteinColor),
                _MacroPill(label: 'Carbs', value: '${totalCarbs.toStringAsFixed(0)}g', color: AppColors.carbsColor),
                _MacroPill(label: 'Fats', value: '${totalFats.toStringAsFixed(0)}g', color: AppColors.fatsColor),
              ],
            ),
          ),
      ]),
    );
  }
}

class _MacroPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MacroPill({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text(label, style: theme.textTheme.labelMedium),
    ]);
  }
}
