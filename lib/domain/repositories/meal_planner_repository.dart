abstract class MealPlannerRepository {
  Future<List<String>> loadPlannedMeals();
  Future<void> toggleMealInPlan(String recipeId);
  Future<void> addMealToPlan(String recipeId);
  Future<void> removeMealFromPlan(String recipeId);
  Future<void> clearAllPlannedMeals();
  Future<bool> isMealInPlan(String recipeId);
}
