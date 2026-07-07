import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';

class GroceryListPage extends StatefulWidget {
  final List<Recipe> allRecipes;

  const GroceryListPage({super.key, required this.allRecipes});

  @override
  State<GroceryListPage> createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  final _selectedDays = <int>{0, 1, 2, 3, 4, 5, 6};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final state = context.watch<MealPlannerCubit>().state;
    if (state is! PlannerLoaded) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.groceryList)),
        body: const Center(child: Text('No plan loaded')),
      );
    }

    final weekStart = state.weekStart;
    final mealsForSelectedDays = _collectMeals(state.mealPlans, weekStart);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.groceryList),
        actions: [
          if (_selectedDays.length < 7)
            TextButton(
              onPressed: () => setState(() => _selectedDays.addAll({0, 1, 2, 3, 4, 5, 6})),
              child: Text(loc.all,
                  style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
            ),
          if (_selectedDays.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _selectedDays.clear()),
              child: Text(loc.cancel,
                  style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurfaceVariant)),
            ),
        ],
      ),
      body: Column(
        children: [
          _DaySelector(
            weekStart: weekStart,
            selectedDays: _selectedDays,
            onToggle: (i) => setState(() {
              if (_selectedDays.contains(i)) {
                _selectedDays.remove(i);
              } else {
                _selectedDays.add(i);
              }
            }),
          ),
          const Divider(height: 1),
          Expanded(child: _GroceryItems(recipes: mealsForSelectedDays)),
        ],
      ),
    );
  }

  List<Recipe> _collectMeals(Map<String, List<MealPlanEntry>> mealPlans, DateTime weekStart) {
    final recipeIds = <String>{};
    final recipes = <Recipe>[];
    for (int i = 0; i < 7; i++) {
      if (!_selectedDays.contains(i)) continue;
      final day = weekStart.add(Duration(days: i));
      final key = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      for (final entry in (mealPlans[key] ?? [])) {
        if (recipeIds.add(entry.recipeId)) {
          final r = widget.allRecipes.where((x) => x.id == entry.recipeId);
          if (r.isNotEmpty) recipes.add(r.first);
        }
      }
    }
    return recipes;
  }
}

class _DaySelector extends StatelessWidget {
  final DateTime weekStart;
  final Set<int> selectedDays;
  final ValueChanged<int> onToggle;

  const _DaySelector({
    required this.weekStart,
    required this.selectedDays,
    required this.onToggle,
  });

  static const _dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: 7,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          final day = weekStart.add(Duration(days: i));
          final isSelected = selectedDays.contains(i);
          return GestureDetector(
            onTap: () => onToggle(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary.withOpacity(0.12) : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _dayLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GroceryItems extends StatelessWidget {
  final List<Recipe> recipes;

  const _GroceryItems({required this.recipes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    final allIngredients = <String>{};
    for (final recipe in recipes) {
      final ings = recipe.ingredients[locale] ??
          recipe.ingredients['en'] ??
          <String>[];
      allIngredients.addAll(ings);
    }

    final sorted = allIngredients.toList()..sort();

    if (sorted.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_rounded, size: 48, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3)),
            const SizedBox(height: 12),
            Text(loc.noMealsPlanned, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shopping_cart_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(loc.groceryList, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${sorted.length} ${loc.items}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 24, height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.check_rounded, size: 14, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(sorted[index], style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
