import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class NutritionSummaryCard extends StatelessWidget {
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFats;
  final int plannedMealCount;
  final bool hasPlannedMeals;

  const NutritionSummaryCard({
    super.key,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.plannedMealCount,
    required this.hasPlannedMeals,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary.withOpacity(0.05),
          theme.colorScheme.secondary.withOpacity(0.03)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(children: [
        Text(loc.todaysMeals,
            style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outline),
              boxShadow: [
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ]),
          child: Column(children: [
            Text('$totalCalories',
                style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            const Text('kcal',
                style: TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
                '$plannedMealCount ${plannedMealCount == 1 ? loc.recipeFound : loc.recipesFound}',
                style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant, fontSize: 13)),
          ]),
        ),
        const SizedBox(height: 16),
        if (hasPlannedMeals)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.colorScheme.outline)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MacroItem(
                      label: 'Protein',
                      value: '${totalProtein.toStringAsFixed(0)}g',
                      color: const Color(0xFF3B82F6)),
                  Container(
                      width: 1, height: 40, color: theme.colorScheme.outline),
                  _MacroItem(
                      label: 'Carbs',
                      value: '${totalCarbs.toStringAsFixed(0)}g',
                      color: const Color(0xFFF59E0B)),
                  Container(
                      width: 1, height: 40, color: theme.colorScheme.outline),
                  _MacroItem(
                      label: 'Fats',
                      value: '${totalFats.toStringAsFixed(0)}g',
                      color: const Color(0xFF8B5CF6)),
                ]),
          ),
      ]),
    );
  }
}

class _MacroItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MacroItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Text(value,
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w500)),
    ]);
  }
}
