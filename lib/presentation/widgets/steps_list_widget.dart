import 'package:flutter/material.dart';

class StepsList extends StatelessWidget {
  final List<String> steps;

  const StepsList({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: steps.asMap().entries.map((entry) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.colorScheme.outline)),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF10B981),
                          Color(0xFF059669)
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text('${entry.key + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13))),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Text(entry.value,
                            style: TextStyle(
                                fontSize: 15,
                                color: theme.colorScheme.onSurface,
                                height: 1.4))),
                  ]),
            )).toList());
  }
}
