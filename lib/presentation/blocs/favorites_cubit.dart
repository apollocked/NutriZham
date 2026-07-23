import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/datasources/favorites_helper.dart';

sealed class FavoritesState {
  const FavoritesState();
}
class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}
class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}
class FavoritesLoaded extends FavoritesState {
  final Set<String> ids;
  const FavoritesLoaded(this.ids);
}
class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesInitial());

  Set<String> get ids {
    final s = state;
    return s is FavoritesLoaded ? s.ids : {};
  }

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    try {
      final ids = await FavoritesHelper.loadFavorites();
      emit(FavoritesLoaded(ids));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(String recipeId) async {
    try {
      await FavoritesHelper.toggleFavorite(recipeId);
      final ids = await FavoritesHelper.loadFavorites();
      emit(FavoritesLoaded(ids));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String recipeId) => ids.contains(recipeId);

  int get count => ids.length;

  Future<void> clearAll() async {
    try {
      await FavoritesHelper.clearAllFavorites();
      emit(const FavoritesLoaded({}));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
