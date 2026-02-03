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
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_getCategoryName(null)),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
              backgroundColor: Colors.transparent,
              selectedColor: AppColors.primaryGreen.withOpacity(0.1),
              labelStyle: TextStyle(
                color: selectedCategory == null
                    ? AppColors.primaryGreen
                    : (isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selectedCategory == null
                      ? AppColors.primaryGreen
                      : (isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider),
                  width: 1,
                ),
              ),
            ),
          ),
          // Category chips
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_getCategoryName(category)),
                  selected: selectedCategory == category,
                  onSelected: (bool selected) {
                    onCategorySelected(selected ? category : null);
                  },
                  backgroundColor: Colors.transparent,
                  selectedColor: AppColors.primaryGreen.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: selectedCategory == category
                        ? AppColors.primaryGreen
                        : (isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: selectedCategory == category
                          ? AppColors.primaryGreen
                          : (isDarkMode
                              ? AppColors.darkDivider
                              : AppColors.lightDivider),
                      width: 1,
                    ),
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
        color: AppColors.getCategoryColor(category.toString().split('.').last)
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.getCategoryColor(category.toString().split('.').last)
              .withOpacity(0.3),
        ),
      ),
      child: Text(
        _getCategoryName(),
        style: TextStyle(
          color:
              AppColors.getCategoryColor(category.toString().split('.').last),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
