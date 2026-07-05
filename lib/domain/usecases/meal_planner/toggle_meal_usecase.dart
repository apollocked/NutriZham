import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/domain/repositories/meal_planner_repository.dart';

class ToggleMealUseCase {
  final MealPlannerRepository repository;
  ToggleMealUseCase(this.repository);

  Future<void> call(String recipeId, DateTime date, String slot) =>
      repository.addMealToDate(recipeId, date, slot);

  Future<bool> isPlanned(String recipeId, List<MealPlanEntry> entries) =>
      Future.value(entries.any((e) => e.recipeId == recipeId));
}
