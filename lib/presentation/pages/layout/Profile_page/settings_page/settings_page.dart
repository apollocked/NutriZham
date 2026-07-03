// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/menu_item_tile.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: loc.settings),
      body: ListView(children: [
        const SizedBox(height: 16),
        _buildSectionHeader(loc.accountSettings, theme),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outline)),
          child: Column(children: [
            MenuItemTile(
                icon: Icons.edit_outlined,
                title: loc.editAccount,
                onTap: () => context.push('/settings/edit-account')),
            Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
            MenuItemTile(
                icon: Icons.delete_outline,
                title: loc.deleteAccount,
                onTap: () => _deleteAccount(context, loc),
                iconColor: const Color(0xFFEF4444),
                textColor: const Color(0xFFEF4444),
                showTrailing: false),
          ]),
        ),
        const SizedBox(height: 24),
        _buildSectionHeader('Appearance', theme),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.colorScheme.outline)),
          child: Column(children: [
            SwitchListTile(
              secondary: Icon(
                  settings.isDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: theme.colorScheme.primary),
              title: Text(loc.darkMode,
                  style: TextStyle(color: theme.colorScheme.onSurface)),
              value: settings.isDarkMode,
              activeColor: theme.colorScheme.primary,
              onChanged: (value) => settings.setDarkMode(value),
            ),
            Divider(color: theme.colorScheme.outline, height: 1),
            ListTile(
              leading:
                  const Icon(Icons.language_outlined, color: Color(0xFF10B981)),
              title: Text(loc.language,
                  style: TextStyle(color: theme.colorScheme.onSurface)),
              trailing: DropdownButton<String>(
                value: settings.languageCode,
                dropdownColor: theme.cardColor,
                underline: Container(height: 0),
                items: [
                  DropdownMenuItem(
                      value: 'en',
                      child: Text(loc.english,
                          style:
                              TextStyle(color: theme.colorScheme.onSurface))),
                  DropdownMenuItem(
                      value: 'ku',
                      child: Text(loc.kurdish,
                          style:
                              TextStyle(color: theme.colorScheme.onSurface))),
                  DropdownMenuItem(
                      value: 'ar',
                      child: Text(loc.arabic,
                          style:
                              TextStyle(color: theme.colorScheme.onSurface))),
                ],
                onChanged: (value) {
                  if (value != null) settings.setLanguageCode(value);
                },
              ),
            ),
          ]),
        ),
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

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: [
        Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.5)),
      ]),
    );
  }
}
