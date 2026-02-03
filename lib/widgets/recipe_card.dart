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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Recipe Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.getCategoryColor(
                    recipe.category.toString().split('.').last,
                  ).withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    recipe.icon,
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.getCategoryColor(
                        recipe.category.toString().split('.').last,
                      ),
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
                        fontWeight: FontWeight.w600,
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
                  ],
                ),
              ),

              // Favorite Button
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
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

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.getCategoryColor(
              recipe.category.toString().split('.').last,
            ).withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              recipe.icon,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.getCategoryColor(
                  recipe.category.toString().split('.').last,
                ),
              ),
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
