// ignore_for_file: avoid_print

import 'package:nutrizham/services/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();
// In AuthService class
  Future<void> testLoginFlow(String testEmail, String testPassword) async {
    print('=== TESTING LOGIN FLOW ===');

    // 1. Try to register
    print('1. Attempting registration...');
    final regResult = await register(
      username: 'testuser',
      email: testEmail,
      password: testPassword,
      age: 25,
    );
    print('Registration result: ${regResult['success']}');
    print('Registration message: ${regResult['message']}');

    if (regResult['success']) {
      // 2. Try to login immediately
      print('\n2. Attempting login...');
      final loginResult = await login(
        email: testEmail,
        password: testPassword,
      );
      print('Login result: ${loginResult['success']}');
      print('Login message: ${loginResult['message']}');

      // 3. Check login status
      print('\n3. Checking isLoggedIn...');
      final loggedIn = await isLoggedIn();
      print('isLoggedIn: $loggedIn');

      // 4. Get current user
      print('\n4. Getting current user...');
      final currentUser = await getCurrentUser();
      print('Current user: ${currentUser?.email}');
    }

    print('=== END TEST ===');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await _firebaseAuth.isLoggedIn();
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    return await _firebaseAuth.getCurrentUser();
  }

  // Register new user
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    return await _firebaseAuth.registerWithEmail(
      email: email,
      password: password,
      username: username,
      age: age,
    );
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.loginWithEmail(
      email: email,
      password: password,
    );
  }

  // Logout user
  Future<void> logout() async {
    await _firebaseAuth.logout();
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUser(UserModel updatedUser) async {
    return await _firebaseAuth.updateUserProfile(updatedUser);
  }

  // Delete account
  Future<Map<String, dynamic>> deleteAccount(String userId) async {
    return await _firebaseAuth.deleteAccount();
  }

  // NEW: Google Sign-In
  Future<Map<String, dynamic>> signInWithGoogle() async {
    return await _firebaseAuth.signInWithGoogle();
  }

  // NEW: Reset password
  Future<Map<String, dynamic>> resetPassword(String email) async {
    return await _firebaseAuth.resetPassword(email);
  }

  // NEW: Change password
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _firebaseAuth.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  // NEW: Get auth state stream
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges;
  }

  // NEW: Check if email exists (optional - needs Firestore query)
  Future<bool> emailExists(String email) async {
    try {
      // You need to implement this by querying Firestore
      // This is just a placeholder
      return false;
    } catch (e) {
      return false;
    }
  }

  // NEW: Check if username exists (optional - needs Firestore query)
  Future<bool> usernameExists(String username) async {
    try {
      // You need to implement this by querying Firestore
      // This is just a placeholder
      return false;
    } catch (e) {
      return false;
    }
  }

  // Keep this for testing/debugging if needed
  Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
    await prefs.setBool('is_logged_in', false);
    await _firebaseAuth.logout();
  }
}
