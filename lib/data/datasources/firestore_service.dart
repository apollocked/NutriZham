// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrizham/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String usersCollection = 'users';

  String? get currentUserId => _auth.currentUser?.uid;

  DocumentReference<Map<String, dynamic>> _getUserDoc(String userId) =>
      _firestore.collection(usersCollection).doc(userId);

  DocumentReference<Map<String, dynamic>>? get _currentUserDoc {
    final userId = currentUserId;
    return userId != null ? _getUserDoc(userId) : null;
  }

  // ============ USER OPERATIONS ============

  Future<void> saveUserData(UserModel user) async {
    try {
      await _getUserDoc(user.id).set(user.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _getUserDoc(userId).get();
      if (doc.exists) return UserModel.fromJson(doc.data()!);
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<UserModel?> getCurrentUserFromFirestore() async {
    final userId = currentUserId;
    if (userId == null) return null;
    return await getUserById(userId);
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await _getUserDoc(user.id).update({
        'username': user.username,
        'email': user.email,
        'age': user.age,
        'profileImage': user.profileImage,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  // ============ MEAL PLANS ============

  Future<Map<String, dynamic>> getMealPlans() async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return {};
    try {
      final doc = await userDoc.get();
      if (doc.exists) {
        return Map<String, dynamic>.from(doc.data()!['mealPlans'] ?? {});
      }
      return {};
    } catch (e) {
      print('Error getting meal plans: $e');
      return {};
    }
  }

  Future<void> setMealPlans(Map<String, dynamic> mealPlans) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;
    try {
      await userDoc.update({
        'mealPlans': mealPlans,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error setting meal plans: $e');
      rethrow;
    }
  }

  Future<void> updateNutritionGoals({
    required int calories,
    required double protein,
    required double carbs,
    required double fats,
  }) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;
    try {
      await userDoc.update({
        'dailyCalories': calories,
        'dailyProtein': protein,
        'dailyCarbs': carbs,
        'dailyFats': fats,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error updating nutrition goals: $e');
      rethrow;
    }
  }

  // ============ SYNC ============

  Future<void> syncMealPlansWithFirestore(
      Map<String, dynamic> localMealPlans) async {
    final userDoc = _currentUserDoc;
    if (userDoc == null) return;
    try {
      final doc = await userDoc.get();
      final firestorePlans =
          Map<String, dynamic>.from(doc.data()?['mealPlans'] ?? {});
      final merged = Map<String, dynamic>.from(firestorePlans);
      localMealPlans.forEach((date, entries) {
        if (!merged.containsKey(date)) merged[date] = entries;
      });
      await userDoc.update({
        'mealPlans': merged,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error syncing meal plans: $e');
    }
  }

  // ============ ACCOUNT ============

  Future<void> deleteUserData(String userId) async {
    try {
      await _getUserDoc(userId).delete();
    } catch (e) {
      print('Error deleting user data: $e');
      rethrow;
    }
  }

  Stream<UserModel?> streamUserData(String userId) {
    return _getUserDoc(userId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }
}
