import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/compact_recipe_card.dart';

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
    return Column(
        children: recommendedMeals
            .map((recipe) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CompactRecipeCard(
                    recipe: recipe,
                    trailing: IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Color(0xFF10B981)),
                        onPressed: () => onAddMeal(recipe.id)),
                  ),
                ))
            .toList());
  }
}
