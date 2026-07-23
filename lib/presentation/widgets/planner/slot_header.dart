import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/core/utils/category_label.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class SlotHeader extends StatelessWidget {
  final MealCategory slot;
  final int mealCount;
  final bool isCollapsed;
  final VoidCallback onTap;

  const SlotHeader({
    super.key,
    required this.slot,
    required this.mealCount,
    required this.isCollapsed,
    required this.onTap,
  });

  static String label(MealCategory slot, AppLocalizations loc) =>
      categoryLabelFromName(slot.name, loc);

  static IconData icon(MealCategory slot) {
    switch (slot.name) {
      case 'breakfast': return Icons.wb_sunny_rounded;
      case 'lunch': return Icons.light_mode_rounded;
      case 'dinner': return Icons.nightlight_round;
      case 'snack': return Icons.cookie_rounded;
      default: return Icons.restaurant_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final slotColor = AppColors.getCategoryColor(slot.name);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
        child: Row(
          children: [
            Container(
              width: 4, height: 32,
              decoration: BoxDecoration(
                color: slotColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4), bottomRight: Radius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: slotColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon(slot), color: slotColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label(slot, loc),
                  style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: slotColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant_rounded, size: 12, color: slotColor),
                  const SizedBox(width: 4),
                  Text('$mealCount',
                      style: TextStyle(
                          color: slotColor, fontSize: 13, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(width: 6),
            AnimatedRotation(
              duration: const Duration(milliseconds: 250),
              turns: isCollapsed ? 0.5 : 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.expand_more_rounded,
                    size: 18, color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
