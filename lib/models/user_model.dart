class UserModel {
  final String id;
  final String username;
  final String email;
  final int age;
  final String? profileImage;
  final DateTime createdAt;
  final List<String> favorites;
  final List<String> plannedMeals;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.age,
    this.profileImage,
    required this.createdAt,
    this.favorites = const [],
    this.plannedMeals = const [],
    this.updatedAt,
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
