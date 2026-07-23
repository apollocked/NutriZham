import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/profile/weekly_stat_item.dart';
import 'package:nutrizham/presentation/widgets/profile/weekly_slot_chip.dart';

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
    final stats = _computeStats();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        onTap: () => context.push('/planner'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(theme, loc),
              const SizedBox(height: 20),
              Row(children: [
                WeeklyStatItem(value: '${stats.totalMeals}', label: loc.meals, color: AppColors.caloriesColor),
                WeeklyStatItem(value: '${stats.daysCovered}/7', label: loc.days, color: theme.colorScheme.primary),
                WeeklyStatItem(value: '${stats.recipeCount}', label: loc.recipes, color: AppColors.accentTeal),
              ]),
              if (stats.totalMeals > 0) ...[
                const SizedBox(height: 16),
                Row(children: [
                  WeeklySlotChip(count: stats.breakfast, label: loc.breakfast, color: AppColors.breakfastColor),
                  const SizedBox(width: 6),
                  WeeklySlotChip(count: stats.lunch, label: loc.lunch, color: AppColors.lunchColor),
                  const SizedBox(width: 6),
                  WeeklySlotChip(count: stats.dinner, label: loc.dinner, color: AppColors.dinnerColor),
                  const SizedBox(width: 6),
                  WeeklySlotChip(count: stats.snack, label: loc.snack, color: AppColors.snackColor),
                ]),
                const SizedBox(height: 14),
                Row(children: [
                  const Icon(Icons.local_fire_department_rounded, size: 14, color: AppColors.caloriesColor),
                  const SizedBox(width: 4),
                  Text('${stats.totalCalories}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.caloriesColor)),
                  const SizedBox(width: 4),
                  Text(loc.kcal, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant)),
                  const Spacer(),
                  Text('${loc.tapToBrowse} →', style: TextStyle(fontSize: 12, color: theme.colorScheme.primary, fontWeight: FontWeight.w500)),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(ThemeData theme, AppLocalizations loc) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.date_range_rounded, size: 18, color: theme.colorScheme.primary),
      ),
      const SizedBox(width: 12),
      Text(loc.weeklyPlan, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      const Spacer(),
      Icon(Icons.chevron_right_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)),
    ]);
  }

  _WeeklyStats _computeStats() {
    final daysCovered = <int>{};
    int breakfast = 0, lunch = 0, dinner = 0, snack = 0;
    final recipeIds = <String>{};
    int totalCalories = 0, totalMeals = 0;

    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      final entries = mealPlans[key];
      if (entries == null || entries.isEmpty) continue;
      daysCovered.add(i);
      for (final e in entries) {
        totalMeals++;
        recipeIds.add(e.recipeId);
        if (e.slot == 'breakfast') breakfast++;
        if (e.slot == 'lunch') lunch++;
        if (e.slot == 'dinner') dinner++;
        if (e.slot == 'snack') snack++;
        final recipe = _findRecipe(e.recipeId);
        if (recipe != null) totalCalories += recipe.nutrition.calories;
      }
    }

    return _WeeklyStats(daysCovered: daysCovered.length, totalMeals: totalMeals,
        recipeCount: recipeIds.length, totalCalories: totalCalories,
        breakfast: breakfast, lunch: lunch, dinner: dinner, snack: snack);
  }

  Recipe? _findRecipe(String id) {
    try { return allRecipes.firstWhere((r) => r.id == id); } catch (_) { return null; }
  }
}

class _WeeklyStats {
  final int daysCovered, totalMeals, recipeCount, totalCalories;
  final int breakfast, lunch, dinner, snack;
  const _WeeklyStats({required this.daysCovered, required this.totalMeals,
    required this.recipeCount, required this.totalCalories,
    required this.breakfast, required this.lunch, required this.dinner, required this.snack});
}
