import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/core/cache/recipe_cache_service.dart';
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
  final _cache = RecipeCacheService(CacheService());
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
      final cached = await _cache.getCachedRecipes();
      if (cached.isNotEmpty) {
        emit(RecipeLoaded(cached, hasMore: true));
      } else {
        emit(const RecipeLoading());
      }
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

      final prevIds = currentRecipes.map((r) => r.id).toSet();
      final deduped = newRecipes.where((r) => !prevIds.contains(r.id)).toList();
      final allRecipes = [...currentRecipes, ...deduped];
      final more = newRecipes.length == _pageSize;
      emit(RecipeLoaded(allRecipes, hasMore: more));
      _cache.cacheRecipes(allRecipes);
    } catch (e) {
      if (current is RecipeLoaded) {
        emit(RecipeLoaded(current.recipes, hasMore: current.hasMore));
      } else {
        emit(RecipeError(e.toString()));
      }
    }
  }

  Future<List<Recipe>> getAll() async {
    final cached = await _cache.getCachedRecipes();
    if (cached.isNotEmpty) return cached;
    final recipes = await _repository.getAllRecipes();
    _cache.cacheRecipes(recipes);
    return recipes;
  }

  Future<List<Recipe>> getAllFresh() async {
    final recipes = await _repository.getAllRecipes();
    _cache.cacheRecipes(recipes);
    return recipes;
  }

  Future<List<Recipe>> search(String query) async {
    try {
      return await _repository.searchRecipes(query);
    } catch (_) {
      final cached = await _cache.getCachedRecipes();
      if (cached.isNotEmpty) {
        final q = query.toLowerCase();
        return cached.where((r) {
          final t = r.title['en'] ?? '';
          return t.toLowerCase().contains(q);
        }).toList();
      }
      rethrow;
    }
  }

  Future<List<Recipe>> getByCategory(MealCategory category) async {
    try {
      return await _repository.getRecipesByCategory(category);
    } catch (_) {
      final cached = await _cache.getCachedRecipes();
      return cached.where((r) => r.category == category).toList();
    }
  }

  Future<Recipe?> getById(String id) async {
    final cached = await _cache.getCachedRecipes();
    try {
      return cached.firstWhere((r) => r.id == id);
    } catch (_) {}
    try {
      final recipe = await _repository.getRecipeById(id);
      if (recipe != null) _cache.cacheRecipes([...cached, recipe]);
      return recipe;
    } catch (_) {
      return null;
    }
  }

  Stream<List<Recipe>> streamByIds(List<String> ids) {
    return _repository.streamRecipesByIds(ids);
  }

  void clear() {
    emit(const RecipeInitial());
  }
}
