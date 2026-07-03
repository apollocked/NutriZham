import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final catName = recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);
    final title = recipe.title[locale] ?? recipe.title['en'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(
                  flex: 11,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [catColor.withOpacity(0.2), catColor.withOpacity(0.04)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(child: Text(recipe.icon, style: TextStyle(fontSize: 38, color: catColor))),
                        Positioned(
                          top: 4,
                          right: 2,
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_outline,
                                size: 20,
                              ),
                              color: isFavorite ? AppColors.accentRed : theme.colorScheme.onSurfaceVariant,
                              onPressed: onFavoriteToggle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: catColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _getCategoryName(recipe.category, context),
                                style: TextStyle(fontSize: 10, color: catColor, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.local_fire_department_rounded, size: 12, color: AppColors.caloriesColor.withOpacity(0.7)),
                            const SizedBox(width: 2),
                            Text('${recipe.nutrition.calories}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.caloriesColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryName(MealCategory category, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (category) {
      case MealCategory.breakfast: return loc.breakfast;
      case MealCategory.lunch: return loc.lunch;
      case MealCategory.dinner: return loc.dinner;
      case MealCategory.snack: return loc.snack;
      case MealCategory.bulking: return loc.bulking;
      case MealCategory.cutting: return loc.cutting;
    }
  }
}
