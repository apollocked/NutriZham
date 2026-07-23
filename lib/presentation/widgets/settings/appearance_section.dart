import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(children: [
          SwitchListTile(
            secondary: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(settingsState.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: theme.colorScheme.primary, size: 22),
            ),
            title: Text(loc.darkMode, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
            value: settingsState.isDarkMode,
            activeThumbColor: theme.colorScheme.primary,
            onChanged: (value) => context.read<SettingsCubit>().setDarkMode(value),
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
                  colors: [theme.colorScheme.primary.withValues(alpha: 0.15), theme.colorScheme.primary.withValues(alpha: 0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.language_outlined, color: theme.colorScheme.primary, size: 22),
            ),
            title: Text(loc.language, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
            trailing: DropdownButton<String>(
              value: settingsState.languageCode,
              dropdownColor: theme.cardColor,
              underline: Container(height: 0),
              items: [
                DropdownMenuItem(value: 'en', child: Text(loc.english, style: TextStyle(color: theme.colorScheme.onSurface))),
                DropdownMenuItem(value: 'ku', child: Text(loc.kurdish, style: TextStyle(color: theme.colorScheme.onSurface))),
                DropdownMenuItem(value: 'ar', child: Text(loc.arabic, style: TextStyle(color: theme.colorScheme.onSurface))),
              ],
              onChanged: (value) {
                if (value != null) context.read<SettingsCubit>().setLanguageCode(value);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
