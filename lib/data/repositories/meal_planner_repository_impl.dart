import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/domain/repositories/meal_planner_repository.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';

class MealPlannerRepositoryImpl implements MealPlannerRepository {
  @override
  Future<Map<String, List<MealPlanEntry>>> loadMealPlans() =>
      MealPlannerService.loadMealPlans();

  @override
  Future<void> addMealToDate(String recipeId, DateTime date, String slot) =>
      MealPlannerService.addMealToDate(recipeId, date, slot);

  @override
  Future<void> removeMealFromDate(String recipeId, DateTime date) =>
      MealPlannerService.removeMealFromDate(recipeId, date);

  @override
  Future<void> reorderMealInSlot(
          DateTime date, String slot, int oldIndex, int newIndex) =>
      MealPlannerService.reorderMealInSlot(date, slot, oldIndex, newIndex);

  @override
  Future<List<String>> getAllPlannedRecipeIds() =>
      MealPlannerService.getAllPlannedRecipeIds();

  @override
  Future<void> clearAllPlans() => MealPlannerService.clearAllPlans();

  @override
  Future<Map<String, num>> getNutritionGoals() =>
      MealPlannerService.getNutritionGoals();

  @override
  Future<void> updateNutritionGoals({
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
  }) =>
      MealPlannerService.updateNutritionGoals(
          calories: calories,
          protein: protein,
          carbs: carbs,
          fats: fats);
}
