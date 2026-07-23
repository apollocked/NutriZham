import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionSummaryBar extends StatelessWidget {
  final NutritionalInfo nutrition;

  const NutritionSummaryBar({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniNutrient(context,
              '${nutrition.calories}', AppLocalizations.of(context)!.kcal, AppColors.caloriesColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          _buildMiniNutrient(context,
              '${nutrition.protein}g', AppLocalizations.of(context)!.proteinAbbr, AppColors.proteinColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          _buildMiniNutrient(context, '${nutrition.carbs}g', AppLocalizations.of(context)!.carbsAbbr, AppColors.carbsColor),
          Container(
              height: 30,
              width: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          _buildMiniNutrient(context, '${nutrition.fats}g', AppLocalizations.of(context)!.fatsAbbr, AppColors.fatsColor),
        ],
      ),
    );
  }

  Widget _buildMiniNutrient(BuildContext context, String value, String label, Color color) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7);
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 14, color: color)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: muted)),
      ],
    );
  }
}
