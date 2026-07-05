import 'package:nutrizham/data/models/meal_plan_entry.dart';

abstract class MealPlannerRepository {
  Future<Map<String, List<MealPlanEntry>>> loadMealPlans();
  Future<void> addMealToDate(String recipeId, DateTime date, String slot);
  Future<void> removeMealFromDate(String recipeId, DateTime date, String slot);
  Future<void> reorderMealInSlot(
      DateTime date, String slot, int oldIndex, int newIndex);
  Future<List<String>> getAllPlannedRecipeIds();
  Future<void> clearAllPlans();
  Future<Map<String, num>> getNutritionGoals();
  Future<void> updateNutritionGoals({
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
  });
}
