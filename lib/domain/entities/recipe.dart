import 'package:nutrizham/domain/entities/meal_category.dart';
import 'package:nutrizham/domain/entities/nutritional_info.dart';

class Recipe {
  final String id;
  final Map<String, String> title;
  final String icon;
  final NutritionalInfo nutrition;
  final Map<String, List<String>> ingredients;
  final Map<String, List<String>> steps;
  final MealCategory category;
  double rating;
  int ratingCount;

  Recipe({
    required this.id,
    required this.title,
    required this.icon,
    required this.nutrition,
    required this.ingredients,
    required this.steps,
    required this.category,
    this.rating = 0.0,
    this.ratingCount = 0,
  });
}
