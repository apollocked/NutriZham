import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/planner/grocery_list_sheet.dart';

class PlannerDateHeader extends StatelessWidget {
  final DateTime selectedDate;
  final List<Recipe> allWeekRecipes;

  const PlannerDateHeader({
    super.key,
    required this.selectedDate,
    required this.allWeekRecipes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (allWeekRecipes.isNotEmpty)
            FilledButton.tonalIcon(
              onPressed: () => GroceryListSheet.show(context, allWeekRecipes),
              icon: const Icon(Icons.shopping_cart_rounded, size: 16),
              label: const Text('Grocery List'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
        ],
      ),
    );
  }
}
