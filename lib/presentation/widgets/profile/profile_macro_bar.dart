import 'package:flutter/material.dart';

class ProfileMacroBar extends StatelessWidget {
  final String label;
  final double value;
  final double goal;
  final double ratio;
  final Color color;

  const ProfileMacroBar({
    super.key,
    required this.label,
    required this.value,
    required this.goal,
    required this.ratio,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${value.toInt()}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: color)),
          Text(label,
              style: TextStyle(fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: color.withValues(alpha: 0.08),
              color: color,
              minHeight: 4,
            ),
          ),
          Text('${goal.toInt()}g',
              style: TextStyle(fontSize: 9,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6))),
        ],
      ),
    );
  }
}
