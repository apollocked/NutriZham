import 'dart:async';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/firestore_service.dart';

class MealPlannerService {
  static final _cache = CacheService();
  static final StreamController<List<String>> _plannedMealsStreamController =
      StreamController<List<String>>.broadcast();
  static final FirestoreService _firestoreService = FirestoreService();

  static Stream<List<String>> get plannedMealsStream =>
      _plannedMealsStreamController.stream;

  static Future<List<String>> loadPlannedMeals() async {
    final plannedMeals = await _cache.getPlannedMeals();

    try {
      final firestoreMeals = await _firestoreService.getUserPlannedMeals();

      if (firestoreMeals.isNotEmpty) {
        await _cache.setPlannedMeals(firestoreMeals);
        _plannedMealsStreamController.add(firestoreMeals);
        return firestoreMeals;
      } else if (plannedMeals.isNotEmpty) {
        await _firestoreService.syncPlannedMealsWithFirestore(plannedMeals);
      }
    } catch (_) {}

    _plannedMealsStreamController.add(plannedMeals);
    return plannedMeals;
  }

  static Future<void> toggleMealInPlan(String recipeId) async {
    final plannedMeals = await _cache.getPlannedMeals();

    if (plannedMeals.contains(recipeId)) {
      plannedMeals.remove(recipeId);
    } else {
      plannedMeals.add(recipeId);
    }

    await _cache.setPlannedMeals(plannedMeals);
    _plannedMealsStreamController.add(plannedMeals);

    try {
      await _firestoreService.togglePlannedMeal(recipeId);
    } catch (_) {
      await _cache.setPlannedMealsNeedsSync(true);
    }
  }

  static Future<void> addMealToPlan(String recipeId) async {
    final plannedMeals = await _cache.getPlannedMeals();

    if (!plannedMeals.contains(recipeId)) {
      plannedMeals.add(recipeId);
      await _cache.setPlannedMeals(plannedMeals);
      _plannedMealsStreamController.add(plannedMeals);

      try {
        await _firestoreService.addMealToPlan(recipeId);
      } catch (_) {
        await _cache.setPlannedMealsNeedsSync(true);
      }
    }
  }

  static Future<void> removeMealFromPlan(String recipeId) async {
    final plannedMeals = await _cache.getPlannedMeals();

    if (plannedMeals.contains(recipeId)) {
      plannedMeals.remove(recipeId);
      await _cache.setPlannedMeals(plannedMeals);
      _plannedMealsStreamController.add(plannedMeals);

      try {
        await _firestoreService.removeMealFromPlan(recipeId);
      } catch (_) {
        await _cache.setPlannedMealsNeedsSync(true);
      }
    }
  }

  static Future<void> clearAllPlannedMeals() async {
    await _cache.removePlannedMeals();
    _plannedMealsStreamController.add([]);

    try {
      final plannedMeals = await _firestoreService.getUserPlannedMeals();
      for (final id in plannedMeals) {
        await _firestoreService.removeMealFromPlan(id);
      }
    } catch (_) {}
  }

  static Future<int> getPlannedMealsCount() async {
    final plannedMeals = await _cache.getPlannedMeals();
    return plannedMeals.length;
  }

  static Future<bool> isMealInPlan(String recipeId) async {
    final plannedMeals = await _cache.getPlannedMeals();
    return plannedMeals.contains(recipeId);
  }

  static Future<bool> hasPlannedMeals() async {
    final plannedMeals = await _cache.getPlannedMeals();
    return plannedMeals.isNotEmpty;
  }

  static Future<void> checkAndSync() async {
    if (!await _cache.plannedMealsNeedsSync()) return;
    try {
      final plannedMeals = await _cache.getPlannedMeals();
      await _firestoreService.syncPlannedMealsWithFirestore(plannedMeals);
      await _cache.setPlannedMealsNeedsSync(false);
    } catch (_) {}
  }

  static void dispose() {
    _plannedMealsStreamController.close();
  }
}
