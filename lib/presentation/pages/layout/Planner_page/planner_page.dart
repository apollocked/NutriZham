import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/meal_planner_provider.dart';
import 'package:nutrizham/presentation/providers/recipe_provider.dart';

import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/nutrition_summary_card.dart';
import 'package:nutrizham/presentation/widgets/section_header.dart';
import 'package:nutrizham/presentation/widgets/planned_meals_list.dart';
import 'package:nutrizham/presentation/widgets/recommended_meals_list.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Recipe> _allRecipes = [];
  late final MealPlannerProvider _plannerProvider;

  @override
  void initState() {
    super.initState();
    _plannerProvider = context.read<MealPlannerProvider>();
    _plannerProvider.loadPlannedMeals();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = context.read<RecipeProvider>();
    final recipesList = await recipes.getAll();
    if (mounted) setState(() => _allRecipes = recipesList);
  }

  Future<void> _toggleMealInPlan(String recipeId) async {
    await _plannerProvider.toggleMealInPlan(recipeId);
    if (mounted) {
      final isInPlan = _plannerProvider.isInPlan(recipeId);
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isInPlan ? loc.addToPlan : loc.removeFromPlan),
          duration: const Duration(seconds: 1),
          backgroundColor: isInPlan
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  int get _totalCalories => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0, (total, r) => total + r.nutrition.calories);

  double get _totalProtein => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (total, r) => total + r.nutrition.protein);
  double get _totalCarbs => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (total, r) => total + r.nutrition.carbs);
  double get _totalFats => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (total, r) => total + r.nutrition.fats);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final planner = context.watch<MealPlannerProvider>();

    final plannedMeals =
        _allRecipes.where((r) => planner.isInPlan(r.id)).toList();
    final recommendedMeals =
        _allRecipes.where((r) => !planner.isInPlan(r.id)).take(25).toList();

    return Scaffold(
      appBar: CustomAppBar(title: loc.mealPlanner),
      body: Column(children: [
        NutritionSummaryCard(
          totalCalories: _totalCalories,
          totalProtein: _totalProtein,
          totalCarbs: _totalCarbs,
          totalFats: _totalFats,
          plannedMealCount: plannedMeals.length,
          hasPlannedMeals: plannedMeals.isNotEmpty,
        ),
        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SectionHeader(title: loc.dailyPlan),
              PlannedMealsList(
                plannedMeals: plannedMeals,
                onRemoveMeal: _toggleMealInPlan,
              ),
              const SizedBox(height: 24),
              SectionHeader(title: loc.recommendedMeals),
              RecommendedMealsList(
                recommendedMeals: recommendedMeals,
                onAddMeal: _toggleMealInPlan,
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ),
      ]),
    );
  }
}
