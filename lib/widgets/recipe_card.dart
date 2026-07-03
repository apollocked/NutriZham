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
    final catName = recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
        boxShadow: [
          BoxShadow(
            color: catColor.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: catColor.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      recipe.icon,
                      style: TextStyle(fontSize: 28, color: catColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title[languageCode] ?? recipe.title['en'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: catColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getCategoryName(recipe.category),
                              style: TextStyle(
                                fontSize: 11,
                                color: catColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${recipe.nutrition.calories} kcal',
                            style: TextStyle(
                              fontSize: 13,
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
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFavorite
                        ? AppColors.accentRed.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      size: 22,
                    ),
                    color: isFavorite ? AppColors.accentRed : Colors.grey,
                    onPressed: onFavoriteToggle,
                  ),
                ),
              ],
            ),
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
    final catName = recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: catColor.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      recipe.icon,
                      style: TextStyle(fontSize: 20, color: catColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title[languageCode] ??
                            recipe.title['en'] ??
                            '',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${recipe.nutrition.calories} kcal',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
