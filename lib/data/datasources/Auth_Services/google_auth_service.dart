import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class GoogleAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final CacheService _cache;
  bool _initialized = false;

  GoogleAuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required CacheService cache,
  })  : _auth = auth,
        _firestore = firestore,
        _cache = cache;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await GoogleSignIn.instance.initialize();
      _initialized = true;
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      await _ensureInitialized();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final authData = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: authData.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel userModel;
      if (!userDoc.exists) {
        userModel = UserModel(
          id: userCredential.user!.uid,
          username: googleUser.displayName ?? googleUser.email.split('@')[0],
          email: googleUser.email,
          age: 20,
          profileImage: googleUser.photoUrl,
          createdAt: DateTime.now(),
          favorites: [],
          plannedMeals: [],
        );
        await _firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toJson());
      } else {
        userModel = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }

      await _cache.setIsLoggedIn(true);
      await _cache.setCurrentUserJson(json.encode(userModel.toJson()));
      await _cache.setFavorites(userModel.favorites);
      await _cache.setPlannedMeals(userModel.plannedMeals);

      return {'success': true, 'message': 'Google sign-in successful', 'user': userModel};
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return {'success': false, 'message': 'Google sign-in cancelled'};
      }
      return {'success': false, 'message': 'Google sign-in failed. Please try again.'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return {
          'success': false,
          'message': 'An account already exists with this email. Please sign in with email and password instead.',
        };
      }
      return {'success': false, 'message': 'Google sign-in failed. Please try again.'};
    } catch (_) {
      return {'success': false, 'message': 'Google sign-in failed. Please try again.'};
    }
  }

  Future<void> signOut() => GoogleSignIn.instance.signOut();

  Future<void> disconnect() => GoogleSignIn.instance.disconnect();
}
