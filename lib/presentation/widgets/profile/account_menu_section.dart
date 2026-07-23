import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/common/menu_divider.dart';
import 'package:nutrizham/presentation/widgets/profile/menu_item_tile.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(children: [
          MenuItemTile(icon: Icons.edit_outlined, title: loc.editAccount, onTap: onEditAccount),
          const MenuDivider(),
          MenuItemTile(icon: Icons.delete_outline, title: loc.deleteAccount, onTap: onDeleteAccount, iconColor: theme.colorScheme.error, textColor: theme.colorScheme.error, showTrailing: false),
        ]),
      ),
    );
  }
}
