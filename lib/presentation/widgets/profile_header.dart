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
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary.withOpacity(0.10), theme.colorScheme.primary.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.08)),
      ),
      child: Column(children: [
        Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary.withOpacity(0.2), theme.colorScheme.primary.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  username[0].toUpperCase(),
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(username, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(email, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: theme.colorScheme.primary)),
        ),
        const SizedBox(height: 6),
        Text('${loc.age}: $age', style: theme.textTheme.bodySmall),
      ]),
    );
  }
}
