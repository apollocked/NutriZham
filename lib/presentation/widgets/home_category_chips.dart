import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class HomeCategoryChips extends StatelessWidget {
  final MealCategory? selectedCategory;
  final ValueChanged<MealCategory?> onCategorySelected;

  const HomeCategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _Chip(
              label: loc.all,
              selected: selectedCategory == null,
              color: theme.colorScheme.primary,
              onTap: () => onCategorySelected(null),
            ),
          ),
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _Chip(
                  label: _getCategoryName(category, context),
                  selected: selectedCategory == category,
                  color: AppColors.getCategoryColor(
                      category.toString().split('.').last),
                  onTap: () => onCategorySelected(
                      selectedCategory == category ? null : category),
                ),
              )),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      selectedColor: color.withOpacity(0.12),
      labelStyle: TextStyle(
        color: selected ? color : theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected
              ? color
              : theme.colorScheme.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
    );
  }
}
