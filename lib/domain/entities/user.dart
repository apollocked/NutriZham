import 'package:nutrizham/data/models/meal_plan_entry.dart';

class User {
  final String id;
  final String username;
  final String email;
  final int age;
  final String? profileImage;
  final DateTime createdAt;
  final List<String> favorites;
  final List<String> plannedMeals;
  final DateTime? updatedAt;
  final Map<String, List<MealPlanEntry>> mealPlans;
  final int dailyCalories;
  final double dailyProtein;
  final double dailyCarbs;
  final double dailyFats;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.age,
    this.profileImage,
    required this.createdAt,
    this.favorites = const [],
    this.plannedMeals = const [],
    this.updatedAt,
    this.mealPlans = const {},
    this.dailyCalories = 2000,
    this.dailyProtein = 150,
    this.dailyCarbs = 250,
    this.dailyFats = 65,
  });
}
