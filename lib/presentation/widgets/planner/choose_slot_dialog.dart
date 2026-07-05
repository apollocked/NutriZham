import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<String?> showChooseSlotDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) {
      final slots = [
        ('breakfast', Icons.wb_sunny_rounded, loc.breakfast),
        ('lunch', Icons.light_mode_rounded, loc.lunch),
        ('dinner', Icons.nightlight_round, loc.dinner),
        ('snack', Icons.cookie_rounded, loc.snack),
      ];

      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Add to meal',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            ...slots.map((slot) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => Navigator.pop(ctx, slot.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.getCategoryColor(slot.$1).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: AppColors.getCategoryColor(slot.$1).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(slot.$2,
                          color: AppColors.getCategoryColor(slot.$1), size: 22),
                      const SizedBox(width: 12),
                      Text(slot.$3,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Theme.of(ctx).colorScheme.onSurface)),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      );
    },
  );
}
