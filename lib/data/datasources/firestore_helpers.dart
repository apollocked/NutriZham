import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelpers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> _getUserDoc(String userId) =>
      _firestore.collection('users').doc(userId);


  // ============ FAVORITES ============

  Future<void> addToFavorites(String recipeId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    try {
      await _getUserDoc(userId).update({
        'favorites': FieldValue.arrayUnion([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error adding to favorites: $e');
      rethrow;
    }
  }

  Future<void> removeFromFavorites(String recipeId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    try {
      await _getUserDoc(userId).update({
        'favorites': FieldValue.arrayRemove([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error removing from favorites: $e');
      rethrow;
    }
  }

  Future<List<String>> getUserFavorites() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];
    try {
      final doc = await _getUserDoc(userId).get();
      if (doc.exists) {
        return List<String>.from(doc.data()!['favorites'] ?? []);
      }
      return [];
    } catch (e) {
      debugPrint('Error getting favorites: $e');
      return [];
    }
  }

  Future<void> toggleFavorite(String recipeId) async {
    final favorites = await getUserFavorites();
    if (favorites.contains(recipeId)) {
      await removeFromFavorites(recipeId);
    } else {
      await addToFavorites(recipeId);
    }
  }

  // ============ SYNC ============

  Future<void> syncFavoritesWithFirestore(Set<String> localFavorites) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    try {
      final firestoreFavorites = await getUserFavorites();
      final toAdd = localFavorites.difference(firestoreFavorites.toSet());
      if (toAdd.isNotEmpty) {
        await _getUserDoc(userId).update({
          'favorites': FieldValue.arrayUnion(toAdd.toList()),
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      debugPrint('Error syncing favorites: $e');
    }
  }

  Future<void> syncMealPlansWithFirestore(
      Map<String, dynamic> localMealPlans) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    try {
      final doc = await _getUserDoc(userId).get();
      final firestorePlans =
          Map<String, dynamic>.from(doc.data()?['mealPlans'] ?? {});
      final merged = Map<String, dynamic>.from(firestorePlans);
      localMealPlans.forEach((date, entries) {
        if (!merged.containsKey(date)) {
          merged[date] = entries;
        }
      });
      await _getUserDoc(userId).update({
        'mealPlans': merged,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error syncing meal plans: $e');
    }
  }
}
