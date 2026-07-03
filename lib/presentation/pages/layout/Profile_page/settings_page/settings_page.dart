// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/section_header.dart';
import 'package:nutrizham/presentation/widgets/appearance_section.dart';
import 'package:nutrizham/presentation/widgets/account_menu_section.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.settings),
      body: ListView(children: [
        const SizedBox(height: 16),
        SectionHeader(
            title: loc.accountSettings,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            barHeight: 16),
        AccountMenuSection(
          onEditAccount: () => context.push('/settings/edit-account'),
          onDeleteAccount: () => _deleteAccount(context, loc),
        ),
        const SizedBox(height: 24),
        const SectionHeader(
            title: 'Appearance',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            barHeight: 16),
        const AppearanceSection(),
      ]),
    );
  }

  void _deleteAccount(BuildContext context, AppLocalizations loc) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteAccount),
        content: Text(loc.areYouSure),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(loc.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444)),
              child: Text(loc.delete)),
        ],
      ),
    );
    if (confirmed == true) {
      final result = await context.read<AuthProvider>().deleteAccount();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result['message']),
              backgroundColor: result['success']
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error),
        );
        if (result['success']) {
          context.read<SettingsProvider>().setLoggedIn(false);
          context.go('/login');
        }
      }
    }
  }
}
