import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class AppSupportSection extends StatelessWidget {
  final VoidCallback onSendEmail;

  const AppSupportSection({super.key, required this.onSendEmail});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.support_agent_rounded,
                color: theme.colorScheme.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Text(loc.helpSupport,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.email_rounded,
                color: theme.colorScheme.primary, size: 18),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onSendEmail,
            child: Text('hamabarznji1990@gmail.com',
                style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline)),
          ),
        ]),
      ]),
    );
  }
}
