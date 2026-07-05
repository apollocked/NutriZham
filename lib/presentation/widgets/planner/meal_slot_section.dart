import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/planner/meal_card.dart';
import 'package:nutrizham/presentation/widgets/planner/slot_empty_add.dart';
import 'package:nutrizham/presentation/widgets/planner/slot_header.dart';

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
    final slotColor = AppColors.getCategoryColor(slot.name);
    final slotLabel = SlotHeader.label(slot, loc);

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
          SlotHeader(slot: slot, mealCount: meals.length, isCollapsed: isCollapsed, onTap: onToggleCollapse),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: isCollapsed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: meals.isEmpty
                ? SlotEmpty(slotColor: slotColor, label: slotLabel, onAdd: onAddMeal, tapToBrowse: loc.tapToBrowse)
                : Column(
                    children: [
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        buildDefaultDragHandles: false,
                        itemCount: meals.length,
                        onReorder: onReorder,
                        proxyDecorator: (child, index, animation) => AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) => Material(
                            color: Colors.transparent, elevation: 8,
                            shadowColor: theme.shadowColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                            child: Transform.scale(scale: 1.02, child: child),
                          ),
                          child: child,
                        ),
                        itemBuilder: (context, index) {
                          final recipe = meals[index];
                          return MealCard(
                            key: ValueKey(recipe.id),
                            recipe: recipe, index: index,
                            onRemove: () => onRemoveMeal(recipe.id),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                        child: SlotAddButton(slotColor: slotColor, label: slotLabel, onTap: onAddMeal),
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
