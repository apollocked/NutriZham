// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:nutrizham/services/firestore_service.dart';

class MealPlannerService {
  static final StreamController<List<String>> _plannedMealsStreamController =
      StreamController<List<String>>.broadcast();
  static final FirestoreService _firestoreService = FirestoreService();

  static Stream<List<String>> get plannedMealsStream =>
      _plannedMealsStreamController.stream;

  // Load planned meals
  static Future<List<String>> loadPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];

    // Try to sync with Firestore
    try {
      final firestorePlannedMeals =
          await _firestoreService.getUserPlannedMeals();

      // Merge: use Firestore data if available, otherwise use local
      if (firestorePlannedMeals.isNotEmpty) {
        await prefs.setStringList('planned_meals', firestorePlannedMeals);
        _plannedMealsStreamController.add(firestorePlannedMeals);
        return firestorePlannedMeals;
      } else if (plannedMeals.isNotEmpty) {
        // Sync local to Firestore
        await _firestoreService.syncPlannedMealsWithFirestore(plannedMeals);
      }
    } catch (e) {
      print('Error syncing planned meals: $e');
      // Continue with local data if Firestore fails
    }

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

    // Sync with Firestore
    try {
      await _firestoreService.togglePlannedMeal(recipeId);
    } catch (e) {
      print('Error syncing planned meal to Firestore: $e');
      await _scheduleSync();
    }
  }

  // Add meal to plan
  static Future<void> addMealToPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final plannedMeals = prefs.getStringList('planned_meals') ?? [];

    if (!plannedMeals.contains(recipeId)) {
      plannedMeals.add(recipeId);
      await prefs.setStringList('planned_meals', plannedMeals);
      _plannedMealsStreamController.add(plannedMeals);

      // Sync with Firestore
      try {
        await _firestoreService.addMealToPlan(recipeId);
      } catch (e) {
        print('Error adding meal to Firestore plan: $e');
        await _scheduleSync();
      }
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

      // Sync with Firestore
      try {
        await _firestoreService.removeMealFromPlan(recipeId);
      } catch (e) {
        print('Error removing meal from Firestore plan: $e');
        await _scheduleSync();
      }
    }
  }

  // Clear all planned meals
  static Future<void> clearAllPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('planned_meals');
    _plannedMealsStreamController.add([]);

    // Clear from Firestore
    try {
      final plannedMeals = await _firestoreService.getUserPlannedMeals();
      for (final recipeId in plannedMeals) {
        await _firestoreService.removeMealFromPlan(recipeId);
      }
    } catch (e) {
      print('Error clearing planned meals from Firestore: $e');
    }
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

  // Schedule sync for later if offline
  static Future<void> _scheduleSync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('planned_meals_needs_sync', true);
  }

  // Check and perform pending sync
  static Future<void> checkAndSync() async {
    final prefs = await SharedPreferences.getInstance();
    final needsSync = prefs.getBool('planned_meals_needs_sync') ?? false;

    if (needsSync) {
      try {
        final plannedMeals = prefs.getStringList('planned_meals') ?? [];
        await _firestoreService.syncPlannedMealsWithFirestore(plannedMeals);
        await prefs.setBool('planned_meals_needs_sync', false);
      } catch (e) {
        print('Error during scheduled sync for planned meals: $e');
      }
    }
  }

  static void dispose() {
    _plannedMealsStreamController.close();
  }
}
