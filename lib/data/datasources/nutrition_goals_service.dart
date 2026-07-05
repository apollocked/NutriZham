import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/firestore_service.dart';

class NutritionGoalsService {
  static final _cache = CacheService();
  static final _firestoreService = FirestoreService();

  static Future<void> loadNutritionGoals() async {
    try {
      final user = await _firestoreService.getCurrentUserFromFirestore();
      if (user != null) {
        await _cache.setDailyCalories(user.dailyCalories);
        await _cache.setDailyProtein(user.dailyProtein);
        await _cache.setDailyCarbs(user.dailyCarbs);
        await _cache.setDailyFats(user.dailyFats);
      }
    } catch (_) {}
  }

  static Future<Map<String, num>> getNutritionGoals() async {
    final calories = await _cache.getDailyCalories();
    final protein = await _cache.getDailyProtein();
    final carbs = await _cache.getDailyCarbs();
    final fats = await _cache.getDailyFats();
    return {'calories': calories, 'protein': protein, 'carbs': carbs, 'fats': fats};
  }

  static Future<void> updateNutritionGoals({
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
  }) async {
    await _cache.setDailyCalories(calories);
    await _cache.setDailyProtein(protein);
    await _cache.setDailyCarbs(carbs);
    await _cache.setDailyFats(fats);
    try {
      await _firestoreService.updateNutritionGoals(
        calories: calories,
        protein: protein,
        carbs: carbs,
        fats: fats,
      );
    } catch (_) {}
  }
}
