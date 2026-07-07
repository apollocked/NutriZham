import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/widgets/planner/grocery_day_selector.dart';
import 'package:nutrizham/presentation/widgets/planner/grocery_items_list.dart';

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
        body: Center(child: Text(loc.noPlanLoaded)),
      );
    }

    final mealsForSelectedDays = _collectMeals(state.mealPlans, state.weekStart);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.groceryList),
        actions: [
          if (_selectedDays.length < 7)
            TextButton(
              onPressed: () => setState(() => _selectedDays.addAll({0, 1, 2, 3, 4, 5, 6})),
              child: Text(loc.all, style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.primary)),
            ),
          if (_selectedDays.isNotEmpty)
            TextButton(
              onPressed: () => setState(() => _selectedDays.clear()),
              child: Text(loc.cancel, style: TextStyle(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurfaceVariant)),
            ),
        ],
      ),
      body: Column(
        children: [
          GroceryDaySelector(
            weekStart: state.weekStart,
            selectedDays: _selectedDays,
            onToggle: (i) => setState(() {
              if (_selectedDays.contains(i)) { _selectedDays.remove(i); } else { _selectedDays.add(i); }
            }),
          ),
          const Divider(height: 1),
          Expanded(child: GroceryItemsList(recipes: mealsForSelectedDays, selectedDayCount: _selectedDays.length)),
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
