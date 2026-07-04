import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/data/repositories/recipe_repository_impl.dart';

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
  const RecipeLoaded(this.recipes, {this.hasMore = true});
}
class RecipeLoadingMore extends RecipeState {
  final List<Recipe> recipes;
  const RecipeLoadingMore(this.recipes);
}
class RecipeError extends RecipeState {
  final String message;
  const RecipeError(this.message);
}

class RecipeCubit extends Cubit<RecipeState> {
  final _repository = RecipeRepositoryImpl();
  static const int _pageSize = 25;

  RecipeCubit() : super(const RecipeInitial());

  List<Recipe> get recipes {
    final s = state;
    if (s is RecipeLoaded) return s.recipes;
    if (s is RecipeLoadingMore) return s.recipes;
    return [];
  }

  bool get isLoading => state is RecipeLoading;
  bool get isLoadingMore => state is RecipeLoadingMore;
  bool get hasMore {
    final s = state;
    return s is RecipeLoaded ? s.hasMore : true;
  }

  Future<List<Recipe>> getNextBatch({
    String? lastRecipeTitle,
    int limit = 25,
  }) async {
    return await _repository.getRecipes(
      lastRecipeTitle: lastRecipeTitle,
      limit: limit,
    );
  }

  Future<void> loadNextBatch() async {
    final current = state;
    if (current is RecipeLoading || current is RecipeLoadingMore) return;
    if (current is RecipeLoaded && !current.hasMore) return;

    if (current is RecipeInitial) {
      emit(const RecipeLoading());
    } else if (current is RecipeLoaded) {
      emit(RecipeLoadingMore(current.recipes));
    }

    try {
      final currentRecipes = current is RecipeLoaded ? current.recipes : <Recipe>[];
      final lastTitle = currentRecipes.isNotEmpty
          ? currentRecipes.last.title['en'] ?? ''
          : null;

      final newRecipes = await _repository.getRecipes(
        lastRecipeTitle: lastTitle,
        limit: _pageSize,
      );

      final allRecipes = [...currentRecipes, ...newRecipes];
      final more = newRecipes.length == _pageSize;
      emit(RecipeLoaded(allRecipes, hasMore: more));
    } catch (e) {
      if (current is RecipeLoaded) {
        emit(RecipeLoaded(current.recipes, hasMore: current.hasMore));
      } else {
        emit(RecipeError(e.toString()));
      }
    }
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
    emit(const RecipeInitial());
  }
}
