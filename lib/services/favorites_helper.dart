import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class FavoritesHelper {
  static final StreamController<Set<String>> _favoritesStreamController =
      StreamController<Set<String>>.broadcast();

  static Stream<Set<String>> get favoritesStream =>
      _favoritesStreamController.stream;

  static Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    final favoritesSet = favorites.toSet();
    _favoritesStreamController.add(favoritesSet); // Add initial state to stream
    return favoritesSet;
  }

  static Future<void> toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    final favoritesSet = favorites.toSet();

    if (favoritesSet.contains(recipeId)) {
      favoritesSet.remove(recipeId);
    } else {
      favoritesSet.add(recipeId);
    }

    await prefs.setStringList('favorites', favoritesSet.toList());
    _favoritesStreamController.add(favoritesSet); // Notify all listeners
  }

  static Future<bool> isFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.contains(recipeId);
  }

  // Clear all favorites
  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites');
    _favoritesStreamController.add(<String>{});
  }

  // Get favorites count
  static Future<int> getFavoritesCount() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.length;
  }

  // Check if any favorites exist
  static Future<bool> hasFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    return favorites.isNotEmpty;
  }

  static void dispose() {
    _favoritesStreamController.close();
  }
}
