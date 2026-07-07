import 'package:nutrizham/data/models/meals_data.dart';

class IngredientIndex {
  IngredientIndex._();

  static final IngredientIndex _instance = IngredientIndex._();
  static IngredientIndex get instance => _instance;

  List<String> _allIngredients = [];
  final Map<String, Set<String>> _recipeIngredientSets = {};
  final Map<String, Set<String>> _reverseIndex = {};
  int _recipeCount = 0;

  void build(List<Recipe> recipes, {String? localeCode}) {
    final seen = <String>{};
    _recipeIngredientSets.clear();
    _reverseIndex.clear();
    for (final r in recipes) {
      final ings = <String>{};
      final lists = localeCode != null && r.ingredients.containsKey(localeCode)
          ? [r.ingredients[localeCode]!]
          : r.ingredients.values;
      for (final list in lists) {
        for (final ing in list) {
          final cleaned = stripPortion(ing);
          if (cleaned.isNotEmpty &&
              cleaned.length < 40 &&
              !cleaned.contains(',') &&
              !cleaned.contains(':')) {
            seen.add(cleaned);
            ings.add(cleaned);
            _reverseIndex.putIfAbsent(cleaned, () => {}).add(r.id);
          }
        }
      }
      _recipeIngredientSets[r.id] = ings;
    }
    _allIngredients = seen.toList()..sort();
    _recipeCount = recipes.length;
  }

  List<String> get allIngredients => _allIngredients;
  int get recipeCount => _recipeCount;

  Set<String> ingredientsFor(String recipeId) =>
      _recipeIngredientSets[recipeId] ?? {};

  List<String> recipesContaining(String ingredient) =>
      _reverseIndex[ingredient]?.toList() ?? [];

  static final RegExp _nums = RegExp(r'^[\d\s\/\-\.¼½¾⅓⅔⅛⅜⅝⅞]+');
  static final RegExp _trail = RegExp(r'\s*(?:to\s*taste|optional)\s*$');
  static final RegExp _lead = RegExp(r'^(?:to\s+taste|optional)\s+');
  static final RegExp _unit = RegExp(r'^(?:'
      r'tsp\.?|tbsp\.?|teaspoon|tablespoon|cup|cups|'
      r'oz|ounce|ounces|lb|lbs|pound|pounds|'
      r'g|kg|ml|l|liter|liters'
      r')\s+');

  static String stripPortion(String raw) {
    var s = raw.trim().toLowerCase();
    s = s.replaceAll(_trail, '');
    s = s.replaceFirst(_lead, '');
    s = s.replaceFirst(_nums, '');
    s = s.replaceFirst(_unit, '');
    return s.trim();
  }
}
