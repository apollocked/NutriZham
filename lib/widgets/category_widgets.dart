import 'package:flutter/material.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_localizations.dart';

class CategoryFilterChips extends StatelessWidget {
  final MealCategory? selectedCategory;
  final Function(MealCategory?) onCategorySelected;
  final bool isDarkMode;
  final String languageCode;

  const CategoryFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.isDarkMode,
    required this.languageCode,
  });

  String _getCategoryName(MealCategory? category) {
    final loc = AppLocalizations.of(languageCode);
    if (category == null) return loc.all;
    
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

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getCategoryName(null)),
              selected: selectedCategory == null,
              backgroundColor: isDarkMode ? AppColors.darkCard : Colors.grey[200],
              selectedColor: AppColors.primaryGreen,
              labelStyle: TextStyle(
                color: selectedCategory == null ? Colors.white : textColor,
                fontWeight: selectedCategory == null ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => onCategorySelected(null),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide.none,
              ),
            ),
          ),
          // Category chips
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(_getCategoryName(category)),
                  selected: selectedCategory == category,
                  backgroundColor: isDarkMode ? AppColors.darkCard : Colors.grey[200],
                  selectedColor: AppColors.primaryGreen,
                  labelStyle: TextStyle(
                    color: selectedCategory == category ? Colors.white : textColor,
                    fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (bool selected) {
                    onCategorySelected(selected ? category : null);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final MealCategory category;
  final String languageCode;

  const CategoryBadge({
    super.key,
    required this.category,
    required this.languageCode,
  });

  String _getCategoryName() {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.getCategoryColor(category.toString().split('.').last),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getCategoryName(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
