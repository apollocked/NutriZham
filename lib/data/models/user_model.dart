import 'package:nutrizham/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.age,
    super.profileImage,
    required super.createdAt,
    super.favorites = const [],
    super.plannedMeals = const [],
    super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'age': age,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'favorites': favorites,
      'plannedMeals': plannedMeals,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      favorites: List<String>.from(json['favorites'] ?? []),
      plannedMeals: List<String>.from(json['plannedMeals'] ?? []),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    int? age,
    String? profileImage,
    DateTime? createdAt,
    List<String>? favorites,
    List<String>? plannedMeals,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      age: age ?? this.age,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      favorites: favorites ?? this.favorites,
      plannedMeals: plannedMeals ?? this.plannedMeals,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
