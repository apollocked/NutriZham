import 'package:flutter/material.dart';
import 'package:nutrizham/domain/entities/recipe.dart';
import 'package:nutrizham/domain/entities/meal_category.dart';
import 'package:nutrizham/data/repositories/recipe_repository_impl.dart';

class RecipeProvider extends ChangeNotifier {
  final _repository = RecipeRepositoryImpl();

  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _lastRecipeTitle;
  bool _hasMore = true;
  static const int _pageSize = 25;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<List<Recipe>> getNextBatch({String? lastRecipeTitle, int limit = 25}) async {
    return await _repository.getRecipes(
      lastRecipeTitle: lastRecipeTitle,
      limit: limit,
    );
  }

  Future<void> loadNextBatch() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();

    final newRecipes = await _repository.getRecipes(
      lastRecipeTitle: _lastRecipeTitle,
      limit: _pageSize,
    );

    if (newRecipes.isNotEmpty) {
      _lastRecipeTitle = newRecipes.last.title['en'] ?? '';
    }
    _recipes.addAll(newRecipes);
    _hasMore = newRecipes.length == _pageSize;
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Recipe>> getAll() async {
    return await _repository.getAllRecipes();
  }

  Future<List<Recipe>> search(String query) async {
    return await _repository.searchRecipes(query);
  }

  Future<List<Recipe>> getByCategory(MealCategory category) async {
    return await _repository.getRecipesByCategory(category);
  }

  Stream<List<Recipe>> streamByIds(List<String> ids) {
    return _repository.streamRecipesByIds(ids);
  }

  void clear() {
    _recipes = [];
    _lastRecipeTitle = null;
    _hasMore = true;
    notifyListeners();
  }
}
