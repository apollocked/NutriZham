// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _cache = CacheService();

  User? get currentFirebaseUser => _auth.currentUser;

  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return _getUserFromFirestore(user.uid);
    });
  }

  Future<Map<String, dynamic>> registerWithEmail({
    required String email,
    required String password,
    required String username,
    required int age,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(username);

      final userModel = UserModel(
        id: credential.user!.uid,
        username: username,
        email: email,
        age: age,
        profileImage: null,
        createdAt: DateTime.now(),
        favorites: [],
        plannedMeals: [],
      );

      await _firestore.collection('users').doc(credential.user!.uid).set(userModel.toJson());
      await _cache.setIsLoggedIn(true);
      await _cache.setCurrentUserJson(json.encode(userModel.toJson()));
      await _cache.setFavorites([]);
      await _cache.setPlannedMeals([]);

      return {'success': true, 'message': 'Registration successful', 'user': userModel};
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already registered';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = 'Registration failed: ${e.message}';
      }
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('FirebaseAuthService.registerWithEmail: $e');
      return {'success': false, 'message': 'An unexpected error occurred. Please try again.'};
    }
  }

  Future<Map<String, dynamic>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel? userModel = await _getUserFromFirestore(credential.user!.uid);

      if (userModel == null) {
        userModel = UserModel(
          id: credential.user!.uid,
          username: credential.user!.displayName ?? credential.user!.email!.split('@')[0],
          email: credential.user!.email!,
          age: 20,
          profileImage: credential.user!.photoURL,
          createdAt: credential.user!.metadata.creationTime ?? DateTime.now(),
          favorites: [],
          plannedMeals: [],
        );
        await _firestore.collection('users').doc(credential.user!.uid).set(userModel.toJson());
      }

      await _cache.setIsLoggedIn(true);
      await _cache.setCurrentUserJson(json.encode(userModel.toJson()));
      await _cache.setFavorites(userModel.favorites);
      await _cache.setPlannedMeals(userModel.plannedMeals);

      return {'success': true, 'message': 'Login successful', 'user': userModel};
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'user-disabled':
          message = 'This account has been disabled';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password';
          break;
        case 'too-many-requests':
          message = 'Too many login attempts. Please try again later.';
          break;
        default:
          message = 'Login failed: ${e.message}';
      }
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('FirebaseAuthService.loginWithEmail: $e');
      return {'success': false, 'message': 'An unexpected error occurred. Please try again.'};
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _cache.clearAuth();
    } catch (e) {
      debugPrint('FirebaseAuthService.logout: $e');
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
      debugPrint('FirebaseAuthService._getUserFromFirestore: $e');
      return null;
    }
  }
}
