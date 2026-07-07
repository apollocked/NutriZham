import 'dart:convert';
import 'dart:async';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';

final _cache = CacheService();
final _mealPlansStreamController =
    StreamController<Map<String, List<MealPlanEntry>>>.broadcast();

Stream<Map<String, List<MealPlanEntry>>> get mealPlansStream =>
    _mealPlansStreamController.stream;

String dateKey(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

Map<String, List<MealPlanEntry>> decodeMealPlans(String json) {
  if (json.isEmpty) return {};
  try {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return map.map((date, value) => MapEntry(
          date,
          (value as List)
              .map((e) => MealPlanEntry.fromJson(e as Map<String, dynamic>))
              .toList(),
        ));
  } catch (_) {
    return {};
  }
}

String encodeMealPlans(Map<String, List<MealPlanEntry>> plans) =>
    jsonEncode(plans.map((date, entries) =>
        MapEntry(date, entries.map((e) => e.toJson()).toList())));

Future<void> updateLocalAndNotify(Map<String, List<MealPlanEntry>> plans) async {
  await _cache.setMealPlansJson(encodeMealPlans(plans));
  _mealPlansStreamController.add(plans);
}

void closeMealPlansStream() {
  _mealPlansStreamController.close();
}
