import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<String?> showChooseSlotDialog(
  BuildContext context, {
  required String recipeTitle,
  Set<String> addedSlots = const {},
}) {
  final loc = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  final slots = [
    ('breakfast', Icons.wb_sunny_rounded, loc.breakfast),
    ('lunch', Icons.light_mode_rounded, loc.lunch),
    ('dinner', Icons.nightlight_round, loc.dinner),
    ('snack', Icons.cookie_rounded, loc.snack),
  ];

  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.restaurant_rounded,
                color: theme.colorScheme.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(recipeTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(loc.addToMeal,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 20),
          ...slots.map((slot) {
            final added = addedSlots.contains(slot.$1);
            final slotColor = AppColors.getCategoryColor(slot.$1);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.pop(ctx, slot.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    decoration: BoxDecoration(
                      color: added
                          ? slotColor.withOpacity(0.12)
                          : slotColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: added ? slotColor.withOpacity(0.5) : slotColor.withOpacity(0.15),
                        width: added ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(added ? Icons.check_circle_rounded : slot.$2,
                            color: added ? slotColor : slotColor.withOpacity(0.7), size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(slot.$3,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface)),
                        ),
                        if (added)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: slotColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(loc.added,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: slotColor)),
                          )
                        else
                          Icon(Icons.add_rounded,
                              color: slotColor.withOpacity(0.5), size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.cancel,
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    ),
  );
}
