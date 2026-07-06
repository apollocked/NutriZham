import 'package:nutrizham/data/models/meals_data.dart';

class IngredientIndex {
  IngredientIndex._();

  static final IngredientIndex _instance = IngredientIndex._();
  static IngredientIndex get instance => _instance;

  List<String>? _allIngredients;
  Map<String, Set<String>>? _recipeIngredientSets;

  void build(List<Recipe> recipes) {
    if (_allIngredients != null) return;
    final seen = <String>{};
    final index = <String, Set<String>>{};
    for (final r in recipes) {
      final ings = <String>{};
      for (final list in r.ingredients.values) {
        for (final ing in list) {
          final cleaned = ing.trim().toLowerCase();
          if (cleaned.isNotEmpty) {
            seen.add(cleaned);
            ings.add(cleaned);
          }
        }
      }
      index[r.id] = ings;
    }
    _allIngredients = seen.toList()..sort();
    _recipeIngredientSets = index;
  }

  List<String> get allIngredients {
    if (_allIngredients == null) return [];
    return _allIngredients!;
  }

  Set<String> ingredientsFor(String recipeId) {
    return _recipeIngredientSets?[recipeId] ?? {};
  }

  void invalidate() {
    _allIngredients = null;
    _recipeIngredientSets = null;
  }
}
