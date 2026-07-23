import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/gradient_icon.dart';
import 'package:nutrizham/presentation/widgets/settings/welcome_language_option.dart';

class WelcomeSettingsCard extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const WelcomeSettingsCard({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;
    final isDark = settingsState.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(children: [
        Row(children: [
          GradientIcon(
            icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            color: theme.colorScheme.primary,
            size: 24,
            padding: 12,
            borderRadius: 14,
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(AppLocalizations.of(context)!.darkMode, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface))),
          Switch(value: isDark, onChanged: (v) => context.read<SettingsCubit>().setDarkMode(v), activeThumbColor: theme.colorScheme.primary),
        ]),
        const SizedBox(height: 24),
        Divider(color: theme.colorScheme.outlineVariant, height: 1),
        const SizedBox(height: 24),
        Row(children: [
          GradientIcon(
            icon: Icons.language_rounded,
            color: theme.colorScheme.primary,
            size: 24,
            padding: 12,
            borderRadius: 14,
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(AppLocalizations.of(context)!.language, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface))),
        ]),
        const SizedBox(height: 16),
        WelcomeLanguageOption(code: 'en', name: 'English', isSelected: selectedLanguage == 'en', onTap: () => onLanguageChanged('en')),
        const SizedBox(height: 10),
        WelcomeLanguageOption(code: 'ku', name: 'کوردی', isSelected: selectedLanguage == 'ku', onTap: () => onLanguageChanged('ku')),
        const SizedBox(height: 10),
        WelcomeLanguageOption(code: 'ar', name: 'العربية', isSelected: selectedLanguage == 'ar', onTap: () => onLanguageChanged('ar')),
      ]),
    );
  }
}
