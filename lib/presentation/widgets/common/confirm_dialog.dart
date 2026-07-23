import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? confirmText,
  bool isDestructive = false,
}) async {
  final loc = AppLocalizations.of(context)!;
  final theme = Theme.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(loc.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: isDestructive
              ? TextButton.styleFrom(foregroundColor: theme.colorScheme.error)
              : null,
          child: Text(confirmText ?? loc.exit),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
