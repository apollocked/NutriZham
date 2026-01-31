import 'package:nutrizham/models/user_model.dart';

class UserData {
  static final List<Map<String, dynamic>> demoUsers = [
    {
      'id': '1',
      'username': 'demo_user',
      'email': 'demo@nutrizham.com',
      'password': 'password123', // In production, use proper hashing
      'age': 25,
      'profileImage': null,
      'createdAt': DateTime.now().toIso8601String(),
    },
  ];

  static UserModel getDemoUser() {
    final userData = demoUsers.first;
    return UserModel(
      id: userData['id'] as String,
      username: userData['username'] as String,
      email: userData['email'] as String,
      age: userData['age'] as int,
      profileImage: userData['profileImage'] as String?,
      createdAt: DateTime.parse(userData['createdAt'] as String),
    );
  }
}