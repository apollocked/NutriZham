import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class CategoryBadge extends StatelessWidget {
  final MealCategory category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final catName = category.toString().split('.').last;
    final color = AppColors.getCategoryColor(catName);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.12), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 7),
          Text(_getCategoryName(category, loc), style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }

  String _getCategoryName(MealCategory category, AppLocalizations loc) {
    switch (category) {
      case MealCategory.breakfast: return loc.breakfast;
      case MealCategory.lunch: return loc.lunch;
      case MealCategory.dinner: return loc.dinner;
      case MealCategory.snack: return loc.snack;
      case MealCategory.bulking: return loc.bulking;
      case MealCategory.cutting: return loc.cutting;
    }
  }
}
