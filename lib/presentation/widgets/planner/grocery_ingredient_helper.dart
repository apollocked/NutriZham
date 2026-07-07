import 'package:nutrizham/data/models/meals_data.dart';

class GroceryIngredient {
  final String displayText;
  final int count;

  const GroceryIngredient({required this.displayText, required this.count});
}

String normalizeIngredient(String ingredient) {
  return ingredient
      .replaceFirst(
          RegExp(
              r'^[\d\s\/.,¼½¾⅓⅔⅛⅜⅝⅞+\-]+(g|kg|ml|l|oz|lb|cup|cups|tbsp|tsp|piece|pieces|slice|slices|clove|cloves|can|cans|package|packages|bunch|bunches|handful|head|sprig|pinch|to taste|as needed)?[\s,]*',
              caseSensitive: false),
          '')
      .trim()
      .toLowerCase();
}

List<GroceryIngredient> buildIngredientList(List<Recipe> recipes, String locale) {
  final groups = <String, List<String>>{};
  for (final recipe in recipes) {
    final ings = recipe.ingredients[locale] ?? recipe.ingredients['en'] ?? <String>[];
    for (final ing in ings) {
      final key = normalizeIngredient(ing);
      groups.putIfAbsent(key, () => []).add(ing);
    }
  }
  return groups.entries.map((e) {
    final best = e.value.reduce((a, b) => a.length >= b.length ? a : b);
    return GroceryIngredient(displayText: best, count: e.value.length);
  }).toList()
    ..sort((a, b) => a.displayText.compareTo(b.displayText));
}
