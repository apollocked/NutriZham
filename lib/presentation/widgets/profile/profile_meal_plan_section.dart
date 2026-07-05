import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileMealPlanSection extends StatelessWidget {
  final Map<String, List<MealPlanEntry>> mealPlans;
  final List<Recipe> allRecipes;

  const ProfileMealPlanSection({
    super.key,
    required this.mealPlans,
    required this.allRecipes,
  });

  int get _totalPlanned => mealPlans.values.fold(0, (s, e) => s + e.length);

  int _slotCount(String slot) =>
      mealPlans.values.expand((e) => e).where((e) => e.slot == slot).length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    final slots = [
      ('breakfast', Icons.wb_sunny_rounded, loc.breakfast),
      ('lunch', Icons.light_mode_rounded, loc.lunch),
      ('dinner', Icons.nightlight_round, loc.dinner),
      ('snack', Icons.cookie_rounded, loc.snack),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: GestureDetector(
        onTap: () => context.push('/planner'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.08),
                theme.colorScheme.primary.withOpacity(0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4, height: 22,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.4)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(loc.mealPlanner,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                        child: Text('$_totalPlanned ${loc.items}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: slots.map((s) {
                  final count = _slotCount(s.$1);
                  final color = AppColors.getCategoryColor(s.$1);
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: color.withOpacity(count > 0 ? 0.15 : 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(s.$2, color: color.withOpacity(count > 0 ? 1 : 0.3), size: 18),
                        ),
                        const SizedBox(height: 6),
                        Text(s.$3,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onSurfaceVariant)),
                        Text('$count',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                                color: count > 0 ? color : theme.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
