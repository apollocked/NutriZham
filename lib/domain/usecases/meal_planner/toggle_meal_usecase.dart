import 'package:nutrizham/domain/repositories/meal_planner_repository.dart';

class ToggleMealUseCase {
  final MealPlannerRepository repository;
  ToggleMealUseCase(this.repository);

  Future<void> call(String recipeId) => repository.toggleMealInPlan(recipeId);
}
