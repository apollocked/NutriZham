import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';
import 'package:nutrizham/data/datasources/nutrition_goals_service.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/presentation/blocs/planner_state.dart';
export 'package:nutrizham/presentation/blocs/planner_state.dart';

class MealPlannerCubit extends Cubit<MealPlannerState> {
  MealPlannerCubit() : super(const PlannerInitial());

  static String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  static DateTime _weekStart(DateTime date) {
    final weekday = date.weekday;
    return DateTime(date.year, date.month, date.day - (weekday - 1));
  }

  List<MealPlanEntry> get mealsForSelectedDate {
    final s = state;
    if (s is! PlannerLoaded) return [];
    return s.mealPlans[_dateKey(s.selectedDate)] ?? [];
  }

  List<MealPlanEntry> getMealsBySlot(String slot) {
    return mealsForSelectedDate.where((e) => e.slot == slot).toList();
  }

  Future<void> loadPlannedMeals() async {
    emit(const PlannerLoading());
    try {
      final plans = await MealPlannerService.loadMealPlans();
      await NutritionGoalsService.loadNutritionGoals();
      final goals = await NutritionGoalsService.getNutritionGoals();
      final today = DateTime.now();
      emit(PlannerLoaded(
        mealPlans: plans, selectedDate: today, weekStart: _weekStart(today),
        dailyCaloriesGoal: goals['calories'] as int,
        dailyProteinGoal: (goals['protein'] as num).toDouble(),
        dailyCarbsGoal: (goals['carbs'] as num).toDouble(),
        dailyFatsGoal: (goals['fats'] as num).toDouble(),
      ));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  void selectDate(DateTime date) {
    final s = state;
    if (s is! PlannerLoaded) return;
    emit(s.copyWith(selectedDate: date, weekStart: _weekStart(date)));
  }

  void goToPreviousWeek() {
    final s = state;
    if (s is! PlannerLoaded) return;
    final newStart = s.weekStart.subtract(const Duration(days: 7));
    emit(s.copyWith(weekStart: newStart, selectedDate: newStart));
  }

  void goToNextWeek() {
    final s = state;
    if (s is! PlannerLoaded) return;
    final newStart = s.weekStart.add(const Duration(days: 7));
    emit(s.copyWith(weekStart: newStart, selectedDate: newStart));
  }

  Future<void> addMealToDate(String recipeId, String slot) async {
    try {
      if (state is! PlannerLoaded) {
        await loadPlannedMeals();
        if (state is! PlannerLoaded) return;
      }
      final loaded = state as PlannerLoaded;
      await MealPlannerService.addMealToDate(recipeId, loaded.selectedDate, slot);
      final plans = await MealPlannerService.getAllMealPlans();
      emit(loaded.copyWith(mealPlans: plans));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  Future<void> removeMealFromDate(String recipeId, String slot) async {
    try {
      final s = state;
      if (s is! PlannerLoaded) return;
      await MealPlannerService.removeMealFromDate(recipeId, s.selectedDate, slot);
      final plans = await MealPlannerService.getAllMealPlans();
      emit(s.copyWith(mealPlans: plans));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  Future<void> moveMealToSlot(String recipeId, String fromSlot, String toSlot) async {
    try {
      final s = state;
      if (s is! PlannerLoaded) return;
      await MealPlannerService.moveMealToSlot(recipeId, s.selectedDate, fromSlot, toSlot);
      final plans = await MealPlannerService.getAllMealPlans();
      emit(s.copyWith(mealPlans: plans));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  Future<void> reorderMealInSlot(String slot, int oldIndex, int newIndex) async {
    try {
      final s = state;
      if (s is! PlannerLoaded) return;
      await MealPlannerService.reorderMealInSlot(s.selectedDate, slot, oldIndex, newIndex);
      final plans = await MealPlannerService.getAllMealPlans();
      emit(s.copyWith(mealPlans: plans));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  Future<void> updateNutritionGoals({
    required int calories, required double protein, required double carbs, required double fats,
  }) async {
    try {
      final s = state;
      if (s is! PlannerLoaded) return;
      await NutritionGoalsService.updateNutritionGoals(calories: calories, protein: protein, carbs: carbs, fats: fats);
      emit(s.copyWith(dailyCaloriesGoal: calories, dailyProteinGoal: protein, dailyCarbsGoal: carbs, dailyFatsGoal: fats));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  bool isInPlan(String recipeId) {
    final s = state;
    if (s is! PlannerLoaded) return false;
    return s.mealPlans.values.expand((entries) => entries).any((e) => e.recipeId == recipeId);
  }

  int get count {
    final s = state;
    if (s is! PlannerLoaded) return 0;
    return s.mealPlans.values.expand((entries) => entries).length;
  }
}
