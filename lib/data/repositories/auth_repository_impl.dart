import 'package:nutrizham/domain/entities/user.dart';
import 'package:nutrizham/domain/repositories/auth_repository.dart';
import 'package:nutrizham/data/datasources/Auth_Services/auth_service.dart';
import 'package:nutrizham/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService();

  @override
  Future<bool> isLoggedIn() => _authService.isLoggedIn();

  @override
  Future<User?> getCurrentUser() async {
    final model = await _authService.getCurrentUser();
    return model;
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final result = await _authService.login(email: email, password: password);
    return result;
  }

  @override
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    return await _authService.register(
      username: username,
      email: email,
      password: password,
      age: age,
    );
  }

  @override
  Future<void> logout() => _authService.logout();

  @override
  Future<Map<String, dynamic>> updateUser(User updatedUser) async {
    final model = UserModel(
      id: updatedUser.id,
      username: updatedUser.username,
      email: updatedUser.email,
      age: updatedUser.age,
      profileImage: updatedUser.profileImage,
      createdAt: updatedUser.createdAt,
      favorites: updatedUser.favorites,
      plannedMeals: updatedUser.plannedMeals,
      updatedAt: updatedUser.updatedAt,
    );
    return await _authService.updateUser(model);
  }

  @override
  Future<Map<String, dynamic>> deleteAccount(String userId) =>
      _authService.deleteAccount(userId);

  @override
  Future<Map<String, dynamic>> signInWithGoogle() =>
      _authService.signInWithGoogle();

  @override
  Future<Map<String, dynamic>> resetPassword(String email) =>
      _authService.resetPassword(email);

  @override
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) =>
      _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
}
