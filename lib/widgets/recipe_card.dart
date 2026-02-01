import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_localizations.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isDarkMode;
  final String languageCode;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isDarkMode,
    required this.languageCode,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
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
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Card(
      color: isDarkMode ? AppColors.darkCard : Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Recipe Icon
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 70,
                  height: 70,
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  child: recipe.icon.startsWith('http')
                      ? Image.network(
                          recipe.icon,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.restaurant,
                            size: 30,
                          ),
                        )
                      : Center(
                          child: Text(
                            recipe.icon,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Recipe Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title[languageCode] ?? recipe.title['en'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${recipe.nutrition.calories} kcal • ${_getCategoryName(recipe.category)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.starActive,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.rating.toStringAsFixed(1)} (${recipe.ratingCount})',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Favorite Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.accentRed : Colors.grey,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompactRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isDarkMode;
  final String languageCode;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CompactRecipeCard({
    super.key,
    required this.recipe,
    required this.isDarkMode,
    required this.languageCode,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Card(
      color: isDarkMode ? AppColors.darkCard : Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              recipe.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          recipe.title[languageCode] ?? recipe.title['en'] ?? '',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          '${recipe.nutrition.calories} kcal',
          style: TextStyle(
            color: isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
