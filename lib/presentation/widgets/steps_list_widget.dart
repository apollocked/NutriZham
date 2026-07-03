import 'package:flutter/material.dart';

class StepsList extends StatelessWidget {
  final List<String> steps;
  const StepsList({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: steps.asMap().entries.map((entry) {
        final stepNumber = entry.key + 1;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary.withOpacity(0.2), theme.colorScheme.primary.withOpacity(0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text('$stepNumber', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(entry.value, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface, height: 1.6)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
