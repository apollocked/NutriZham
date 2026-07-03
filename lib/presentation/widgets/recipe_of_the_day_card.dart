import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RecipeOfTheDayCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeOfTheDayCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary.withOpacity(0.08),
          theme.colorScheme.secondary.withOpacity(0.05)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.star_rounded,
                  color: Color(0xFF10B981), size: 18)),
          const SizedBox(width: 10),
          Text(loc.recipeOfTheDay,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface)),
        ]),
        const SizedBox(height: 12),
        RecipeCard(
          recipe: recipe,
          isFavorite: favorites.isFavorite(recipe.id),
          onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
          onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
        ),
      ]),
    );
  }
}
