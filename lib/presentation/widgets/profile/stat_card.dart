import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/gradient_icon.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          GradientIcon(icon: icon, color: color, size: 24, padding: 12, borderRadius: 14),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 4),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
