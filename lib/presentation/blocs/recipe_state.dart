import 'package:nutrizham/data/models/meals_data.dart';

sealed class RecipeState {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  const RecipeInitial();
}

class RecipeLoading extends RecipeState {
  const RecipeLoading();
}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;
  final bool hasMore;
  final bool isOffline;

  const RecipeLoaded(this.recipes, {this.hasMore = true, this.isOffline = false});
}

class RecipeLoadingMore extends RecipeState {
  final List<Recipe> recipes;

  const RecipeLoadingMore(this.recipes);
}

class RecipeError extends RecipeState {
  final String message;
  final bool isOffline;
  final List<Recipe>? cachedRecipes;

  const RecipeError(this.message, {this.isOffline = false, this.cachedRecipes});
}
