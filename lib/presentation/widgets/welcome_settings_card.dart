import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
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
    final settings = context.watch<SettingsProvider>();
    final isDark = settings.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isDark
                ? const Color(0xFF374151)
                : const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(children: [
        Row(children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(
                  isDark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: theme.colorScheme.primary,
                  size: 24)),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
                  WelcomeLanguageTexts.darkModeText(selectedLanguage),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface))),
          Switch(
              value: isDark,
              onChanged: (v) => settings.setDarkMode(v),
              activeColor: theme.colorScheme.primary),
        ]),
        const SizedBox(height: 24),
        Divider(
            color: isDark
                ? const Color(0xFF374151)
                : const Color(0xFFE5E7EB),
            height: 1),
        const SizedBox(height: 24),
        Row(children: [
          Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.language_rounded,
                  color: Color(0xFF10B981), size: 24)),
          const SizedBox(width: 16),
          Expanded(
              child: Text(
                  WelcomeLanguageTexts.languageText(selectedLanguage),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface))),
        ]),
        const SizedBox(height: 16),
        WelcomeLanguageOption(
          code: 'en',
          name: 'English',
          isSelected: selectedLanguage == 'en',
          onTap: () => onLanguageChanged('en'),
        ),
        const SizedBox(height: 10),
        WelcomeLanguageOption(
          code: 'ku',
          name: 'کوردی',
          isSelected: selectedLanguage == 'ku',
          onTap: () => onLanguageChanged('ku'),
        ),
        const SizedBox(height: 10),
        WelcomeLanguageOption(
          code: 'ar',
          name: 'العربية',
          isSelected: selectedLanguage == 'ar',
          onTap: () => onLanguageChanged('ar'),
        ),
      ]),
    );
  }
}
