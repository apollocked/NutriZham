import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class GroceryDaySelector extends StatelessWidget {
  final DateTime weekStart;
  final Set<int> selectedDays;
  final ValueChanged<int> onToggle;

  const GroceryDaySelector({
    super.key,
    required this.weekStart,
    required this.selectedDays,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final labels = [loc.dayMon, loc.dayTue, loc.dayWed, loc.dayThu, loc.dayFri, loc.daySat, loc.daySun];

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
                color: isSelected
                    ? theme.colorScheme.primary.withValues(alpha: 0.12)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(labels[i], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 2),
                  Text('${day.day}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
