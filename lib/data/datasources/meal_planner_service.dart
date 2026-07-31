import 'package:flutter/foundation.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/firestore_service.dart';
import 'package:nutrizham/data/datasources/meal_planner_helpers.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';

class MealPlannerService {
  static final _cache = CacheService();
  static final FirestoreService _firestoreService = FirestoreService();

  static Stream<Map<String, List<MealPlanEntry>>> get mealPlansStream =>
      mealPlansStreamTop;

  static Future<void> _syncPlanToFirestore(
      String key, List<MealPlanEntry>? entries) async {
    try {
      final firestoreMap = await _firestoreService.getMealPlans();
      final updatedMap = Map<String, dynamic>.from(firestoreMap);
      if (entries == null) {
        updatedMap.remove(key);
      } else {
        updatedMap[key] = entries.map((e) => e.toJson()).toList();
      }
      await _firestoreService.setMealPlans(updatedMap);
    } catch (e) {
      debugPrint('MealPlannerService._syncPlanToFirestore: $e');
    }
  }

  static Future<Map<String, List<MealPlanEntry>>> loadMealPlans() async {
    final cachedJson = await _cache.getMealPlansJson();
    final cached = decodeMealPlans(cachedJson);
    try {
      final firestoreMap = await _firestoreService.getMealPlans();
      if (firestoreMap.isNotEmpty) {
        final firestore = <String, List<MealPlanEntry>>{};
        firestoreMap.forEach((date, value) {
          if (value is List) {
            final entries = <MealPlanEntry>[];
            for (final e in value) {
              if (e is Map) {
                entries.add(MealPlanEntry.fromJson(
                    Map<String, dynamic>.from(e)));
              }
            }
            firestore[date] = entries;
          }
        });
        final merged = Map<String, List<MealPlanEntry>>.from(firestore);
        cached.forEach((date, entries) {
          merged.putIfAbsent(date, () => entries);
        });
        await _cache.setMealPlansJson(encodeMealPlans(merged));
        await updateLocalAndNotify(merged);
        return merged;
      } else if (cached.isNotEmpty) {
        await _firestoreService.syncMealPlansWithFirestore(
            cached.map((date, entries) => MapEntry(date, entries.map((e) => e.toJson()).toList())));
      }
    } catch (e) {
      debugPrint('MealPlannerService.loadMealPlans: $e');
    }
    await updateLocalAndNotify(cached);
    return cached;
  }

  static Future<void> addMealToDate(
      String recipeId, DateTime date, String slot) async {
    final cachedJson = await _cache.getMealPlansJson();
    final plans = decodeMealPlans(cachedJson);
    final key = dateKey(date);
    final entries = List<MealPlanEntry>.from(plans[key] ?? []);
    entries.add(MealPlanEntry(recipeId: recipeId, slot: slot, order: entries.length));
    plans[key] = entries;
    await updateLocalAndNotify(plans);
    await _syncPlanToFirestore(key, entries);
  }

  static Future<void> removeMealFromDate(
      String recipeId, DateTime date, String slot) async {
    final cachedJson = await _cache.getMealPlansJson();
    final plans = decodeMealPlans(cachedJson);
    final key = dateKey(date);
    final entries = List<MealPlanEntry>.from(plans[key] ?? []);
    entries.removeWhere((e) => e.recipeId == recipeId && e.slot == slot);
    if (entries.isEmpty) {
      plans.remove(key);
      await updateLocalAndNotify(plans);
      await _syncPlanToFirestore(key, null);
    } else {
      plans[key] = entries;
      await updateLocalAndNotify(plans);
      await _syncPlanToFirestore(key, entries);
    }
  }

  static Future<void> moveMealToSlot(
      String recipeId, DateTime date, String fromSlot, String toSlot) async {
    if (fromSlot == toSlot) return;
    final cachedJson = await _cache.getMealPlansJson();
    final plans = decodeMealPlans(cachedJson);
    final key = dateKey(date);
    final entries = List<MealPlanEntry>.from(plans[key] ?? []);
    final sourceIndex = entries.indexWhere((e) => e.recipeId == recipeId && e.slot == fromSlot);
    if (sourceIndex == -1) return;
    final moved = entries.removeAt(sourceIndex);
    final targetSlotEntries = entries.where((e) => e.slot == toSlot).toList(growable: false);
    entries.add(MealPlanEntry(recipeId: moved.recipeId, slot: toSlot, order: targetSlotEntries.length));
    plans[key] = entries;
    await updateLocalAndNotify(plans);
    await _syncPlanToFirestore(key, entries);
  }

  static Future<void> reorderMealInSlot(
      DateTime date, String slot, int oldIndex, int newIndex) async {
    final cachedJson = await _cache.getMealPlansJson();
    final plans = decodeMealPlans(cachedJson);
    final key = dateKey(date);
    final entries = List<MealPlanEntry>.from(plans[key] ?? []);
    final slotEntries = entries.where((e) => e.slot == slot).toList();
    final otherEntries = entries.where((e) => e.slot != slot).toList();
    if (oldIndex < 0 || oldIndex >= slotEntries.length) return;
    final moved = slotEntries.removeAt(oldIndex);
    slotEntries.insert(newIndex.clamp(0, slotEntries.length), moved);
    final reindexed = slotEntries.asMap().entries.map((e) =>
        MealPlanEntry(recipeId: e.value.recipeId, slot: slot, order: e.key));
    plans[key] = [...otherEntries, ...reindexed];
    await updateLocalAndNotify(plans);
    await _syncPlanToFirestore(key, plans[key]);
  }

  static Future<List<MealPlanEntry>> getMealsForDate(DateTime date) async {
    final cachedJson = await _cache.getMealPlansJson();
    return decodeMealPlans(cachedJson)[dateKey(date)] ?? [];
  }

  static Future<bool> isMealPlannedOnDate(String recipeId, DateTime date) async {
    final meals = await getMealsForDate(date);
    return meals.any((e) => e.recipeId == recipeId);
  }

  static Future<List<String>> getAllPlannedRecipeIds() async {
    final cachedJson = await _cache.getMealPlansJson();
    final plans = decodeMealPlans(cachedJson);
    return plans.values.expand((entries) => entries).map((e) => e.recipeId).toSet().toList();
  }

  static Future<Map<String, List<MealPlanEntry>>> getAllMealPlans() async {
    final cachedJson = await _cache.getMealPlansJson();
    return decodeMealPlans(cachedJson);
  }

  static Future<void> clearAllPlans() async {
    await _cache.removeMealPlans();
    await updateLocalAndNotify({});
    try {
      await _firestoreService.setMealPlans({});
    } catch (e) {
      debugPrint('MealPlannerService.clearAllPlans: $e');
    }
  }

  static void dispose() {
    closeMealPlansStream();
  }
}
