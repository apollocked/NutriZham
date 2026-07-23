import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/common/confirm_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return showConfirmDialog(
    context,
    title: loc.logout,
    content: loc.areYouSure,
    confirmText: loc.logout,
    isDestructive: true,
  );
}
