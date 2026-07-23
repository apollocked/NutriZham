import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class AccountService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CacheService _cache;

  AccountService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required CacheService cache,
  })  : _auth = auth,
        _firestore = firestore,
        _cache = cache;

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userModel = await _getUserFromFirestore(user.uid);
      if (userModel != null) {
        await _syncUserDataToLocal(userModel);
        return userModel;
      }

      final userJson = await _cache.getCurrentUserJson();
      if (userJson != null) {
        try {
          return UserModel.fromJson(Map<String, dynamic>.from(json.decode(userJson)));
        } catch (e) {
          debugPrint('AccountService.getCurrentUser.fromJson: $e');
        }
      }

      final newUser = UserModel(
        id: user.uid,
        username: user.displayName ?? user.email!.split('@')[0],
        email: user.email!,
        age: 20,
        profileImage: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        favorites: [],
        plannedMeals: [],
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
      await _syncUserDataToLocal(newUser);
      return newUser;
    } catch (e) {
      debugPrint('AccountService.getCurrentUser: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(UserModel updatedUser) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return {'success': false, 'message': 'No user logged in'};

      if (user.displayName != updatedUser.username) {
        await user.updateDisplayName(updatedUser.username);
      }
      if (user.email != updatedUser.email) {
        await user.verifyBeforeUpdateEmail(updatedUser.email);
      }

      final currentUser = await getCurrentUser();
      final userToSave = updatedUser.copyWith(
        favorites: currentUser?.favorites ?? updatedUser.favorites,
        plannedMeals: currentUser?.plannedMeals ?? updatedUser.plannedMeals,
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userToSave.toJson(), SetOptions(merge: true));
      await _cache.setCurrentUserJson(json.encode(userToSave.toJson()));

      return {'success': true, 'message': 'Profile updated successfully'};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': 'Failed to update profile: ${e.message}'};
    } catch (e) {
      debugPrint('AccountService.updateUserProfile: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return {'success': false, 'message': 'No user logged in'};

      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
      await _cache.clearAuth();
      await _cache.removeFavorites();
      await _cache.removePlannedMeals();

      return {'success': true, 'message': 'Account deleted successfully'};
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'requires-recent-login'
          ? 'Please re-authenticate to delete your account'
          : 'Failed to delete account: ${e.message}';
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('AccountService.deleteAccount: $e');
      return {'success': false, 'message': 'An unexpected error occurred'};
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;
      final userModel = await getCurrentUser();
      return userModel != null;
    } catch (e) {
      debugPrint('AccountService.isLoggedIn: $e');
      return false;
    }
  }

  Future<UserModel?> _getUserFromFirestore(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('AccountService._getUserFromFirestore: $e');
      return null;
    }
  }

  Future<void> _syncUserDataToLocal(UserModel userModel) async {
    try {
      await _cache.setFavorites(userModel.favorites);
      await _cache.setPlannedMeals(userModel.plannedMeals);
    } catch (e) {
      debugPrint('AccountService._syncUserDataToLocal: $e');
    }
  }
}
