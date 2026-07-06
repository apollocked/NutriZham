import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';
import 'package:nutrizham/presentation/widgets/common/pressable.dart';
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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.82, crossAxisSpacing: 0, mainAxisSpacing: 0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11),
      itemCount: recipes.length,
      itemBuilder: (_, i) {
        final r = recipes[i];
        final favorites = context.watch<FavoritesCubit>();
        return DelayedReveal(
          index: i,
          child: RecipeCard(
            recipe: r,
            isFavorite: favorites.isFavorite(r.id),
            onFavoriteToggle: () => favorites.toggleFavorite(r.id),
            onTap: () => context.push('/recipe/${r.id}', extra: r),
            onLongPress: () => onLongPress(r),
          ),
        );
      },
    );
  }
}
