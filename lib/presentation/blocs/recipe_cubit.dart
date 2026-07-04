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
  static const int _pageSize = 15;

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
    String? lastDocId,
    int limit = 15,
  }) async {
    return await _repository.getRecipes(
      lastDocId: lastDocId,
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
      final prevRecipes = current is RecipeLoaded ? current.recipes : <Recipe>[];
      final lastDocId = prevRecipes.isNotEmpty ? prevRecipes.last.id : null;

      final newRecipes = await _repository.getRecipes(
        lastDocId: lastDocId,
        limit: _pageSize,
      );

      final prevIds = prevRecipes.map((r) => r.id).toSet();
      final deduped = newRecipes.where((r) => !prevIds.contains(r.id)).toList();
      final allRecipes = [...prevRecipes, ...deduped];
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
