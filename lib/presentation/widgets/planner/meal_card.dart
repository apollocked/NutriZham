import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class MealCard extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final String slot;
  final VoidCallback onRemove;

  const MealCard({
    super.key,
    required this.recipe,
    required this.index,
    required this.slot,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final catName = recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);

    final cardBody = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 68,
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Container(
                    width: 28,
                    color: catColor.withOpacity(0.08),
                    child: Center(
                      child: Icon(Icons.drag_indicator_rounded,
                          size: 18, color: catColor.withOpacity(0.5)),
                    ),
                  ),
                ),
                Container(width: 4, color: catColor),
                const SizedBox(width: 10),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        catColor.withOpacity(0.15),
                        catColor.withOpacity(0.05)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child:
                        Text(recipe.icon, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title[locale] ?? recipe.title['en'] ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department_rounded,
                              size: 12,
                              color: AppColors.caloriesColor.withOpacity(0.7)),
                          const SizedBox(width: 3),
                          Text('${recipe.nutrition.calories} ${AppLocalizations.of(context)!.kcal}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.caloriesColor
                                      .withOpacity(0.8))),
                          const SizedBox(width: 10),
                          MiniMacro(
                              label: AppLocalizations.of(context)!.proteinAbbr,
                              value:
                                  '${recipe.nutrition.protein.toStringAsFixed(0)}g',
                              color: AppColors.proteinColor),
                          const SizedBox(width: 6),
                          MiniMacro(
                              label: AppLocalizations.of(context)!.carbsAbbr,
                              value:
                                  '${recipe.nutrition.carbs.toStringAsFixed(0)}g',
                              color: AppColors.carbsColor),
                          const SizedBox(width: 6),
                          MiniMacro(
                              label: AppLocalizations.of(context)!.fatsAbbr,
                              value:
                                  '${recipe.nutrition.fats.toStringAsFixed(0)}g',
                              color: AppColors.fatsColor),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.close_rounded,
                        size: 16, color: AppColors.error),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return LongPressDraggable<Map<String, String>>(
      data: {'recipeId': recipe.id, 'fromSlot': slot},
      feedback: Material(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: theme.shadowColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        child: Opacity(opacity: 0.85, child: SizedBox(width: 320, child: cardBody)),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: cardBody),
      child: cardBody,
    );
  }
}

class MiniMacro extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MiniMacro(
      {super.key,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('$label $value',
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
