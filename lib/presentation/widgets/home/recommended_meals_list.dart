import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/recipe/compact_recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class RecommendedMealsList extends StatelessWidget {
  final List<Recipe> recommendedMeals;
  final ValueChanged<String> onAddMeal;

  const RecommendedMealsList({
    super.key,
    required this.recommendedMeals,
    required this.onAddMeal,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (recommendedMeals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(loc.noRecipesAvailable, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: recommendedMeals.length,
      itemBuilder: (_, i) {
        final recipe = recommendedMeals[i];
        return CompactRecipeCard(
          recipe: recipe,
          onTap: () {},
          trailing: IconButton(
            icon: Icon(Icons.add_circle_rounded, color: theme.colorScheme.primary),
            onPressed: () => onAddMeal(recipe.id),
          ),
        );
      },
    );
  }
}
