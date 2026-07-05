import 'package:nutrizham/data/models/meal_plan_entry.dart';
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
    super.mealPlans = const {},
    super.dailyCalories = 2000,
    super.dailyProtein = 150,
    super.dailyCarbs = 250,
    super.dailyFats = 65,
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
      'mealPlans': mealPlans.map((date, entries) =>
          MapEntry(date, entries.map((e) => e.toJson()).toList())),
      'dailyCalories': dailyCalories,
      'dailyProtein': dailyProtein,
      'dailyCarbs': dailyCarbs,
      'dailyFats': dailyFats,
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
      mealPlans: (json['mealPlans'] as Map<String, dynamic>?)
              ?.map((date, value) => MapEntry(
                    date,
                    (value as List)
                        .map((e) =>
                            MealPlanEntry.fromJson(e as Map<String, dynamic>))
                        .toList(),
                  )) ??
          {},
      dailyCalories: json['dailyCalories'] as int? ?? 2000,
      dailyProtein: (json['dailyProtein'] as num?)?.toDouble() ?? 150,
      dailyCarbs: (json['dailyCarbs'] as num?)?.toDouble() ?? 250,
      dailyFats: (json['dailyFats'] as num?)?.toDouble() ?? 65,
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
    Map<String, List<MealPlanEntry>>? mealPlans,
    int? dailyCalories,
    double? dailyProtein,
    double? dailyCarbs,
    double? dailyFats,
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
      mealPlans: mealPlans ?? this.mealPlans,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyProtein: dailyProtein ?? this.dailyProtein,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFats: dailyFats ?? this.dailyFats,
    );
  }
}
