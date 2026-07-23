import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_macro_bar.dart';

class ProfileMealPlanSection extends StatelessWidget {
  final Map<String, List<MealPlanEntry>> mealPlans;
  final List<Recipe> allRecipes;
  final String dateKey;
  final int dailyCaloriesGoal;
  final double dailyProteinGoal;
  final double dailyCarbsGoal;
  final double dailyFatsGoal;

  const ProfileMealPlanSection({
    super.key,
    required this.mealPlans,
    required this.allRecipes,
    required this.dateKey,
    this.dailyCaloriesGoal = 2000,
    this.dailyProteinGoal = 150,
    this.dailyCarbsGoal = 250,
    this.dailyFatsGoal = 65,
  });

  Recipe? _findRecipe(String id) {
    try {
      return allRecipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  (int calories, double protein, double carbs, double fats) get _totals {
    final entries = mealPlans[dateKey] ?? [];
    int cals = 0;
    double p = 0, c = 0, f = 0;
    for (final e in entries) {
      final recipe = _findRecipe(e.recipeId);
      if (recipe != null) {
        cals += recipe.nutrition.calories;
        p += recipe.nutrition.protein;
        c += recipe.nutrition.carbs;
        f += recipe.nutrition.fats;
      }
    }
    return (cals, p, c, f);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final (totalCal, totalProtein, totalCarbs, totalFats) = _totals;
    final calRatio = dailyCaloriesGoal > 0
        ? (totalCal / dailyCaloriesGoal).clamp(0.0, 1.0)
        : 0.0;
    final proteinRatio = dailyProteinGoal > 0
        ? (totalProtein / dailyProteinGoal).clamp(0.0, 1.0)
        : 0.0;
    final carbsRatio = dailyCarbsGoal > 0
        ? (totalCarbs / dailyCarbsGoal).clamp(0.0, 1.0)
        : 0.0;
    final fatsRatio =
        dailyFatsGoal > 0 ? (totalFats / dailyFatsGoal).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: GestureDetector(
        onTap: () => context.push('/planner'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.08),
                theme.colorScheme.primary.withValues(alpha: 0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4, height: 22,
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
                  Text(loc.mealPlanner,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$totalCal',
                          style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.caloriesColor)),
                      Text(loc.calories,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$dailyCaloriesGoal',
                          style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5))),
                      Text(loc.caloriesGoal,
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: calRatio,
                  backgroundColor: AppColors.caloriesColor.withValues(alpha: 0.08),
                  color: AppColors.caloriesColor,
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ProfileMacroBar(label: loc.protein, value: totalProtein, goal: dailyProteinGoal, ratio: proteinRatio, color: AppColors.proteinColor),
                  const SizedBox(width: 8),
                  ProfileMacroBar(label: loc.carbs, value: totalCarbs, goal: dailyCarbsGoal, ratio: carbsRatio, color: AppColors.carbsColor),
                  const SizedBox(width: 8),
                  ProfileMacroBar(label: loc.fats, value: totalFats, goal: dailyFatsGoal, ratio: fatsRatio, color: AppColors.fatsColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
