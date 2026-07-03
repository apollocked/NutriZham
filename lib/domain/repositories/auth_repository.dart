import 'package:nutrizham/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<User?> getCurrentUser();
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  });
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<Map<String, dynamic>> updateUser(User updatedUser);
  Future<Map<String, dynamic>> deleteAccount(String userId);
  Future<Map<String, dynamic>> signInWithGoogle();
  Future<Map<String, dynamic>> resetPassword(String email);
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
