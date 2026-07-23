import 'package:flutter/material.dart';

class PasswordInfoBanner extends StatelessWidget {
  final String message;

  const PasswordInfoBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.info_outline_rounded,
                color: theme.colorScheme.primary, size: 18)),
        const SizedBox(width: 12),
        Expanded(
            child: Text(message,
                style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                    height: 1.5))),
      ]),
    );
  }
}
