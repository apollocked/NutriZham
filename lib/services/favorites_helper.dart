// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:nutrizham/services/firestore_service.dart';

class FavoritesHelper {
  static final StreamController<Set<String>> _favoritesStreamController =
      StreamController<Set<String>>.broadcast();
  static final FirestoreService _firestoreService = FirestoreService();

  static Stream<Set<String>> get favoritesStream =>
      _favoritesStreamController.stream;

  static Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    final favoritesSet = favorites.toSet();

    // Try to sync with Firestore
    try {
      final firestoreFavorites = await _firestoreService.getUserFavorites();
      final firestoreSet = firestoreFavorites.toSet();

      // Merge: use Firestore data if available, otherwise use local
      if (firestoreSet.isNotEmpty) {
        await prefs.setStringList('favorites', firestoreSet.toList());
        _favoritesStreamController.add(firestoreSet);
        return firestoreSet;
      } else if (favoritesSet.isNotEmpty) {
        // Sync local to Firestore
        await _firestoreService.syncFavoritesWithFirestore(favoritesSet);
      }
    } catch (e) {
      print('Error syncing favorites: $e');
      // Continue with local data if Firestore fails
    }

    _favoritesStreamController.add(favoritesSet);
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
    _favoritesStreamController.add(favoritesSet);

    // Sync with Firestore
    try {
      await _firestoreService.toggleFavorite(recipeId);
    } catch (e) {
      print('Error syncing toggle favorite to Firestore: $e');
      // Save to sync later
      await _scheduleSync();
    }
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

    // Clear from Firestore
    try {
      final firestoreService = FirestoreService();
      final favorites = await firestoreService.getUserFavorites();
      for (final recipeId in favorites) {
        await firestoreService.removeFromFavorites(recipeId);
      }
    } catch (e) {
      print('Error clearing favorites from Firestore: $e');
    }
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

  // Schedule sync for later if offline
  static Future<void> _scheduleSync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('needs_sync', true);
  }

  // Check and perform pending sync
  static Future<void> checkAndSync() async {
    final prefs = await SharedPreferences.getInstance();
    final needsSync = prefs.getBool('needs_sync') ?? false;

    if (needsSync) {
      try {
        final favorites = prefs.getStringList('favorites') ?? [];
        await _firestoreService.syncFavoritesWithFirestore(favorites.toSet());
        await prefs.setBool('needs_sync', false);
      } catch (e) {
        print('Error during scheduled sync: $e');
      }
    }
  }

  static void dispose() {
    _favoritesStreamController.close();
  }
}
