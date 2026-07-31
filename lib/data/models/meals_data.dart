enum MealCategory {
  breakfast,
  lunch,
  dinner,
  snack,
  bulking,
  cutting,
}

class NutritionalInfo {
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0,
      fats: (json['fats'] as num?)?.toDouble() ?? 0,
    );
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'nutrition': nutrition.toJson(),
      'ingredients': ingredients,
      'steps': steps,
      'category': category.name,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String? ?? '',
      title: Map<String, String>.from(json['title'] ?? {}),
      icon: json['icon'] as String? ?? '',
      nutrition: json['nutrition'] is Map<String, dynamic>
          ? NutritionalInfo.fromJson(Map<String, dynamic>.from(json['nutrition']))
          : NutritionalInfo(calories: 0, protein: 0, carbs: 0, fats: 0),
      ingredients: Map<String, List<String>>.from(
        (json['ingredients'] as Map<String, dynamic>? ?? {}).map(
            (key, value) => MapEntry(key, List<String>.from(value as List? ?? []))),
      ),
      steps: Map<String, List<String>>.from(
        (json['steps'] as Map<String, dynamic>? ?? {}).map(
            (key, value) => MapEntry(key, List<String>.from(value as List? ?? []))),
      ),
      category: MealCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => MealCategory.snack,
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
    );
  }
}
