import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class AppSupportSection extends StatelessWidget {
  final VoidCallback onSendEmail;

  const AppSupportSection({super.key, required this.onSendEmail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.support_agent_rounded, color: Color(0xFFF59E0B), size: 20)),
          const SizedBox(width: 12),
          Text(loc.helpSupport, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: theme.colorScheme.onSurface)),
        ]),
        const SizedBox(height: 16),
        Text(loc.contactUs, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14, height: 1.5)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.email_rounded, color: Color(0xFF10B981), size: 18),
            const SizedBox(width: 10),
            InkWell(onTap: onSendEmail, child: const Text('hamabarznji1990@gmail.com', style: TextStyle(color: Color(0xFF10B981), fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.underline))),
          ]),
        ),
      ]),
    );
  }
}
