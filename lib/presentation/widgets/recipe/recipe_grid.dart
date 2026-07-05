import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/planner/choose_slot_dialog.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isLoading;
  final bool isOffline;
  final bool showFavoritesOnly;
  final ScrollController? scrollController;
  final VoidCallback? onLoadMore;

  const RecipeGrid({
    super.key,
    required this.recipes,
    required this.hasMore,
    required this.isLoadingMore,
    required this.isLoading,
    required this.isOffline,
    required this.showFavoritesOnly,
    this.scrollController,
    this.onLoadMore,
  });

  void _addToPlanner(BuildContext context, Recipe recipe) {
    showChooseSlotDialog(context).then((slot) {
      if (slot == null || !context.mounted) return;
      context.read<MealPlannerCubit>().addMealToDate(recipe.id, slot);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${recipe.title['en']} added to $slot'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (isOffline && recipes.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.wifi_off_rounded,
        title: 'No internet connection',
        subtitle: 'Connect to the internet to load recipes',
      );
    }

    if (recipes.isEmpty) {
      return EmptyStateWidget(
        icon: showFavoritesOnly ? Icons.favorite_outline : Icons.search_off,
        title: showFavoritesOnly ? loc.noFavorites : loc.noRecipesFound,
        subtitle: showFavoritesOnly ? loc.tapToSave : loc.tryDifferentSearch,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (onLoadMore != null &&
            !isLoadingMore &&
            hasMore &&
            scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200) {
          onLoadMore!();
        }
        return false;
      },
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.82,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 11),
        itemCount: recipes.length + (hasMore && isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == recipes.length) {
            return const ShimmerRecipeCard();
          }
          final recipe = recipes[index];
          return RecipeCard(
            recipe: recipe,
            isFavorite: context.watch<FavoritesCubit>().isFavorite(recipe.id),
            onFavoriteToggle: () =>
                context.read<FavoritesCubit>().toggleFavorite(recipe.id),
            onTap: () => context.push('/recipe/$recipe.id', extra: recipe),
            onLongPress: () => _addToPlanner(context, recipe),
          );
        },
      ),
    );
  }
}
