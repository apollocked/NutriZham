import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class CategoryFilterChips extends StatelessWidget {
  final MealCategory? selectedCategory;
  final Function(MealCategory?) onCategorySelected;

  const CategoryFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _ModernFilterChip(
              label: loc.all,
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
              color: theme.colorScheme.primary,
            ),
          ),
          ...MealCategory.values.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _ModernFilterChip(
                label: _getCategoryName(category, context),
                selected: selectedCategory == category,
                onSelected: (selected) {
                  onCategorySelected(selected ? category : null);
                },
                color: AppColors.getCategoryColor(
                    category.toString().split('.').last),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(MealCategory category, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
}

class _ModernFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color color;

  const _ModernFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        selectedColor: color.withOpacity(0.25),
        labelStyle: TextStyle(
          color: selected
              ? color
              : Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: selected
                ? color
                : Theme.of(context).colorScheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
      ),
    );
  }
}
