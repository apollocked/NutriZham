import 'dart:async';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/firestore_service.dart';

class FavoritesHelper {
  static final _cache = CacheService();
  static final StreamController<Set<String>> _favoritesStreamController =
      StreamController<Set<String>>.broadcast();
  static final FirestoreService _firestoreService = FirestoreService();

  static Stream<Set<String>> get favoritesStream =>
      _favoritesStreamController.stream;

  static Future<Set<String>> loadFavorites() async {
    final favorites = await _cache.getFavorites();
    final favoritesSet = favorites.toSet();

    try {
      final firestoreFavorites = await _firestoreService.getUserFavorites();
      final firestoreSet = firestoreFavorites.toSet();

      if (firestoreSet.isNotEmpty) {
        await _cache.setFavorites(firestoreSet.toList());
        _favoritesStreamController.add(firestoreSet);
        return firestoreSet;
      } else if (favoritesSet.isNotEmpty) {
        await _firestoreService.syncFavoritesWithFirestore(favoritesSet);
      }
    } catch (_) {}

    _favoritesStreamController.add(favoritesSet);
    return favoritesSet;
  }

  static Future<void> toggleFavorite(String recipeId) async {
    final favorites = await _cache.getFavorites();
    final favoritesSet = favorites.toSet();

    if (favoritesSet.contains(recipeId)) {
      favoritesSet.remove(recipeId);
    } else {
      favoritesSet.add(recipeId);
    }

    await _cache.setFavorites(favoritesSet.toList());
    _favoritesStreamController.add(favoritesSet);

    try {
      await _firestoreService.toggleFavorite(recipeId);
    } catch (_) {
      await _cache.setNeedsSync(true);
    }
  }

  static Future<bool> isFavorite(String recipeId) async {
    final favorites = await _cache.getFavorites();
    return favorites.contains(recipeId);
  }

  static Future<void> clearAllFavorites() async {
    await _cache.removeFavorites();
    _favoritesStreamController.add(<String>{});

    try {
      final favorites = await _firestoreService.getUserFavorites();
      for (final id in favorites) {
        await _firestoreService.removeFromFavorites(id);
      }
    } catch (_) {}
  }

  static Future<int> getFavoritesCount() async {
    final favorites = await _cache.getFavorites();
    return favorites.length;
  }

  static Future<bool> hasFavorites() async {
    final favorites = await _cache.getFavorites();
    return favorites.isNotEmpty;
  }

  static Future<void> checkAndSync() async {
    if (!await _cache.needsSync()) return;
    try {
      final favorites = await _cache.getFavorites();
      await _firestoreService.syncFavoritesWithFirestore(favorites.toSet());
      await _cache.setNeedsSync(false);
    } catch (_) {}
  }

  static void dispose() {
    _favoritesStreamController.close();
  }
}
