import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class MealSlotSection extends StatelessWidget {
  final MealCategory slot;
  final List<Recipe> meals;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;
  final ValueChanged<String> onRemoveMeal;
  final void Function(int oldIndex, int newIndex) onReorder;
  final VoidCallback onAddMeal;

  const MealSlotSection({
    super.key,
    required this.slot,
    required this.meals,
    required this.isCollapsed,
    required this.onToggleCollapse,
    required this.onRemoveMeal,
    required this.onReorder,
    required this.onAddMeal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final slotKey = slot.name;
    final slotColor = AppColors.getCategoryColor(slotKey);

    String slotLabel(String key) {
      switch (key) {
        case 'breakfast':
          return loc.breakfast;
        case 'lunch':
          return loc.lunch;
        case 'dinner':
          return loc.dinner;
        case 'snack':
          return loc.snack;
        default:
          return key;
      }
    }

    IconData slotIcon(String key) {
      switch (key) {
        case 'breakfast':
          return Icons.wb_sunny_rounded;
        case 'lunch':
          return Icons.light_mode_rounded;
        case 'dinner':
          return Icons.nightlight_round;
        case 'snack':
          return Icons.cookie_rounded;
        default:
          return Icons.restaurant_rounded;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggleCollapse,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: slotColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(slotIcon(slotKey), color: slotColor, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      slotLabel(slotKey),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: slotColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${meals.length}',
                      style: TextStyle(
                        color: slotColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isCollapsed ? 0.5 : 0,
                    child: Icon(Icons.expand_more_rounded,
                        color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: isCollapsed
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: meals.isEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: GestureDetector(
                      onTap: onAddMeal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: slotColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: slotColor.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_rounded, size: 18, color: slotColor),
                            const SizedBox(width: 8),
                            Text(
                              'Add ${slotLabel(slotKey)}',
                              style: TextStyle(
                                color: slotColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    itemCount: meals.length,
                    onReorder: onReorder,
                    proxyDecorator: (child, index, animation) =>
                        Material(color: Colors.transparent, child: child),
                    itemBuilder: (context, index) {
                      final recipe = meals[index];
                      return _DraggableMealRow(
                        key: ValueKey(recipe.id),
                        recipe: recipe,
                        index: index,
                        onRemove: () => onRemoveMeal(recipe.id),
                      );
                    },
                  ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _DraggableMealRow extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final VoidCallback onRemove;

  const _DraggableMealRow({
    super.key,
    required this.recipe,
    required this.index,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final catName = recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          ReorderableDragStartListener(
            index: index,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.drag_indicator_rounded,
                  size: 18, color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  catColor.withOpacity(0.15),
                  catColor.withOpacity(0.05),
                ],
              ),
            ),
            child: Center(
              child: Text(recipe.icon, style: const TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title[locale] ?? recipe.title['en'] ?? '',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${recipe.nutrition.calories} kcal',
                  style: TextStyle(
                      fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(8),
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
    );
  }
}
