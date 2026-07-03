import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/menu_item_tile.dart';

class AccountMenuSection extends StatelessWidget {
  final VoidCallback onEditAccount;
  final VoidCallback onDeleteAccount;

  const AccountMenuSection({
    super.key,
    required this.onEditAccount,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outline)),
      child: Column(children: [
        MenuItemTile(
            icon: Icons.edit_outlined,
            title: loc.editAccount,
            onTap: onEditAccount),
        Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
        MenuItemTile(
            icon: Icons.delete_outline,
            title: loc.deleteAccount,
            onTap: onDeleteAccount,
            iconColor: const Color(0xFFEF4444),
            textColor: const Color(0xFFEF4444),
            showTrailing: false),
      ]),
    );
  }
}
