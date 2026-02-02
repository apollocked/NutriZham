import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MealPlannerService {
  static final StreamController<List<String>> _plannedMealsStreamController =
      StreamController<List<String>>.broadcast();

  static Stream<List<String>> get plannedMealsStream =>
      _plannedMealsStreamController.stream;

  // Load planned meals
  static Future<List<String>> loadPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];
    _plannedMealsStreamController.add(plannedMeals);
    return plannedMeals;
  }

  // Toggle meal in plan
  static Future<void> toggleMealInPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];

    if (plannedMeals.contains(recipeId)) {
      plannedMeals.remove(recipeId);
    } else {
      plannedMeals.add(recipeId);
    }

    await prefs.setStringList('planned_meals', plannedMeals);
    _plannedMealsStreamController.add(plannedMeals);
  }

  // Add meal to plan
  static Future<void> addMealToPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];

    if (!plannedMeals.contains(recipeId)) {
      plannedMeals.add(recipeId);
      await prefs.setStringList('planned_meals', plannedMeals);
      _plannedMealsStreamController.add(plannedMeals);
    }
  }

  // Remove meal from plan
  static Future<void> removeMealFromPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];

    if (plannedMeals.contains(recipeId)) {
      plannedMeals.remove(recipeId);
      await prefs.setStringList('planned_meals', plannedMeals);
      _plannedMealsStreamController.add(plannedMeals);
    }
  }

  // Clear all planned meals
  static Future<void> clearAllPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('planned_meals');
    _plannedMealsStreamController.add([]);
  }

  // Get planned meals count
  static Future<int> getPlannedMealsCount() async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];
    return plannedMeals.length;
  }

  // Check if meal is in plan
  static Future<bool> isMealInPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];
    return plannedMeals.contains(recipeId);
  }

  // Check if any meals are planned
  static Future<bool> hasPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];
    return plannedMeals.isNotEmpty;
  }

  static void dispose() {
    _plannedMealsStreamController.close();
  }
}
