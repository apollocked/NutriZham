import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<bool?> showLogoutDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(loc.logout),
      content: Text(loc.areYouSure),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(loc.cancel)),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error),
            child: Text(loc.logout)),
      ],
    ),
  );
}
