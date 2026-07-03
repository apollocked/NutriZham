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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
        ),
        child: Column(children: [
          SwitchListTile(
            secondary: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary.withOpacity(0.15), theme.colorScheme.primary.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(settings.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: theme.colorScheme.primary, size: 22),
            ),
            title: Text(loc.darkMode, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
            value: settings.isDarkMode,
            activeColor: theme.colorScheme.primary,
            onChanged: (value) => settings.setDarkMode(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Divider(color: theme.colorScheme.outlineVariant, height: 1),
          ),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary.withOpacity(0.15), theme.colorScheme.primary.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.language_outlined, color: theme.colorScheme.primary, size: 22),
            ),
            title: Text(loc.language, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
            trailing: DropdownButton<String>(
              value: settings.languageCode,
              dropdownColor: theme.cardColor,
              underline: Container(height: 0),
              items: [
                DropdownMenuItem(value: 'en', child: Text(loc.english, style: TextStyle(color: theme.colorScheme.onSurface))),
                DropdownMenuItem(value: 'ku', child: Text(loc.kurdish, style: TextStyle(color: theme.colorScheme.onSurface))),
                DropdownMenuItem(value: 'ar', child: Text(loc.arabic, style: TextStyle(color: theme.colorScheme.onSurface))),
              ],
              onChanged: (value) {
                if (value != null) settings.setLanguageCode(value);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
