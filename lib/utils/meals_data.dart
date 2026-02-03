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
      calories: json['calories'] as int,
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
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
      id: json['id'] as String,
      title: Map<String, String>.from(json['title']),
      icon: json['icon'] as String,
      nutrition: NutritionalInfo.fromJson(json['nutrition']),
      ingredients: Map<String, List<String>>.from(
        json['ingredients']
            .map((key, value) => MapEntry(key, List<String>.from(value))),
      ),
      steps: Map<String, List<String>>.from(
        json['steps']
            .map((key, value) => MapEntry(key, List<String>.from(value))),
      ),
      category: MealCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => MealCategory.snack,
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['ratingCount'] as int? ?? 0,
    );
  }
}
