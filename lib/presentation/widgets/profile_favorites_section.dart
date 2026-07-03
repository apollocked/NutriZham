import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileFavoritesSection extends StatelessWidget {
  final List<Recipe> favoriteMeals;
  final FavoritesProvider favoritesProvider;
  final ValueChanged<String> onToggleFavorite;

  const ProfileFavoritesSection({
    super.key,
    required this.favoriteMeals,
    required this.favoritesProvider,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 4, height: 22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(loc.favorites, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 16),
          if (favoriteMeals.isEmpty)
            EmptyStateWidget(icon: Icons.favorite_outline, title: loc.noFavorites, subtitle: loc.tapToSave)
          else
            Column(children: [
              ...favoriteMeals.take(5).map((recipe) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RecipeCard(recipe: recipe, isFavorite: true, onFavoriteToggle: () => onToggleFavorite(recipe.id), onTap: () {}),
                  )),
              if (favoriteMeals.length > 5)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('+ ${favoriteMeals.length - 5} more', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
                    ),
                  ),
                ),
            ]),
        ],
      ),
    );
  }
}
