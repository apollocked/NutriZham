import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();

    return Container(
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
    );
  }
}
