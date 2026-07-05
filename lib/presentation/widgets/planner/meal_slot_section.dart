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
        case 'breakfast': return loc.breakfast;
        case 'lunch': return loc.lunch;
        case 'dinner': return loc.dinner;
        case 'snack': return loc.snack;
        default: return key;
      }
    }

    IconData slotIcon(String key) {
      switch (key) {
        case 'breakfast': return Icons.wb_sunny_rounded;
        case 'lunch': return Icons.light_mode_rounded;
        case 'dinner': return Icons.nightlight_round;
        case 'snack': return Icons.cookie_rounded;
        default: return Icons.restaurant_rounded;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggleCollapse,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                      color: slotColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 34,
                    height: 34,
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
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: slotColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restaurant_rounded, size: 12, color: slotColor),
                        const SizedBox(width: 4),
                        Text(
                          '${meals.length}',
                          style: TextStyle(
                            color: slotColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 250),
                    turns: isCollapsed ? 0.5 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.expand_more_rounded,
                        size: 18,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: isCollapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: meals.isEmpty
                ? _EmptySlot(slotColor: slotColor, label: slotLabel(slotKey), onAdd: onAddMeal)
                : Column(
                    children: [
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        buildDefaultDragHandles: false,
                        itemCount: meals.length,
                        onReorder: onReorder,
                        proxyDecorator: (child, index, animation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Material(
                                color: Colors.transparent,
                                elevation: 8,
                                shadowColor: theme.shadowColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16),
                                child: Transform.scale(
                                  scale: 1.02,
                                  child: child,
                                ),
                              );
                            },
                            child: child,
                          );
                        },
                        itemBuilder: (context, index) {
                          final recipe = meals[index];
                          return _MealCard(
                            key: ValueKey(recipe.id),
                            recipe: recipe,
                            index: index,
                            onRemove: () => onRemoveMeal(recipe.id),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                        child: _AddMealButton(slotColor: slotColor, label: slotLabel(slotKey), onTap: onAddMeal),
                      ),
                    ],
                  ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  final Color slotColor;
  final String label;
  final VoidCallback onAdd;

  const _EmptySlot({
    required this.slotColor,
    required this.label,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: GestureDetector(
        onTap: onAdd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: slotColor.withOpacity(0.25),
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            color: slotColor.withOpacity(0.04),
          ),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: slotColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add_rounded, size: 24, color: slotColor),
              ),
              const SizedBox(height: 10),
              Text(
                'Add $label',
                style: TextStyle(
                  color: slotColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to browse recipes',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddMealButton extends StatelessWidget {
  final Color slotColor;
  final String label;
  final VoidCallback onTap;

  const _AddMealButton({
    required this.slotColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: slotColor.withOpacity(0.06),
          border: Border.all(color: slotColor.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: slotColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_rounded, size: 16, color: slotColor),
            ),
            const SizedBox(width: 8),
            Text(
              'Add $label',
              style: TextStyle(
                color: slotColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Recipe recipe;
  final int index;
  final VoidCallback onRemove;

  const _MealCard({
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.4)),
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
                      child: Icon(
                        Icons.drag_indicator_rounded,
                        size: 18,
                        color: catColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 4,
                  color: catColor,
                ),
                const SizedBox(width: 10),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [catColor.withOpacity(0.15), catColor.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(recipe.icon, style: const TextStyle(fontSize: 20)),
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
                              size: 12, color: AppColors.caloriesColor.withOpacity(0.7)),
                          const SizedBox(width: 3),
                          Text(
                            '${recipe.nutrition.calories} kcal',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.caloriesColor.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(width: 10),
                          _MiniMacro(label: 'P', value: '${recipe.nutrition.protein.toStringAsFixed(0)}g', color: AppColors.proteinColor),
                          const SizedBox(width: 6),
                          _MiniMacro(label: 'C', value: '${recipe.nutrition.carbs.toStringAsFixed(0)}g', color: AppColors.carbsColor),
                          const SizedBox(width: 6),
                          _MiniMacro(label: 'F', value: '${recipe.nutrition.fats.toStringAsFixed(0)}g', color: AppColors.fatsColor),
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
                    child: const Icon(Icons.close_rounded, size: 16, color: AppColors.error),
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

class _MiniMacro extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniMacro({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label $value',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
