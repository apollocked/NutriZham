// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrizham/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Users Collection
  static const String usersCollection = 'users';

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // ============ USER OPERATIONS ============

  // Get user document reference
  DocumentReference<Map<String, dynamic>> _getUserDoc(String userId) {
    return _firestore.collection(usersCollection).doc(userId);
  }

  // Get current user document reference
  DocumentReference<Map<String, dynamic>>? get _currentUserDoc {
    final userId = currentUserId;
    return userId != null ? _getUserDoc(userId) : null;
  }

  // Save/update user data
  Future<void> saveUserData(UserModel user) async {
    try {
      await _getUserDoc(user.id).set(user.toJson(), SetOptions(merge: true));
      print('User data saved successfully for ${user.email}');
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _getUserDoc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Get current user from Firestore
  Future<UserModel?> getCurrentUserFromFirestore() async {
    final userId = currentUserId;
    if (userId == null) return null;
    return await getUserById(userId);
  }

  // Update user profile
  Future<void> updateUserProfile(UserModel user) async {
    try {
      await _getUserDoc(user.id).update({
        'username': user.username,
        'email': user.email,
        'age': user.age,
        'profileImage': user.profileImage,
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('User profile updated successfully');
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  // ============ FAVORITES OPERATIONS ============

  // Add recipe to favorites
  Future<void> addToFavorites(String recipeId) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      await userDoc.update({
        'favorites': FieldValue.arrayUnion([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('Added recipe $recipeId to favorites');
    } catch (e) {
      print('Error adding to favorites: $e');
      rethrow;
    }
  }

  // Remove recipe from favorites
  Future<void> removeFromFavorites(String recipeId) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      await userDoc.update({
        'favorites': FieldValue.arrayRemove([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('Removed recipe $recipeId from favorites');
    } catch (e) {
      print('Error removing from favorites: $e');
      rethrow;
    }
  }

  // Get user favorites
  Future<List<String>> getUserFavorites() async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return [];

    try {
      final doc = await userDoc.get();
      if (doc.exists) {
        final data = doc.data()!;
        return List<String>.from(data['favorites'] ?? []);
      }
      return [];
    } catch (e) {
      print('Error getting favorites: $e');
      return [];
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String recipeId) async {
    final favorites = await getUserFavorites();
    if (favorites.contains(recipeId)) {
      await removeFromFavorites(recipeId);
    } else {
      await addToFavorites(recipeId);
    }
  }

  // ============ PLANNED MEALS OPERATIONS ============

  // Add meal to plan
  Future<void> addMealToPlan(String recipeId) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      await userDoc.update({
        'plannedMeals': FieldValue.arrayUnion([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('Added recipe $recipeId to planned meals');
    } catch (e) {
      print('Error adding to planned meals: $e');
      rethrow;
    }
  }

  // Remove meal from plan
  Future<void> removeMealFromPlan(String recipeId) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      await userDoc.update({
        'plannedMeals': FieldValue.arrayRemove([recipeId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('Removed recipe $recipeId from planned meals');
    } catch (e) {
      print('Error removing from planned meals: $e');
      rethrow;
    }
  }

  // Get user planned meals
  Future<List<String>> getUserPlannedMeals() async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return [];

    try {
      final doc = await userDoc.get();
      if (doc.exists) {
        final data = doc.data()!;
        return List<String>.from(data['plannedMeals'] ?? []);
      }
      return [];
    } catch (e) {
      print('Error getting planned meals: $e');
      return [];
    }
  }

  // Toggle planned meal
  Future<void> togglePlannedMeal(String recipeId) async {
    final plannedMeals = await getUserPlannedMeals();
    if (plannedMeals.contains(recipeId)) {
      await removeMealFromPlan(recipeId);
    } else {
      await addMealToPlan(recipeId);
    }
  }

  // ============ SYNC LOCAL DATA WITH FIRESTORE ============

  // Sync local favorites with Firestore
  Future<void> syncFavoritesWithFirestore(Set<String> localFavorites) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      // Get current favorites from Firestore
      final firestoreFavorites = await getUserFavorites();
      final firestoreSet = firestoreFavorites.toSet();

      // Merge: add any local favorites not in Firestore
      final toAdd = localFavorites.difference(firestoreSet);
      if (toAdd.isNotEmpty) {
        await userDoc.update({
          'favorites': FieldValue.arrayUnion(toAdd.toList()),
          'updatedAt': DateTime.now().toIso8601String(),
        });
        print('Synced ${toAdd.length} favorites to Firestore');
      }
    } catch (e) {
      print('Error syncing favorites: $e');
    }
  }

  // Sync local planned meals with Firestore
  Future<void> syncPlannedMealsWithFirestore(
      List<String> localPlannedMeals) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;

    try {
      // Get current planned meals from Firestore
      final firestorePlannedMeals = await getUserPlannedMeals();
      final firestoreSet = firestorePlannedMeals.toSet();
      final localSet = localPlannedMeals.toSet();

      // Merge: add any local planned meals not in Firestore
      final toAdd = localSet.difference(firestoreSet);
      if (toAdd.isNotEmpty) {
        await userDoc.update({
          'plannedMeals': FieldValue.arrayUnion(toAdd.toList()),
          'updatedAt': DateTime.now().toIso8601String(),
        });
        print('Synced ${toAdd.length} planned meals to Firestore');
      }
    } catch (e) {
      print('Error syncing planned meals: $e');
    }
  }

  // Delete user account data
  Future<void> deleteUserData(String userId) async {
    try {
      await _getUserDoc(userId).delete();
      print('User data deleted successfully');
    } catch (e) {
      print('Error deleting user data: $e');
      rethrow;
    }
  }

  // Stream user data changes
  Stream<UserModel?> streamUserData(String userId) {
    return _getUserDoc(userId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }
}
