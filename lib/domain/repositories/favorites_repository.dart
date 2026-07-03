abstract class FavoritesRepository {
  Future<Set<String>> loadFavorites();
  Future<void> toggleFavorite(String recipeId);
  Future<bool> isFavorite(String recipeId);
  Future<void> clearAllFavorites();
  Future<int> getFavoritesCount();
}
