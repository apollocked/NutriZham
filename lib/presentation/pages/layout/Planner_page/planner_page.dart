import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/planner/add_meal_sheet.dart';
import 'package:nutrizham/presentation/widgets/planner/edit_goals_dialog.dart';
import 'package:nutrizham/presentation/widgets/planner/meal_slot_section.dart';
import 'package:nutrizham/presentation/widgets/planner/nutrition_goals_card.dart';
import 'package:nutrizham/presentation/widgets/planner/planner_date_header.dart';
import 'package:nutrizham/presentation/widgets/planner/weekly_calendar_bar.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});
  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Recipe> _allRecipes = [];
  bool _isLoading = true;
  final _collapsedSlots = <String>{};

  @override
  void initState() {
    super.initState();
    context.read<MealPlannerCubit>().loadPlannedMeals();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = await context.read<RecipeCubit>().getAll();
    if (mounted) setState(() { _allRecipes = recipes; _isLoading = false; });
  }

  List<Recipe> _mealsForSlot(String slot) {
    final s = context.read<MealPlannerCubit>().state;
    if (s is! PlannerLoaded) return [];
    final ids = context.read<MealPlannerCubit>().getMealsBySlot(slot).map((e) => e.recipeId).toSet();
    return _allRecipes.where((r) => ids.contains(r.id)).toList();
  }

  List<Recipe> _available() {
    final s = context.read<MealPlannerCubit>().state;
    if (s is! PlannerLoaded) return _allRecipes;
    final planned = context.read<MealPlannerCubit>().mealsForSelectedDate.map((e) => e.recipeId).toSet();
    return _allRecipes.where((r) => !planned.contains(r.id)).toList();
  }

  double _total(String macro) {
    return context.read<MealPlannerCubit>().mealsForSelectedDate.fold(0.0, (double sum, e) {
      final r = _allRecipes.where((x) => x.id == e.recipeId);
      if (r.isEmpty) return sum;
      switch (macro) {
        case 'calories': return sum + r.first.nutrition.calories;
        case 'protein': return sum + r.first.nutrition.protein;
        case 'carbs': return sum + r.first.nutrition.carbs;
        case 'fats': return sum + r.first.nutrition.fats;
        default: return sum;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final planner = context.watch<MealPlannerCubit>();
    final s = planner.state;

    if (s is PlannerLoading || _isLoading) {
      return Scaffold(appBar: CustomAppBar(title: loc.mealPlanner), body: const ShimmerPlanner());
    }
    if (s is PlannerError) {
      return Scaffold(appBar: CustomAppBar(title: loc.mealPlanner), body: Center(child: Text(s.message)));
    }
    if (s is! PlannerLoaded) {
      return Scaffold(appBar: CustomAppBar(title: loc.mealPlanner), body: const ShimmerPlanner());
    }

    final loaded = s;
    final selectedDate = loaded.selectedDate;
    final weekStart = loaded.weekStart;
    final today = DateTime.now();
    final totalCalories = _total('calories').toInt();
    final totalProtein = _total('protein');
    final totalCarbs = _total('carbs');
    final totalFats = _total('fats');
    final hasMeals = planner.mealsForSelectedDate.isNotEmpty;

    final slots = ['breakfast', 'lunch', 'dinner', 'snack'];
    final slotCategories = {
      'breakfast': MealCategory.breakfast,
      'lunch': MealCategory.lunch,
      'dinner': MealCategory.dinner,
      'snack': MealCategory.snack,
    };

    return Scaffold(
      appBar: CustomAppBar(title: loc.mealPlanner),
      body: Column(
        children: [
          WeeklyCalendarBar(
            weekStart: weekStart, selectedDate: selectedDate, today: today,
            onDateSelected: (d) => planner.selectDate(d),
            onPreviousWeek: () => planner.goToPreviousWeek(),
            onNextWeek: () => planner.goToNextWeek(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NutritionGoalsCard(
                    totalCalories: totalCalories, totalProtein: totalProtein,
                    totalCarbs: totalCarbs, totalFats: totalFats,
                    dailyCaloriesGoal: loaded.dailyCaloriesGoal,
                    dailyProteinGoal: loaded.dailyProteinGoal,
                    dailyCarbsGoal: loaded.dailyCarbsGoal,
                    dailyFatsGoal: loaded.dailyFatsGoal,
                    plannedMealCount: planner.mealsForSelectedDate.length,
                    hasPlannedMeals: hasMeals,
                    onEditGoals: () => EditGoalsDialog.show(context,
                      dailyCaloriesGoal: loaded.dailyCaloriesGoal,
                      dailyProteinGoal: loaded.dailyProteinGoal,
                      dailyCarbsGoal: loaded.dailyCarbsGoal,
                      dailyFatsGoal: loaded.dailyFatsGoal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PlannerDateHeader(
                    selectedDate: selectedDate,
                    hasMeals: hasMeals,
                    onGroceryList: () => context.push('/planner/grocery-list', extra: _allRecipes),
                  ),
                  const SizedBox(height: 8),
                  ...slots.map((slot) => MealSlotSection(
                    key: ValueKey('${selectedDate.millisecondsSinceEpoch}_$slot'),
                    slot: slotCategories[slot]!,
                    meals: _mealsForSlot(slot),
                    isCollapsed: _collapsedSlots.contains(slot),
                    onToggleCollapse: () => setState(() {
                      if (_collapsedSlots.contains(slot)) { _collapsedSlots.remove(slot); }
                      else { _collapsedSlots.add(slot); }
                    }),
                    onRemoveMeal: (id, slot) => planner.removeMealFromDate(id, slot),
                    onReorder: (oldIndex, newIndex) => planner.reorderMealInSlot(slot, oldIndex, newIndex),
                    onMoveMeal: (recipeId, fromSlot) => planner.moveMealToSlot(recipeId, fromSlot, slot),
                    onAddMeal: () => AddMealSheet.show(context, _available(), slot),
                  )),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
