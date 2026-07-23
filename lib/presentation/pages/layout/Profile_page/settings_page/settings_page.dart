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
import 'package:nutrizham/presentation/widgets/common/confirm_dialog.dart';

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
        SectionHeader(title: loc.appearance, padding: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
        const AppearanceSection(),
      ]),
    );
  }

  void _deleteAccount(BuildContext context, AppLocalizations loc) async {
    if (!context.guardOnline()) return;
    final confirmed = await showConfirmDialog(
      context,
      title: loc.deleteAccount,
      content: loc.areYouSure,
      confirmText: loc.delete,
      isDestructive: true,
    );
    if (confirmed) {
      if (!context.mounted) return;
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
