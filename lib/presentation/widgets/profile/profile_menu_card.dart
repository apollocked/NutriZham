import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/menu_divider.dart';
import 'package:nutrizham/presentation/widgets/profile/menu_item_tile.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(children: [
          MenuItemTile(icon: Icons.favorite_rounded, title: loc.appFeature, onTap: onFeatures),
          const MenuDivider(),
          MenuItemTile(icon: Icons.settings_outlined, title: loc.settings, onTap: onSettings),
          const MenuDivider(),
          MenuItemTile(icon: Icons.logout_rounded, title: loc.logout, onTap: onLogout, iconColor: theme.colorScheme.error, textColor: theme.colorScheme.error),
        ]),
      ),
    );
  }
}
