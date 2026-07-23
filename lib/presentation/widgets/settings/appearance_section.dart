import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/common/menu_divider.dart';
import 'package:nutrizham/presentation/widgets/common/gradient_icon.dart';

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
            secondary: GradientIcon(
              icon: settingsState.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: theme.colorScheme.primary,
            ),
            title: Text(loc.darkMode, style: TextStyle(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600)),
            value: settingsState.isDarkMode,
            activeThumbColor: theme.colorScheme.primary,
            onChanged: (value) => context.read<SettingsCubit>().setDarkMode(value),
          ),
          const MenuDivider(),
          ListTile(
            leading: GradientIcon(
              icon: Icons.language_outlined,
              color: theme.colorScheme.primary,
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
