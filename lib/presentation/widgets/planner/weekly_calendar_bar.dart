import 'package:flutter/material.dart';

class WeeklyCalendarBar extends StatelessWidget {
  final DateTime weekStart;
  final DateTime selectedDate;
  final DateTime today;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  const WeeklyCalendarBar({
    super.key,
    required this.weekStart,
    required this.selectedDate,
    required this.today,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left_rounded),
            onPressed: onPreviousWeek,
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: days.map((date) {
                  final isSelected = date.day == selectedDate.day &&
                      date.month == selectedDate.month &&
                      date.year == selectedDate.year;
                  final isToday = date.day == today.day &&
                      date.month == today.month &&
                      date.year == today.year;
                  final dayName = _dayName(date);
                  final dayNum = date.day.toString();

                  return GestureDetector(
                    onTap: () => onDateSelected(date),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : isToday
                                ? theme.colorScheme.primary.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dayName,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dayNum,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right_rounded),
            onPressed: onNextWeek,
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  String _dayName(DateTime date) {
    switch (date.weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}
