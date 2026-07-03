import 'package:flutter/material.dart';
import 'package:nutrizham/services/favorites_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  Future<void> loadFavorites() async {
    _favoriteIds = await FavoritesHelper.loadFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(String recipeId) async {
    await FavoritesHelper.toggleFavorite(recipeId);
    _favoriteIds = await FavoritesHelper.loadFavorites();
    notifyListeners();
  }

  bool isFavorite(String recipeId) => _favoriteIds.contains(recipeId);

  int get count => _favoriteIds.length;

  Future<void> clearAll() async {
    await FavoritesHelper.clearAllFavorites();
    _favoriteIds = {};
    notifyListeners();
  }
}
