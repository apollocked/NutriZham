import 'package:nutrizham/domain/repositories/meal_planner_repository.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';

class MealPlannerRepositoryImpl implements MealPlannerRepository {
  @override
  Future<List<String>> loadPlannedMeals() =>
      MealPlannerService.loadPlannedMeals();

  @override
  Future<void> toggleMealInPlan(String recipeId) =>
      MealPlannerService.toggleMealInPlan(recipeId);

  @override
  Future<void> addMealToPlan(String recipeId) =>
      MealPlannerService.addMealToPlan(recipeId);

  @override
  Future<void> removeMealFromPlan(String recipeId) =>
      MealPlannerService.removeMealFromPlan(recipeId);

  @override
  Future<void> clearAllPlannedMeals() =>
      MealPlannerService.clearAllPlannedMeals();

  @override
  Future<bool> isMealInPlan(String recipeId) =>
      MealPlannerService.isMealInPlan(recipeId);
}
