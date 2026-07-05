import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionGoalsCard extends StatelessWidget {
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFats;
  final int dailyCaloriesGoal;
  final double dailyProteinGoal;
  final double dailyCarbsGoal;
  final double dailyFatsGoal;
  final int plannedMealCount;
  final bool hasPlannedMeals;
  final VoidCallback? onEditGoals;

  const NutritionGoalsCard({
    super.key,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.dailyCaloriesGoal,
    required this.dailyProteinGoal,
    required this.dailyCarbsGoal,
    required this.dailyFatsGoal,
    required this.plannedMealCount,
    required this.hasPlannedMeals,
    this.onEditGoals,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final calPercent = (totalCalories / dailyCaloriesGoal).clamp(0.0, 1.0);
    final proteinPercent = (totalProtein / dailyProteinGoal).clamp(0.0, 1.0);
    final carbsPercent = (totalCarbs / dailyCarbsGoal).clamp(0.0, 1.0);
    final fatsPercent = (totalFats / dailyFatsGoal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.08),
            theme.colorScheme.primary.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.todaysMeals.toUpperCase(),
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              if (onEditGoals != null)
                GestureDetector(
                  onTap: onEditGoals,
                  child: Icon(Icons.tune_rounded,
                      size: 18, color: theme.colorScheme.primary),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                Text(
                  '$totalCalories',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'kcal / $dailyCaloriesGoal kcal',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: calPercent,
                    minHeight: 8,
                    backgroundColor: AppColors.caloriesColor.withOpacity(0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      calPercent >= 1.0
                          ? AppColors.caloriesColor
                          : AppColors.accentOrange,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$plannedMealCount ${plannedMealCount == 1 ? loc.recipeFound : loc.recipesFound}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (hasPlannedMeals)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  _MacroProgress(
                    label: 'Protein',
                    current: totalProtein,
                    goal: dailyProteinGoal,
                    color: AppColors.proteinColor,
                    unit: 'g',
                    percent: proteinPercent,
                  ),
                  const SizedBox(height: 12),
                  _MacroProgress(
                    label: 'Carbs',
                    current: totalCarbs,
                    goal: dailyCarbsGoal,
                    color: AppColors.carbsColor,
                    unit: 'g',
                    percent: carbsPercent,
                  ),
                  const SizedBox(height: 12),
                  _MacroProgress(
                    label: 'Fats',
                    current: totalFats,
                    goal: dailyFatsGoal,
                    color: AppColors.fatsColor,
                    unit: 'g',
                    percent: fatsPercent,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MacroProgress extends StatelessWidget {
  final String label;
  final double current;
  final double goal;
  final Color color;
  final String unit;
  final double percent;

  const _MacroProgress({
    required this.label,
    required this.current,
    required this.goal,
    required this.color,
    required this.unit,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${current.toStringAsFixed(0)}$unit / ${goal.toStringAsFixed(0)}$unit',
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
