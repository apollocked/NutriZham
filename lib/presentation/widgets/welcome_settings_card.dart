import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/widgets/welcome_language_option.dart';

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
        color: theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary.withOpacity(0.15), theme.colorScheme.primary.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(WelcomeLanguageTexts.darkModeText(selectedLanguage), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface))),
          Switch(value: isDark, onChanged: (v) => context.read<SettingsCubit>().setDarkMode(v), activeColor: theme.colorScheme.primary),
        ]),
        const SizedBox(height: 24),
        Divider(color: theme.colorScheme.outlineVariant, height: 1),
        const SizedBox(height: 24),
        Row(children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary.withOpacity(0.15), theme.colorScheme.primary.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.language_rounded, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(WelcomeLanguageTexts.languageText(selectedLanguage), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface))),
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
