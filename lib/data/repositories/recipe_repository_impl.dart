import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/domain/repositories/recipe_repository.dart';
import 'package:nutrizham/data/datasources/recipe_datasource.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  @override
  Future<List<Recipe>> getRecipes({String? lastRecipeTitle, int limit = 25}) =>
      RecipeDatasource.getRecipes(
          lastRecipeTitle: lastRecipeTitle, limit: limit);

  @override
  Future<List<Recipe>> getAllRecipes() => RecipeDatasource.getAllRecipes();

  @override
  Future<List<Recipe>> searchRecipes(String query) =>
      RecipeDatasource.searchRecipes(query);

  @override
  Future<List<Recipe>> getRecipesByCategory(MealCategory category) =>
      RecipeDatasource.getRecipesByCategory(category);

  @override
  Future<Recipe?> getRecipeById(String id) =>
      RecipeDatasource.getRecipeById(id);

  @override
  Stream<List<Recipe>> streamRecipesByIds(List<String> ids) =>
      RecipeDatasource.streamRecipesByIds(ids);
}
