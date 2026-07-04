import 'package:nutrizham/data/models/meals_data.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes({String? lastDocId, int limit});
  Future<List<Recipe>> getAllRecipes();
  Future<List<Recipe>> searchRecipes(String query);
  Future<List<Recipe>> getRecipesByCategory(MealCategory category);
  Future<Recipe?> getRecipeById(String id);
  Stream<List<Recipe>> streamRecipesByIds(List<String> ids);
}
