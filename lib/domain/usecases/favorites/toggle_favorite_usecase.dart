import 'package:nutrizham/domain/repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<void> call(String recipeId) => repository.toggleFavorite(recipeId);
}
