import 'package:flutter/material.dart';
import 'package:nutrizham/models/user_model.dart';
import 'package:nutrizham/services/Auth_Services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.login(email: email, password: password);

    if (result['success']) {
      _currentUser = result['user'] as UserModel?;
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.register(
      username: username,
      email: email,
      password: password,
      age: age,
    );

    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<Map<String, dynamic>> updateProfile(UserModel updatedUser) async {
    return await _authService.updateUser(updatedUser);
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    final result = await _authService.deleteAccount(_currentUser?.id ?? '');
    if (result['success']) {
      _currentUser = null;
      notifyListeners();
    }
    return result;
  }

  Future<void> loadCurrentUser() async {
    _currentUser = await _authService.getCurrentUser();
    notifyListeners();
  }

  Future<Map<String, dynamic>> validatePassword(String password) async {
    return await _authService.changePassword(
      currentPassword: password,
      newPassword: password,
    );
  }
}
