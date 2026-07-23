import 'package:flutter/material.dart';

class WeeklySlotChip extends StatelessWidget {
  final int count;
  final String label;
  final Color color;

  const WeeklySlotChip({super.key, required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text('$count', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
            Text(label, style: TextStyle(fontSize: 9, color: color)),
          ],
        ),
      ),
    );
  }
}
