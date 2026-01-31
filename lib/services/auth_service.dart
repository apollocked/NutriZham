import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'registered_users';
  static const String _isLoggedInKey = 'is_logged_in';

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  // Register new user
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required int age,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get existing users
    final usersJson = prefs.getString(_usersKey);
    List<Map<String, dynamic>> users = [];
    if (usersJson != null) {
      users = List<Map<String, dynamic>>.from(json.decode(usersJson));
    }
    
    // Check if email already exists
    if (users.any((user) => user['email'] == email)) {
      return {
        'success': false,
        'message': 'Email already registered',
      };
    }
    
    // Check if username already exists
    if (users.any((user) => user['username'] == username)) {
      return {
        'success': false,
        'message': 'Username already taken',
      };
    }
    
    // Create new user
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      email: email,
      age: age,
      createdAt: DateTime.now(),
    );
    
    // Store password separately (in real app, use proper encryption)
    final userWithPassword = {
      ...newUser.toJson(),
      'password': password, // In production, hash this!
    };
    
    users.add(userWithPassword);
    await prefs.setString(_usersKey, json.encode(users));
    
    return {
      'success': true,
      'message': 'Registration successful',
      'user': newUser,
    };
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get existing users
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) {
      return {
        'success': false,
        'message': 'No registered users found',
      };
    }
    
    final users = List<Map<String, dynamic>>.from(json.decode(usersJson));
    
    // Find user with matching email and password
    final user = users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );
    
    if (user.isEmpty) {
      return {
        'success': false,
        'message': 'Invalid email or password',
      };
    }
    
    // Remove password from user data
    final userData = Map<String, dynamic>.from(user);
    userData.remove('password');
    
    final loggedInUser = UserModel.fromJson(userData);
    
    // Save current user
    await prefs.setString(_userKey, json.encode(loggedInUser.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
    
    return {
      'success': true,
      'message': 'Login successful',
      'user': loggedInUser,
    };
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Update user profile
  Future<bool> updateUser(UserModel updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Update current user
    await prefs.setString(_userKey, json.encode(updatedUser.toJson()));
    
    // Update in users list
    final usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      final users = List<Map<String, dynamic>>.from(json.decode(usersJson));
      final index = users.indexWhere((user) => user['id'] == updatedUser.id);
      
      if (index != -1) {
        users[index] = {
          ...updatedUser.toJson(),
          'password': users[index]['password'], // Keep existing password
        };
        await prefs.setString(_usersKey, json.encode(users));
      }
    }
    
    return true;
  }

  // Delete account
  Future<bool> deleteAccount(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Remove from users list
    final usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      final users = List<Map<String, dynamic>>.from(json.decode(usersJson));
      users.removeWhere((user) => user['id'] == userId);
      await prefs.setString(_usersKey, json.encode(users));
    }
    
    // Logout
    await logout();
    
    return true;
  }
}
