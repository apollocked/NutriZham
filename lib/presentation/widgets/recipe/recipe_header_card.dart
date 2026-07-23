import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/recipe/category_badge.dart';

class RecipeHeaderCard extends StatelessWidget {
  final Recipe recipe;
  final Color categoryColor;
  final String title;

  const RecipeHeaderCard({
    super.key,
    required this.recipe,
    required this.categoryColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [categoryColor.withValues(alpha: 0.12), categoryColor.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: categoryColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(recipe.icon, style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 16),
          CategoryBadge(category: recipe.category),
          const SizedBox(height: 16),
          Text(title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('${recipe.nutrition.calories} ${AppLocalizations.of(context)!.kcal}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.caloriesColor)),
        ],
      ),
    );
  }
}
