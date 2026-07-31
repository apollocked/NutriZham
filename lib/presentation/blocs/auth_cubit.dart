import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/user_model.dart';
import 'package:nutrizham/data/datasources/Auth_Services/auth_service.dart';
import 'package:nutrizham/core/cache/cache_service.dart';

sealed class AuthState {
  const AuthState();
}
class AuthInitial extends AuthState {
  const AuthInitial();
}
class AuthLoading extends AuthState {
  const AuthLoading();
}
class AuthAuthenticated extends AuthState {
  final UserModel user;
  const AuthAuthenticated(this.user);
}
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final _authService = AuthService();

  AuthCubit() : super(const AuthInitial());

  UserModel? get currentUser {
    final s = state;
    return s is AuthAuthenticated ? s.user : null;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _authService.login(email: email, password: password);
    if (result['success']) {
      emit(AuthAuthenticated(result['user'] as UserModel));
    } else {
      emit(AuthError(result['message'] as String? ?? 'Login failed'));
    }
    return result;
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    emit(const AuthLoading());
    final result = await _authService.register(
      username: username, email: email, password: password, age: age,
    );
    if (result['success']) {
      emit(AuthAuthenticated(result['user'] as UserModel));
    } else {
      emit(AuthError(result['message'] as String? ?? 'Registration failed'));
    }
    return result;
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await _authService.logout();
    } finally {
      emit(const AuthUnauthenticated());
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      return await _authService.resetPassword(email);
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      return await _authService.changePassword(
        currentPassword: currentPassword, newPassword: newPassword,
      );
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateProfile(UserModel updatedUser) async {
    try {
      final result = await _authService.updateUser(updatedUser);
      if (result['success'] == true) {
        final user = await _authService.getCurrentUser();
        if (user != null) emit(AuthAuthenticated(user));
      }
      return result;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final result = await _authService.deleteAccount(currentUser?.id ?? '');
      if (result['success']) {
        emit(const AuthUnauthenticated());
      }
      return result;
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    emit(const AuthLoading());
    final result = await _authService.signInWithGoogle();
    if (result['success']) {
      emit(AuthAuthenticated(result['user'] as UserModel));
    } else {
      emit(AuthError(result['message'] as String? ?? 'Google sign-in failed'));
    }
    return result;
  }

  Future<void> loadCurrentUser() async {
    final cache = CacheService();
    final userJson = await cache.getCurrentUserJson();
    if (userJson != null) {
      try {
        final cachedUser = UserModel.fromJson(
          Map<String, dynamic>.from(json.decode(userJson)),
        );
        emit(AuthAuthenticated(cachedUser));
      } catch (e) {
        debugPrint('AuthCubit.loadCurrentUser.cachedUser: $e');
      }
    }
    final user = await _authService.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else if (state is! AuthAuthenticated) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<Map<String, dynamic>> validatePassword(String password) async {
    try {
      return await _authService.changePassword(
        currentPassword: password, newPassword: password,
      );
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
