import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class GoogleAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final CacheService _cache;

  GoogleAuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    GoogleSignIn? googleSignIn,
    required CacheService cache,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _cache = cache;

  Future<Map<String, dynamic>> signInWithGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'success': false, 'message': 'Google sign-in cancelled'};
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return {
          'success': false,
          'message': 'An account already exists with ${e.email ?? googleUser?.email ?? ''}. Please sign in with email and password instead.',
        };
      }
      return {'success': false, 'message': 'Google sign-in failed. Please try again.'};
    } catch (_) {
      return {'success': false, 'message': 'Google sign-in failed. Please try again.'};
    }
  }
}
