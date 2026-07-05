import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/core/utils/category_label.dart';

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
                label: categoryLabel(category, context),
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
