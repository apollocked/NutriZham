import 'package:nutrizham/domain/repositories/favorites_repository.dart';
import 'package:nutrizham/data/datasources/favorites_helper.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  @override
  Future<Set<String>> loadFavorites() => FavoritesHelper.loadFavorites();

  @override
  Future<void> toggleFavorite(String recipeId) =>
      FavoritesHelper.toggleFavorite(recipeId);

  @override
  Future<bool> isFavorite(String recipeId) => FavoritesHelper.isFavorite(recipeId);

  @override
  Future<void> clearAllFavorites() => FavoritesHelper.clearAllFavorites();

  @override
  Future<int> getFavoritesCount() => FavoritesHelper.getFavoritesCount();
}
