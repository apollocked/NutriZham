import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileWeeklySummary extends StatelessWidget {
  final Map<String, List<MealPlanEntry>> mealPlans;
  final DateTime weekStart;
  final List<Recipe> allRecipes;

  const ProfileWeeklySummary({
    super.key,
    required this.mealPlans,
    required this.weekStart,
    required this.allRecipes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final daysCovered = <int>{};
    final slotCounts = {'breakfast': 0, 'lunch': 0, 'dinner': 0, 'snack': 0};
    final recipeIds = <String>{};
    int totalCalories = 0;
    int totalMeals = 0;

    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final key =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      final entries = mealPlans[key];
      if (entries != null && entries.isNotEmpty) {
        daysCovered.add(i);
        for (final e in entries) {
          totalMeals++;
          recipeIds.add(e.recipeId);
          if (slotCounts.containsKey(e.slot)) {
            slotCounts[e.slot] = slotCounts[e.slot]! + 1;
          }
          final recipe = _findRecipe(e.recipeId);
          if (recipe != null) totalCalories += recipe.nutrition.calories;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        onTap: () => context.push('/planner'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.date_range_rounded,
                        size: 18, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Text(loc.weeklyPlan,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Icon(Icons.chevron_right_rounded,
                      size: 20,
                      color:
                          theme.colorScheme.onSurfaceVariant.withOpacity(0.4)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatItem(
                      value: '$totalMeals',
                      label: loc.meals,
                      color: AppColors.caloriesColor),
                  _StatItem(
                      value: '${daysCovered.length}/7',
                      label: loc.days,
                      color: theme.colorScheme.primary),
                  _StatItem(
                      value: '${recipeIds.length}',
                      label: loc.recipes,
                      color: AppColors.accentTeal),
                ],
              ),
              if (totalMeals > 0) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    _SlotChip(
                        count: slotCounts['breakfast']!,
                        label: loc.breakfast,
                        color: AppColors.breakfastColor),
                    const SizedBox(width: 6),
                    _SlotChip(
                        count: slotCounts['lunch']!,
                        label: loc.lunch,
                        color: AppColors.lunchColor),
                    const SizedBox(width: 6),
                    _SlotChip(
                        count: slotCounts['dinner']!,
                        label: loc.dinner,
                        color: AppColors.dinnerColor),
                    const SizedBox(width: 6),
                    _SlotChip(
                        count: slotCounts['snack']!,
                        label: loc.snack,
                        color: AppColors.snackColor),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department_rounded,
                        size: 14, color: AppColors.caloriesColor),
                    const SizedBox(width: 4),
                    Text('$totalCalories',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.caloriesColor)),
                    const SizedBox(width: 4),
                    Text(loc.kcal,
                        style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurfaceVariant)),
                    const Spacer(),
                    Text('${loc.tapToBrowse} →',
                        style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Recipe? _findRecipe(String id) {
    try {
      return allRecipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final int count;
  final String label;
  final Color color;

  const _SlotChip(
      {required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text('$count',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700, color: color)),
            Text(label, style: TextStyle(fontSize: 9, color: color)),
          ],
        ),
      ),
    );
  }
}
