import 'package:nutrizham/domain/entities/recipe.dart';
import 'package:nutrizham/domain/entities/meal_category.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes({String? lastRecipeTitle, int limit});
  Future<List<Recipe>> getAllRecipes();
  Future<List<Recipe>> searchRecipes(String query);
  Future<List<Recipe>> getRecipesByCategory(MealCategory category);
  Future<Recipe?> getRecipeById(String id);
  Stream<List<Recipe>> streamRecipesByIds(List<String> ids);
}
