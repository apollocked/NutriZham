import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class RecipeSectionHeader extends StatelessWidget {
  final bool showFavoritesOnly;
  final String? customTitle;
  final int count;

  const RecipeSectionHeader({
    super.key,
    required this.showFavoritesOnly,
    this.customTitle,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(customTitle ?? (showFavoritesOnly ? loc.favorites : loc.recipes),
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('$count',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary)),
        ),
      ]),
    );
  }
}
