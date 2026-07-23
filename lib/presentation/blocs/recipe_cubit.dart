import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/core/cache/recipe_cache_service.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/data/repositories/recipe_repository_impl.dart';
import 'package:nutrizham/presentation/blocs/connectivity_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _repository = RecipeRepositoryImpl();
  final _cache = RecipeCacheService(CacheService());
  static const int _pageSize = 15;
  ConnectivityCubit? _connectivity;
  bool _isFetching = false;

  RecipeCubit() : super(const RecipeInitial());

  void injectConnectivity(ConnectivityCubit connectivity) {
    _connectivity = connectivity;
  }

  bool get _isOnline => _connectivity?.isOnline ?? true;

  List<Recipe> get recipes {
    final s = state;
    if (s is RecipeLoaded) return s.recipes;
    if (s is RecipeLoadingMore) return s.recipes;
    if (s is RecipeError && s.cachedRecipes != null) return s.cachedRecipes!;
    return [];
  }

  bool get isLoading => state is RecipeLoading;
  bool get isLoadingMore => state is RecipeLoadingMore;  bool get isOffline {
    final s = state;
    return (s is RecipeLoaded && s.isOffline) || (s is RecipeError && s.isOffline);
  }
  bool get hasMore {
    final s = state;
    return s is RecipeLoaded ? s.hasMore : true;
  }

  Future<void> loadNextBatch() async {
    final current = state;
    if (current is RecipeLoading || current is RecipeLoadingMore) return;
    if (current is RecipeLoaded && !current.hasMore) return;
    if (_isFetching) return;

    try {
      _isFetching = true;

      if (current is RecipeInitial) {
        final cached = await _cache.getCachedRecipes();
        if (cached.isNotEmpty) {
          emit(RecipeLoaded(cached, hasMore: true));
        }

        if (!_isOnline) {
          if (cached.isEmpty) {
            emit(const RecipeError('No internet connection', isOffline: true));
          }
          return;
        }

        if (cached.isEmpty) {
          emit(const RecipeLoading());
        }

        final newRecipes = await _repository.getRecipes(limit: _pageSize);
        final prevRecipes = cached;
        final prevIds = prevRecipes.map((r) => r.id).toSet();
        final deduped = newRecipes.where((r) => !prevIds.contains(r.id)).toList();
        final allRecipes = [...prevRecipes, ...deduped];
        final more = newRecipes.length == _pageSize;
        emit(RecipeLoaded(allRecipes, hasMore: more));
        _cache.cacheRecipes(allRecipes);
      } else if (current is RecipeLoaded) {
        if (!_isOnline) {
          emit(RecipeLoaded(current.recipes, hasMore: current.hasMore, isOffline: true));
          return;
        }

        emit(RecipeLoadingMore(current.recipes));

        final lastDocId = current.recipes.isEmpty ? null : current.recipes.last.id;
        final newRecipes = await _repository.getRecipes(
          lastDocId: lastDocId,
          limit: _pageSize,
        );

        final prevIds = current.recipes.map((r) => r.id).toSet();
        final deduped = newRecipes.where((r) => !prevIds.contains(r.id)).toList();
        final allRecipes = [...current.recipes, ...deduped];
        final more = newRecipes.length == _pageSize;
        emit(RecipeLoaded(allRecipes, hasMore: more));
        _cache.cacheRecipes(allRecipes);
      }
    } catch (e) {
      final s = state;
      if (s is RecipeLoaded) {
        emit(RecipeLoaded(s.recipes, hasMore: s.hasMore, isOffline: !_isOnline));
      } else if (s is RecipeLoadingMore) {
        emit(RecipeLoaded(s.recipes, hasMore: true, isOffline: !_isOnline));
      } else {
        emit(RecipeError(e.toString(), isOffline: !_isOnline));
      }
    } finally {
      _isFetching = false;
    }
  }

  Future<List<Recipe>> getAll() async {
    final cached = await _cache.getCachedRecipes();
    if (_isOnline) {
      try {
        final recipes = await _repository.getAllRecipes();
        _cache.cacheRecipes(recipes);
        return recipes;
      } catch (_) {
        if (cached.isNotEmpty) return cached;
        rethrow;
      }
    }
    if (cached.isNotEmpty) return cached;
    throw Exception('No internet connection and no cached data');
  }

  Future<List<Recipe>> getAllFresh() async {
    if (!_isOnline) {
      final cached = await _cache.getCachedRecipes();
      if (cached.isNotEmpty) return cached;
      throw Exception('No internet connection');
    }
    try {
      final recipes = await _repository.getAllRecipes();
      _cache.cacheRecipes(recipes);
      return recipes;
    } catch (_) {
      final cached = await _cache.getCachedRecipes();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  Future<List<Recipe>> search(String query) async {
    Object? searchError;
    if (_isOnline) {
      try {
        return await _repository.searchRecipes(query);
      } catch (e) {
        searchError = e;
      }
    }
    final cached = await _cache.getCachedRecipes();
    if (cached.isNotEmpty) {
      final q = query.toLowerCase();
      return cached.where((r) {
        final t = r.title['en'] ?? '';
        return t.toLowerCase().contains(q);
      }).toList();
    }
    if (!_isOnline) throw Exception('No internet connection');
    if (searchError != null) throw searchError;
    throw Exception('Search failed');
  }

  Future<List<Recipe>> getByCategory(MealCategory category) async {
    if (_isOnline) {
      try {
        return await _repository.getRecipesByCategory(category);
      } catch (e) {
        debugPrint('RecipeCubit.getByCategory: $e');
      }
    }
    final cached = await _cache.getCachedRecipes();
    return cached.where((r) => r.category == category).toList();
  }

  Future<Recipe?> getById(String id) async {
    final cached = await _cache.getCachedRecipes();
    try {
      return cached.firstWhere((r) => r.id == id);
    } catch (e) {
      debugPrint('RecipeCubit.getById.cache: $e');
    }
    if (_isOnline) {
      try {
        final recipe = await _repository.getRecipeById(id);
        if (recipe != null) _cache.cacheRecipes([...cached, recipe]);
        return recipe;
      } catch (e) {
        debugPrint('RecipeCubit.getById.network: $e');
      }
    }
    return null;
  }

  Stream<List<Recipe>> streamByIds(List<String> ids) {
    return _repository.streamRecipesByIds(ids);
  }

  void clear() {
    _isFetching = false;
    emit(const RecipeInitial());
  }
}
