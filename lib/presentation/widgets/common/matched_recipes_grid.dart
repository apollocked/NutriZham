import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/pressable.dart';
import 'package:nutrizham/presentation/widgets/recipe/adaptive_recipe_grid.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class MatchedRecipesGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final void Function(Recipe) onLongPress;

  const MatchedRecipesGrid({
    super.key,
    required this.recipes,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (recipes.isEmpty) {
      final theme = Theme.of(context);
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(loc.noMatchingRecipes, style: theme.textTheme.bodyLarge),
          ],
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;
        return GridView.builder(
          gridDelegate:
              adaptiveRecipeGridDelegate(constraints.maxWidth, textScale),
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth >= 600 ? 24 : 11),
          itemCount: recipes.length,
          itemBuilder: (_, i) => _RecipeGridItem(
            recipe: recipes[i],
            index: i,
            onLongPress: onLongPress,
          ),
        );
      },
    );
  }
}

class _RecipeGridItem extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final void Function(Recipe) onLongPress;

  const _RecipeGridItem({
    required this.recipe,
    required this.index,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesCubit>();
    return DelayedReveal(
      index: index,
      child: RecipeCard(
        recipe: recipe,
        isFavorite: favorites.isFavorite(recipe.id),
        onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
        onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
        onLongPress: () => onLongPress(recipe),
      ),
    );
  }
}
