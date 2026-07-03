import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/menu_item_tile.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileMenuCard extends StatelessWidget {
  final VoidCallback onFeatures;
  final VoidCallback onSettings;
  final VoidCallback onLogout;

  const ProfileMenuCard({
    super.key,
    required this.onFeatures,
    required this.onSettings,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(children: [
        MenuItemTile(icon: Icons.favorite_rounded, title: loc.appFeature, onTap: onFeatures),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Divider(color: theme.colorScheme.outlineVariant, height: 1),
        ),
        MenuItemTile(icon: Icons.settings_outlined, title: loc.settings, onTap: onSettings),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Divider(color: theme.colorScheme.outlineVariant, height: 1),
        ),
        MenuItemTile(icon: Icons.logout_rounded, title: loc.logout, onTap: onLogout, iconColor: theme.colorScheme.error, textColor: theme.colorScheme.error),
      ]),
    );
  }
}
