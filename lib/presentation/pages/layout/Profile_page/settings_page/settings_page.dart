// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/section_header.dart';
import 'package:nutrizham/presentation/widgets/settings/appearance_section.dart';
import 'package:nutrizham/presentation/widgets/profile/account_menu_section.dart';
import 'package:nutrizham/core/utils/connectivity_helper.dart';
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
        SectionHeader(title: loc.accountSettings, padding: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
        AccountMenuSection(
          onEditAccount: () => context.push('/settings/edit-account'),
          onDeleteAccount: () => _deleteAccount(context, loc),
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Appearance', padding: EdgeInsets.fromLTRB(16, 0, 16, 8)),
        const AppearanceSection(),
      ]),
    );
  }

  void _deleteAccount(BuildContext context, AppLocalizations loc) async {
    if (!context.guardOnline()) return;
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
                  foregroundColor: Theme.of(context).colorScheme.error),
              child: Text(loc.delete)),
        ],
      ),
    );
    if (confirmed == true) {
      final result = await context.read<AuthCubit>().deleteAccount();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(result['message']),
              backgroundColor: result['success']
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error),
        );
        if (result['success']) {
          context.read<SettingsCubit>().setLoggedIn(false);
          context.go('/login');
        }
      }
    }
  }
}
