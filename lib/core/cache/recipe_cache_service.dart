import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/meals_data.dart';

class RecipeCacheService {
  static const _recipesKey = 'recipe_cache_data';
  static const _timestampKey = 'recipe_cache_timestamp';
  static const _recipeOfTheDayIdKey = 'recipe_of_the_day_id';
  static const _recipeOfTheDayDateKey = 'recipe_of_the_day_date';
  static const _plannedRecipesKey = 'planned_recipes_cache';
  final CacheService _cache;
  RecipeCacheService(this._cache);
  Future<void> cacheRecipes(List<Recipe> recipes) async {
    final json = jsonEncode(recipes.map((r) => r.toJson()).toList());
    await _cache.setString(_recipesKey, json);
    await _cache.setString(_timestampKey, DateTime.now().toIso8601String());
  }

  Future<List<Recipe>> getCachedRecipes() async {
    final json = await _cache.getString(_recipesKey);
    if (json.isEmpty) return [];
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('RecipeCacheService.getCachedRecipes: $e');
      return [];
    }
  }

  Future<bool> hasCache() async {
    final json = await _cache.getString(_recipesKey);
    return json.isNotEmpty;
  }

  Future<void> cacheRecipeOfTheDay(Recipe recipe) async {
    final today = DateTime.now().toIso8601String().split('T').first;
    await _cache.setString(_recipeOfTheDayIdKey, recipe.id);
    await _cache.setString(_recipeOfTheDayDateKey, today);
    final recipes = await getCachedRecipes();
    final existingIds = recipes.map((r) => r.id).toSet();
    if (!existingIds.contains(recipe.id)) {
      recipes.add(recipe);
      await cacheRecipes(recipes);
    }
  }

  Future<Recipe?> getCachedRecipeOfTheDay() async {
    final today = DateTime.now().toIso8601String().split('T').first;
    final cachedDate = await _cache.getString(_recipeOfTheDayDateKey);
    if (cachedDate != today) return null;
    final id = await _cache.getString(_recipeOfTheDayIdKey);
    if (id.isEmpty) return null;
    final recipes = await getCachedRecipes();
    try {
      return recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      debugPrint('RecipeCacheService.getCachedRecipeOfTheDay: $e');
      return null;
    }
  }

  Future<void> cachePlannedRecipes(List<Recipe> recipes) async {
    final json = jsonEncode(recipes.map((r) => r.toJson()).toList());
    await _cache.setString(_plannedRecipesKey, json);
  }

  Future<List<Recipe>> getCachedPlannedRecipes() async {
    final json = await _cache.getString(_plannedRecipesKey);
    if (json.isEmpty) return [];
    try {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('RecipeCacheService.getCachedPlannedRecipes: $e');
      return [];
    }
  }

  Future<void> clearCache() async {
    await _cache.remove(_recipesKey);
    await _cache.remove(_timestampKey);
    await _cache.remove(_recipeOfTheDayIdKey);
    await _cache.remove(_recipeOfTheDayDateKey);
    await _cache.remove(_plannedRecipesKey);
  }
}
