import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/compact_recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PlannedMealsList extends StatelessWidget {
  final List<Recipe> plannedMeals;
  final ValueChanged<String> onRemoveMeal;

  const PlannedMealsList({
    super.key,
    required this.plannedMeals,
    required this.onRemoveMeal,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (plannedMeals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: EmptyStateWidget(
            icon: Icons.calendar_today_outlined,
            title: loc.emptyPlan,
            subtitle: loc.tapToSave),
      );
    }
    return Column(
        children: plannedMeals
            .map((recipe) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CompactRecipeCard(
                    recipe: recipe,
                    trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Color(0xFFEF4444)),
                        onPressed: () => onRemoveMeal(recipe.id)),
                  ),
                ))
            .toList());
  }
}
