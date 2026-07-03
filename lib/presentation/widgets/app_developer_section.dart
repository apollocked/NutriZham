import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class AppDeveloperSection extends StatelessWidget {
  const AppDeveloperSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.developer_mode_rounded, color: Color(0xFF10B981), size: 20)),
          const SizedBox(width: 12),
          Text(loc.developedBy, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: theme.colorScheme.onSurface)),
        ]),
        const SizedBox(height: 16),
        Text(loc.descriptionFlutterFirebase, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14, height: 1.6)),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.code_rounded, color: Color(0xFF3B82F6), size: 16),
            SizedBox(width: 8),
            Text('Flutter • Firebase • Dart', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13, fontWeight: FontWeight.w500)),
          ])),
      ]),
    );
  }
}
