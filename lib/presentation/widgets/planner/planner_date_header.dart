import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PlannerDateHeader extends StatelessWidget {
  final DateTime selectedDate;
  final bool hasMeals;
  final VoidCallback onGroceryList;

  const PlannerDateHeader({
    super.key,
    required this.selectedDate,
    required this.hasMeals,
    required this.onGroceryList,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          if (hasMeals)
            FilledButton.tonalIcon(
              onPressed: onGroceryList,
              icon: const Icon(Icons.shopping_cart_rounded, size: 16),
              label: Text(loc.groceryList),
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
