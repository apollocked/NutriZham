import 'package:flutter/material.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';

class MealPlannerProvider extends ChangeNotifier {
  List<String> _plannedMealIds = [];

  List<String> get plannedMealIds => _plannedMealIds;

  Future<void> loadPlannedMeals() async {
    _plannedMealIds = await MealPlannerService.loadPlannedMeals();
    notifyListeners();
  }

  Future<void> toggleMealInPlan(String recipeId) async {
    await MealPlannerService.toggleMealInPlan(recipeId);
    _plannedMealIds = await MealPlannerService.loadPlannedMeals();
    notifyListeners();
  }

  Future<void> addMealToPlan(String recipeId) async {
    await MealPlannerService.addMealToPlan(recipeId);
    _plannedMealIds = await MealPlannerService.loadPlannedMeals();
    notifyListeners();
  }

  Future<void> removeMealFromPlan(String recipeId) async {
    await MealPlannerService.removeMealFromPlan(recipeId);
    _plannedMealIds = await MealPlannerService.loadPlannedMeals();
    notifyListeners();
  }

  bool isInPlan(String recipeId) => _plannedMealIds.contains(recipeId);

  int get count => _plannedMealIds.length;

  Future<void> clearAll() async {
    await MealPlannerService.clearAllPlannedMeals();
    _plannedMealIds = [];
    notifyListeners();
  }
}
