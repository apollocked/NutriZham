// ignore_for_file: unused_element, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nutrizham/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current Firebase user
  User? get currentFirebaseUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return await _getUserFromFirestore(user.uid);
    });
  }

  // Email/Password Registration
  Future<Map<String, dynamic>> registerWithEmail({
    required String email,
    required String password,
    required String username,
    required int age,
  }) async {
    try {
      print('Starting registration for email: $email');

      // 1. Create user in Firebase Auth
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Firebase Auth user created: ${credential.user!.uid}');

      // 2. Update display name
      await credential.user!.updateDisplayName(username);
      print('Display name updated to: $username');

      // 3. Store user data in Firestore
      final userModel = UserModel(
        id: credential.user!.uid,
        username: username,
        email: email,
        age: age,
        profileImage: null,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userModel.toJson());

      print('Firestore user document created');

      // 4. Save to local storage for offline access
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user', json.encode(userModel.toJson()));

      print('Local storage updated');

      return {
        'success': true,
        'message': 'Registration successful',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      print(
          'FirebaseAuthException during registration: ${e.code} - ${e.message}');
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
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Unexpected registration error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
      };
    }
  }

  // Email/Password Login - FIXED VERSION
  Future<Map<String, dynamic>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('Starting login for email: $email');

      // 1. Sign in with Firebase Auth
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Login successful for user: ${credential.user!.uid}');

      // 2. Get user data from Firestore
      UserModel? userModel = await _getUserFromFirestore(credential.user!.uid);

      // 3. If user data doesn't exist in Firestore, create it
      if (userModel == null) {
        print('User document not found in Firestore. Creating now...');

        userModel = UserModel(
          id: credential.user!.uid,
          username: credential.user!.displayName ??
              credential.user!.email!.split('@')[0],
          email: credential.user!.email!,
          age: 20, // Default age
          profileImage: credential.user!.photoURL,
          createdAt: credential.user!.metadata.creationTime ?? DateTime.now(),
        );

        // Create the user document in Firestore
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toJson());

        print('User document created successfully');
      }

      // 4. Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user', json.encode(userModel.toJson()));

      print('Login completed successfully');

      return {
        'success': true,
        'message': 'Login successful',
        'user': userModel,
      };
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException during login: ${e.code} - ${e.message}');
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
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Unexpected login error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
      };
    }
  }

  // Google Sign-In
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      print('Starting Google Sign-In');

      // 1. Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in cancelled by user');
        return {
          'success': false,
          'message': 'Google sign-in cancelled',
        };
      }

      print('Google user selected: ${googleUser.email}');

      // 2. Get Google authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print('Firebase auth successful: ${userCredential.user!.uid}');

      // 5. Check if user exists in Firestore, if not create
      UserModel userModel;
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        print('Creating new Firestore document for Google user');
        // New user - create in Firestore
        userModel = UserModel(
          id: userCredential.user!.uid,
          username: googleUser.displayName ?? googleUser.email.split('@')[0],
          email: googleUser.email,
          age: 20, // Default age
          profileImage: googleUser.photoUrl,
          createdAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
      } else {
        print('Loading existing Firestore document');
        // Existing user - get from Firestore
        userModel = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }

      // 6. Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user', json.encode(userModel.toJson()));

      print('Google sign-in completed successfully');

      return {
        'success': true,
        'message': 'Google sign-in successful',
        'user': userModel,
      };
    } catch (e) {
      print('Google sign-in error: $e');
      return {
        'success': false,
        'message': 'Google sign-in failed. Please try again.',
      };
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);
      await prefs.remove('current_user');

      print('Logout successful');
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    try {
      // 1. Check if user is authenticated in Firebase
      final user = _auth.currentUser;
      if (user == null) {
        print('No Firebase user authenticated');
        return null;
      }

      print('Getting current user: ${user.uid}');

      // 2. Try to get from local storage first (for offline access)
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');

      if (userJson != null) {
        try {
          final userData = Map<String, dynamic>.from(json.decode(userJson));
          return UserModel.fromJson(userData);
        } catch (e) {
          print("Error parsing stored user: $e");
        }
      }

      // 3. Get from Firestore
      final userModel = await _getUserFromFirestore(user.uid);

      // 4. If Firestore data doesn't exist, create it
      if (userModel == null) {
        print('Creating missing user document for: ${user.uid}');

        final newUser = UserModel(
          id: user.uid,
          username: user.displayName ?? user.email!.split('@')[0],
          email: user.email!,
          age: 20,
          profileImage: user.photoURL,
          createdAt: user.metadata.creationTime ?? DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toJson());
        await prefs.setString('current_user', json.encode(newUser.toJson()));

        return newUser;
      }

      return userModel;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile(UserModel updatedUser) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'No user logged in',
        };
      }

      print('Updating profile for user: ${user.uid}');

      // 1. Update Firebase Auth profile
      if (user.displayName != updatedUser.username) {
        await user.updateDisplayName(updatedUser.username);
      }

      if (user.email != updatedUser.email) {
        await user.verifyBeforeUpdateEmail(updatedUser.email);
      }

      // 2. Update in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'username': updatedUser.username,
        'email': updatedUser.email,
        'age': updatedUser.age,
        'profileImage': updatedUser.profileImage,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      // 3. Update local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', json.encode(updatedUser.toJson()));

      print('Profile updated successfully');

      return {
        'success': true,
        'message': 'Profile updated successfully',
      };
    } on FirebaseAuthException catch (e) {
      print('Update profile error: ${e.code} - ${e.message}');
      return {
        'success': false,
        'message': 'Failed to update profile: ${e.message}',
      };
    } catch (e) {
      print('Update profile error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

  // Delete account
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'message': 'No user logged in',
        };
      }

      print('Deleting account for user: ${user.uid}');

      // 1. Delete from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // 2. Delete from Firebase Auth
      await user.delete();

      // 3. Clear local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_user');
      await prefs.setBool('is_logged_in', false);

      print('Account deleted successfully');

      return {
        'success': true,
        'message': 'Account deleted successfully',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'requires-recent-login':
          message = 'Please re-authenticate to delete your account';
          break;
        default:
          message = 'Failed to delete account: ${e.message}';
      }
      print('Delete account error: ${e.code} - $message');
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Delete account error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

  // Reset password
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      print('Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent successfully');
      return {
        'success': true,
        'message': 'Password reset email sent. Please check your inbox.',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        default:
          message = 'Failed to send reset email: ${e.message}';
      }
      print('Reset password error: ${e.code} - $message');
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Reset password error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

  // Change password (requires re-authentication)
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        return {
          'success': false,
          'message': 'No user logged in',
        };
      }

      print('Changing password for user: ${user.uid}');

      // Re-authenticate user
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      print('Password changed successfully');

      return {
        'success': true,
        'message': 'Password updated successfully',
      };
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'wrong-password':
          message = 'Current password is incorrect';
          break;
        case 'weak-password':
          message = 'New password is too weak';
          break;
        case 'requires-recent-login':
          message = 'Please log in again to change password';
          break;
        default:
          message = 'Failed to change password: ${e.message}';
      }
      print('Change password error: ${e.code} - $message');
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Change password error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred',
      };
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      // Verify user still exists in Firestore
      final userModel = await getCurrentUser();
      return userModel != null;
    } catch (e) {
      print('Is logged in check error: $e');
      return false;
    }
  }

  // Get user from Firestore - FIXED VERSION
  Future<UserModel?> _getUserFromFirestore(String uid) async {
    try {
      print('Fetching user from Firestore: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        print('User data retrieved from Firestore');
        return UserModel.fromJson(data);
      }

      print('User document does not exist for uid: $uid');
      return null;
    } catch (e) {
      print("Error getting user from Firestore: $e");
      return null;
    }
  }
}
