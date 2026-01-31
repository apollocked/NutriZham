// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_localizations.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final bool isDarkMode;
  final String languageCode;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.isDarkMode,
    required this.languageCode,
  });

  String _getCategoryName(MealCategory category) {
    final loc = AppLocalizations.of(languageCode);
    switch (category) {
      case MealCategory.breakfast:
        return loc.breakfast;
      case MealCategory.lunch:
        return loc.lunch;
      case MealCategory.dinner:
        return loc.dinner;
      case MealCategory.snack:
        return loc.snack;
      case MealCategory.bulking:
        return loc.bulking;
      case MealCategory.cutting:
        return loc.cutting;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(languageCode);
    final bgColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    final recipeTitle = recipe.title[languageCode] ?? recipe.title['en'] ?? '';
    final recipeIngredients =
        recipe.ingredients[languageCode] ?? recipe.ingredients['en'] ?? [];
    final recipeSteps = recipe.steps[languageCode] ?? recipe.steps['en'] ?? [];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(recipeTitle),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite
                  ? Colors.red
                  : (isDarkMode ? Colors.white : Colors.white),
            ),
            onPressed: onFavoriteToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image
            Stack(
              children: [
                Image.network(
                  recipe.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.restaurant, size: 64),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getCategoryName(recipe.category),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nutritional information card
                  Card(
                    color: cardColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.nutritionalInfo,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildNutrientColumn(
                                '${recipe.nutrition.calories}',
                                loc.calories,
                                Colors.red,
                                Icons.local_fire_department,
                              ),
                              _buildNutrientColumn(
                                '${recipe.nutrition.protein}g',
                                loc.protein,
                                Colors.blue,
                                Icons.fitness_center,
                              ),
                              _buildNutrientColumn(
                                '${recipe.nutrition.carbs}g',
                                loc.carbs,
                                Colors.orange,
                                Icons.bakery_dining,
                              ),
                              _buildNutrientColumn(
                                '${recipe.nutrition.fats}g',
                                loc.fats,
                                Colors.purple,
                                Icons.water_drop,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ingredients section
                  Text(
                    loc.ingredients,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: cardColor,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipeIngredients
                            .map(
                              (ingredient) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ingredient,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Steps section
                  Text(
                    loc.preparationSteps,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...recipeSteps.asMap().entries.map(
                        (entry) => Card(
                          color: cardColor,
                          elevation: 1,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${entry.key + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientColumn(
      String value, String label, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
