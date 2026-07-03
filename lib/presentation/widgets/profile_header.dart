import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final int age;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary.withOpacity(0.08),
          theme.colorScheme.secondary.withOpacity(0.04)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
          child: Text(username[0].toUpperCase(),
              style: const TextStyle(
                  fontSize: 36,
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 16),
        Text(username,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Text(email,
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 8),
        Text('${loc.age}: $age',
            style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant, fontSize: 14)),
      ]),
    );
  }
}
