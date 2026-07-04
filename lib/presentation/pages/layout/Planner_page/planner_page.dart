import 'package:flutter/material.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/core/cache/recipe_cache_service.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/recipe/nutrition_summary_card.dart';
import 'package:nutrizham/presentation/widgets/common/section_header.dart';
import 'package:nutrizham/presentation/widgets/planner/planned_meals_list.dart';
import 'package:nutrizham/presentation/widgets/home/recommended_meals_list.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Recipe> _allRecipes = [];
  bool _isLoading = true;
  late final MealPlannerCubit _plannerProvider;
  late final RecipeCacheService _recipeCache;

  @override
  void initState() {
    super.initState();
    _recipeCache = RecipeCacheService(CacheService());
    _plannerProvider = context.read<MealPlannerCubit>();
    _plannerProvider.loadPlannedMeals();
    _loadCachedRecipes();
    _loadRecipes();
  }

  Future<void> _loadCachedRecipes() async {
    final cached = await _recipeCache.getCachedPlannedRecipes();
    if (cached.isNotEmpty && mounted) {
      setState(() {
        _allRecipes = cached;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadRecipes() async {
    final recipes = context.read<RecipeCubit>();
    final recipesList = await recipes.getAll();
    final plannedIds = _plannerProvider.ids;
    final planned = recipesList.where((r) => plannedIds.contains(r.id)).toList();
    _recipeCache.cachePlannedRecipes(planned);
    if (mounted) setState(() { _allRecipes = recipesList; _isLoading = false; });
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
          backgroundColor: isInPlan ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  int get _totalCalories => _allRecipes.where((r) => _plannerProvider.isInPlan(r.id)).fold(0, (total, r) => total + r.nutrition.calories);
  double get _totalProtein => _allRecipes.where((r) => _plannerProvider.isInPlan(r.id)).fold(0.0, (total, r) => total + r.nutrition.protein);
  double get _totalCarbs => _allRecipes.where((r) => _plannerProvider.isInPlan(r.id)).fold(0.0, (total, r) => total + r.nutrition.carbs);
  double get _totalFats => _allRecipes.where((r) => _plannerProvider.isInPlan(r.id)).fold(0.0, (total, r) => total + r.nutrition.fats);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final planner = context.watch<MealPlannerCubit>();

    final plannedMeals = _allRecipes.where((r) => planner.isInPlan(r.id)).toList();
    final recommendedMeals = _allRecipes.where((r) => !planner.isInPlan(r.id)).take(25).toList();

    return Scaffold(
      appBar: CustomAppBar(title: loc.mealPlanner),
      body: _isLoading
          ? const ShimmerPlanner()
          : Column(children: [
        NutritionSummaryCard(
          totalCalories: _totalCalories, totalProtein: _totalProtein, totalCarbs: _totalCarbs, totalFats: _totalFats,
          plannedMealCount: plannedMeals.length, hasPlannedMeals: plannedMeals.isNotEmpty,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SectionHeader(title: loc.dailyPlan),
              PlannedMealsList(plannedMeals: plannedMeals, onRemoveMeal: _toggleMealInPlan),
              const SizedBox(height: 16),
              SectionHeader(title: loc.recommendedMeals),
              RecommendedMealsList(recommendedMeals: recommendedMeals, onAddMeal: _toggleMealInPlan),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ]),
    );
  }
}
