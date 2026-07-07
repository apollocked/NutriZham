import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/data/datasources/Auth_Services/google_auth_service.dart';
import 'package:nutrizham/data/datasources/Auth_Services/account_service.dart';
import 'package:nutrizham/data/datasources/Auth_Services/password_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class AuthService {
  final FirebaseAuthService _emailAuth = FirebaseAuthService();
  final GoogleAuthService _googleAuth = GoogleAuthService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    cache: CacheService(),
  );
  final AccountService _account = AccountService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    cache: CacheService(),
  );
  final PasswordService _password = PasswordService(auth: FirebaseAuth.instance);

  Future<bool> isLoggedIn() => _account.isLoggedIn();
  Future<UserModel?> getCurrentUser() => _account.getCurrentUser();

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) => _emailAuth.registerWithEmail(username: username, email: email, password: password, age: age);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) => _emailAuth.loginWithEmail(email: email, password: password);

  Future<void> logout() => _emailAuth.logout();
  Future<Map<String, dynamic>> updateUser(UserModel updatedUser) => _account.updateUserProfile(updatedUser);
  Future<Map<String, dynamic>> deleteAccount(String userId) => _account.deleteAccount();
  Future<Map<String, dynamic>> signInWithGoogle() => _googleAuth.signInWithGoogle();
  Future<Map<String, dynamic>> resetPassword(String email) => _password.resetPassword(email);

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => _password.changePassword(currentPassword: currentPassword, newPassword: newPassword);

  Stream<UserModel?> get authStateChanges => _emailAuth.authStateChanges;

  Future<bool> emailExists(String email) async => false;
  Future<bool> usernameExists(String username) async => false;

  Future<void> clearAllUserData() async {
    await CacheService().clearAuth();
    await _emailAuth.logout();
  }
}
