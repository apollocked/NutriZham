import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';

sealed class MealPlannerState {
  const MealPlannerState();
}
class PlannerInitial extends MealPlannerState {
  const PlannerInitial();
}
class PlannerLoading extends MealPlannerState {
  const PlannerLoading();
}
class PlannerLoaded extends MealPlannerState {
  final List<String> ids;
  const PlannerLoaded(this.ids);
}
class PlannerError extends MealPlannerState {
  final String message;
  const PlannerError(this.message);
}

class MealPlannerCubit extends Cubit<MealPlannerState> {
  MealPlannerCubit() : super(const PlannerInitial());

  List<String> get ids {
    final s = state;
    return s is PlannerLoaded ? s.ids : [];
  }

  Future<void> loadPlannedMeals() async {
    emit(const PlannerLoading());
    try {
      final ids = await MealPlannerService.loadPlannedMeals();
      emit(PlannerLoaded(ids));
    } catch (e) {
      emit(PlannerError(e.toString()));
    }
  }

  Future<void> toggleMealInPlan(String recipeId) async {
    await MealPlannerService.toggleMealInPlan(recipeId);
    final ids = await MealPlannerService.loadPlannedMeals();
    emit(PlannerLoaded(ids));
  }

  Future<void> addMealToPlan(String recipeId) async {
    await MealPlannerService.addMealToPlan(recipeId);
    final ids = await MealPlannerService.loadPlannedMeals();
    emit(PlannerLoaded(ids));
  }

  Future<void> removeMealFromPlan(String recipeId) async {
    await MealPlannerService.removeMealFromPlan(recipeId);
    final ids = await MealPlannerService.loadPlannedMeals();
    emit(PlannerLoaded(ids));
  }

  bool isInPlan(String recipeId) => ids.contains(recipeId);

  int get count => ids.length;

  Future<void> clearAll() async {
    await MealPlannerService.clearAllPlannedMeals();
    emit(const PlannerLoaded([]));
  }
}
