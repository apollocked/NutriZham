import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/planner/grocery_list_sheet.dart';
import 'package:nutrizham/presentation/widgets/planner/meal_slot_section.dart';
import 'package:nutrizham/presentation/widgets/planner/nutrition_goals_card.dart';
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
    if (mounted) {
      setState(() {
        _allRecipes = recipes;
        _isLoading = false;
      });
    }
  }

  List<Recipe> _mealsForSlot(MealCategory slot) {
    final state = context.read<MealPlannerCubit>().state;
    if (state is! PlannerLoaded) return [];
    final entries = context.read<MealPlannerCubit>().getMealsBySlot(slot.name);
    final ids = entries.map((e) => e.recipeId).toSet();
    return _allRecipes.where((r) => ids.contains(r.id)).toList();
  }

  List<Recipe> _availableRecipes() {
    final state = context.read<MealPlannerCubit>().state;
    if (state is! PlannerLoaded) return _allRecipes;
    final plannedIds = context
        .read<MealPlannerCubit>()
        .mealsForSelectedDate
        .map((e) => e.recipeId)
        .toSet();
    return _allRecipes.where((r) => !plannedIds.contains(r.id)).toList();
  }

  void _showAddMealSheet(String slot) {
    final available = _availableRecipes();
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Add to ${slot[0].toUpperCase()}${slot.substring(1)}',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${available.length} ${loc.recipesFound}',
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              const Divider(),
              Expanded(
                child: available.isEmpty
                    ? Center(
                        child: Text('All meals already planned',
                            style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant)))
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        itemCount: available.length,
                        itemBuilder: (context, index) {
                          final recipe = available[index];
                          final locale =
                              Localizations.localeOf(context).languageCode;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.getCategoryColor(
                                              recipe.category.name)
                                          .withOpacity(0.15),
                                      AppColors.getCategoryColor(
                                              recipe.category.name)
                                          .withOpacity(0.05),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(recipe.icon,
                                      style: const TextStyle(fontSize: 18)),
                                ),
                              ),
                              title: Text(
                                recipe.title[locale] ??
                                    recipe.title['en'] ??
                                    '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle:
                                  Text('${recipe.nutrition.calories} kcal'),
                              trailing: const Icon(Icons.add_circle_rounded,
                                  color: AppColors.primaryGreen, size: 28),
                              onTap: () {
                                context
                                    .read<MealPlannerCubit>()
                                    .addMealToDate(recipe.id, slot);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditGoalsDialog() {
    final state = context.read<MealPlannerCubit>().state;
    if (state is! PlannerLoaded) return;
    final theme = Theme.of(context);
    final calCtrl =
        TextEditingController(text: state.dailyCaloriesGoal.toString());
    final proteinCtrl =
        TextEditingController(text: state.dailyProteinGoal.toStringAsFixed(0));
    final carbsCtrl =
        TextEditingController(text: state.dailyCarbsGoal.toStringAsFixed(0));
    final fatsCtrl =
        TextEditingController(text: state.dailyFatsGoal.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title:
            Text('Daily Nutrition Goals', style: theme.textTheme.titleMedium),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GoalField(
                  controller: calCtrl, label: 'Calories (kcal)', suffix: ''),
              const SizedBox(height: 12),
              _GoalField(
                  controller: proteinCtrl, label: 'Protein (g)', suffix: 'g'),
              const SizedBox(height: 12),
              _GoalField(
                  controller: carbsCtrl, label: 'Carbs (g)', suffix: 'g'),
              const SizedBox(height: 12),
              _GoalField(controller: fatsCtrl, label: 'Fats (g)', suffix: 'g'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<MealPlannerCubit>().updateNutritionGoals(
                    calories:
                        int.tryParse(calCtrl.text) ?? state.dailyCaloriesGoal,
                    protein: double.tryParse(proteinCtrl.text) ??
                        state.dailyProteinGoal,
                    carbs:
                        double.tryParse(carbsCtrl.text) ?? state.dailyCarbsGoal,
                    fats: double.tryParse(fatsCtrl.text) ?? state.dailyFatsGoal,
                  );
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final planner = context.watch<MealPlannerCubit>();
    final plannerState = planner.state;

    if (plannerState is PlannerLoading || _isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: loc.mealPlanner),
        body: const ShimmerPlanner(),
      );
    }

    if (plannerState is PlannerError) {
      return Scaffold(
        appBar: CustomAppBar(title: loc.mealPlanner),
        body: Center(child: Text(plannerState.message)),
      );
    }

    if (plannerState is! PlannerLoaded) {
      return Scaffold(
        appBar: CustomAppBar(title: loc.mealPlanner),
        body: const ShimmerPlanner(),
      );
    }

    final loaded = plannerState;
    final selectedDate = loaded.selectedDate;
    final weekStart = loaded.weekStart;
    final today = DateTime.now();

    final totalCalories = planner.mealsForSelectedDate.fold(0, (int sum, e) {
      final recipe = _allRecipes.where((r) => r.id == e.recipeId);
      return sum + (recipe.isNotEmpty ? recipe.first.nutrition.calories : 0);
    });
    final totalProtein =
        planner.mealsForSelectedDate.fold(0.0, (double sum, e) {
      final recipe = _allRecipes.where((r) => r.id == e.recipeId);
      return sum + (recipe.isNotEmpty ? recipe.first.nutrition.protein : 0.0);
    });
    final totalCarbs = planner.mealsForSelectedDate.fold(0.0, (double sum, e) {
      final recipe = _allRecipes.where((r) => r.id == e.recipeId);
      return sum + (recipe.isNotEmpty ? recipe.first.nutrition.carbs : 0.0);
    });
    final totalFats = planner.mealsForSelectedDate.fold(0.0, (double sum, e) {
      final recipe = _allRecipes.where((r) => r.id == e.recipeId);
      return sum + (recipe.isNotEmpty ? recipe.first.nutrition.fats : 0.0);
    });

    final hasPlanned = planner.mealsForSelectedDate.isNotEmpty;

    final breakfastMeals = _mealsForSlot(MealCategory.breakfast);
    final lunchMeals = _mealsForSlot(MealCategory.lunch);
    final dinnerMeals = _mealsForSlot(MealCategory.dinner);
    final snackMeals = _mealsForSlot(MealCategory.snack);

    final allWeekRecipes = <Recipe>[];
    for (int i = 0; i < 7; i++) {
      final day = weekStart.add(Duration(days: i));
      final dayKey =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      final dayPlans = loaded.mealPlans[dayKey] ?? [];
      for (final entry in dayPlans) {
        final recipe = _allRecipes.where((r) => r.id == entry.recipeId);
        if (recipe.isNotEmpty && !allWeekRecipes.contains(recipe.first)) {
          allWeekRecipes.add(recipe.first);
        }
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: loc.mealPlanner),
      body: Column(
        children: [
          WeeklyCalendarBar(
            weekStart: weekStart,
            selectedDate: selectedDate,
            today: today,
            onDateSelected: (date) => planner.selectDate(date),
            onPreviousWeek: () => planner.goToPreviousWeek(),
            onNextWeek: () => planner.goToNextWeek(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NutritionGoalsCard(
                    totalCalories: totalCalories,
                    totalProtein: totalProtein,
                    totalCarbs: totalCarbs,
                    totalFats: totalFats,
                    dailyCaloriesGoal: loaded.dailyCaloriesGoal,
                    dailyProteinGoal: loaded.dailyProteinGoal,
                    dailyCarbsGoal: loaded.dailyCarbsGoal,
                    dailyFatsGoal: loaded.dailyFatsGoal,
                    plannedMealCount: planner.mealsForSelectedDate.length,
                    hasPlannedMeals: hasPlanned,
                    onEditGoals: _showEditGoalsDialog,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        if (allWeekRecipes.isNotEmpty)
                          FilledButton.tonalIcon(
                            onPressed: () =>
                                GroceryListSheet.show(context, allWeekRecipes),
                            icon: const Icon(Icons.shopping_cart_rounded,
                                size: 16),
                            label: const Text('Grocery List'),
                            style: FilledButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  MealSlotSection(
                    slot: MealCategory.breakfast,
                    meals: breakfastMeals,
                    isCollapsed: _collapsedSlots.contains('breakfast'),
                    onToggleCollapse: () => setState(() {
                      if (_collapsedSlots.contains('breakfast')) {
                        _collapsedSlots.remove('breakfast');
                      } else {
                        _collapsedSlots.add('breakfast');
                      }
                    }),
                    onRemoveMeal: (id) => planner.removeMealFromDate(id),
                    onReorder: (oldIndex, newIndex) => planner
                        .reorderMealInSlot('breakfast', oldIndex, newIndex),
                    onAddMeal: () => _showAddMealSheet('breakfast'),
                  ),
                  MealSlotSection(
                    slot: MealCategory.lunch,
                    meals: lunchMeals,
                    isCollapsed: _collapsedSlots.contains('lunch'),
                    onToggleCollapse: () => setState(() {
                      if (_collapsedSlots.contains('lunch')) {
                        _collapsedSlots.remove('lunch');
                      } else {
                        _collapsedSlots.add('lunch');
                      }
                    }),
                    onRemoveMeal: (id) => planner.removeMealFromDate(id),
                    onReorder: (oldIndex, newIndex) =>
                        planner.reorderMealInSlot('lunch', oldIndex, newIndex),
                    onAddMeal: () => _showAddMealSheet('lunch'),
                  ),
                  MealSlotSection(
                    slot: MealCategory.dinner,
                    meals: dinnerMeals,
                    isCollapsed: _collapsedSlots.contains('dinner'),
                    onToggleCollapse: () => setState(() {
                      if (_collapsedSlots.contains('dinner')) {
                        _collapsedSlots.remove('dinner');
                      } else {
                        _collapsedSlots.add('dinner');
                      }
                    }),
                    onRemoveMeal: (id) => planner.removeMealFromDate(id),
                    onReorder: (oldIndex, newIndex) =>
                        planner.reorderMealInSlot('dinner', oldIndex, newIndex),
                    onAddMeal: () => _showAddMealSheet('dinner'),
                  ),
                  MealSlotSection(
                    slot: MealCategory.snack,
                    meals: snackMeals,
                    isCollapsed: _collapsedSlots.contains('snack'),
                    onToggleCollapse: () => setState(() {
                      if (_collapsedSlots.contains('snack')) {
                        _collapsedSlots.remove('snack');
                      } else {
                        _collapsedSlots.add('snack');
                      }
                    }),
                    onRemoveMeal: (id) => planner.removeMealFromDate(id),
                    onReorder: (oldIndex, newIndex) =>
                        planner.reorderMealInSlot('snack', oldIndex, newIndex),
                    onAddMeal: () => _showAddMealSheet('snack'),
                  ),
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

class _GoalField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String suffix;

  const _GoalField({
    required this.controller,
    required this.label,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
