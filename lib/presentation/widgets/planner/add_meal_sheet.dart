import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';

class AddMealSheet extends StatelessWidget {
  final List<Recipe> availableRecipes;
  final String slot;

  const AddMealSheet({
    super.key,
    required this.availableRecipes,
    required this.slot,
  });

  static Future<void> show(BuildContext context, List<Recipe> recipes, String slot) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMealSheet(availableRecipes: recipes, slot: slot),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                loc.addMeal,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${availableRecipes.length} ${loc.recipesFound}',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            const Divider(),
            Expanded(
              child: availableRecipes.isEmpty
                  ? Center(
                      child: Text(loc.allMealsPlanned,
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant)))
                  : Material(
                      color: Colors.transparent,
                      child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: availableRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = availableRecipes[index];
                        final locale = Localizations.localeOf(context).languageCode;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.getCategoryColor(recipe.category.name).withValues(alpha: 0.15),
                                    AppColors.getCategoryColor(recipe.category.name).withValues(alpha: 0.05),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(recipe.icon, style: const TextStyle(fontSize: 18)),
                              ),
                            ),
                            title: Text(
                              recipe.title[locale] ?? recipe.title['en'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('${recipe.nutrition.calories} ${AppLocalizations.of(context)!.kcal}'),
                            trailing: const Icon(Icons.add_circle_rounded,
                                color: AppColors.primary, size: 28),
                            onTap: () {
                              context.read<MealPlannerCubit>().addMealToDate(recipe.id, slot);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
