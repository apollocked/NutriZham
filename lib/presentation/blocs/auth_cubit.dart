import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/user_model.dart';
import 'package:nutrizham/data/datasources/Auth_Services/auth_service.dart';

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
    await _authService.logout();
    emit(const AuthUnauthenticated());
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    return await _authService.resetPassword(email);
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _authService.changePassword(
      currentPassword: currentPassword, newPassword: newPassword,
    );
  }

  Future<Map<String, dynamic>> updateProfile(UserModel updatedUser) async {
    return await _authService.updateUser(updatedUser);
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    final result = await _authService.deleteAccount(currentUser?.id ?? '');
    if (result['success']) {
      emit(const AuthUnauthenticated());
    }
    return result;
  }

  Future<void> loadCurrentUser() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<Map<String, dynamic>> validatePassword(String password) async {
    return await _authService.changePassword(
      currentPassword: password, newPassword: password,
    );
  }
}
