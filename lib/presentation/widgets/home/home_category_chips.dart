import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/core/utils/category_label.dart';

class HomeCategoryChips extends StatelessWidget {
  final MealCategory? selectedCategory;
  final ValueChanged<MealCategory?> onCategorySelected;

  const HomeCategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

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
                  label: categoryLabel(category, context),
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
      selectedColor: color.withValues(alpha: 0.25),
      labelStyle: TextStyle(
        color: selected ? color : theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      visualDensity: VisualDensity.compact,
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
