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
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outline)),
      child: Column(children: [
        MenuItemTile(
            icon: Icons.favorite_rounded,
            title: loc.appFeature,
            onTap: onFeatures),
        Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
        MenuItemTile(
            icon: Icons.settings_outlined,
            title: loc.settings,
            onTap: onSettings),
        Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
        MenuItemTile(
            icon: Icons.logout,
            title: loc.logout,
            onTap: onLogout,
            iconColor: const Color(0xFFEF4444),
            textColor: const Color(0xFFEF4444)),
      ]),
    );
  }
}
