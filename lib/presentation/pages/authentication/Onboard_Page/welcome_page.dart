import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';
import 'package:nutrizham/presentation/widgets/welcome_header.dart';
import 'package:nutrizham/presentation/widgets/welcome_settings_card.dart';
import 'package:nutrizham/presentation/widgets/welcome_language_option.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _detectDeviceSettings();
  }

  Future<void> _detectDeviceSettings() async {
    final deviceLanguage = PreferencesHelper.getDeviceLanguageCode();
    if (mounted) setState(() => _selectedLanguage = deviceLanguage);
  }

  Future<void> _continue() async {
    final settings = context.read<SettingsProvider>();
    final go = context.go;
    await PreferencesHelper.setLanguageCode(_selectedLanguage);
    await PreferencesHelper.setWelcomeShown(true);
    if (!mounted) return;

    await settings.setDarkMode(settings.isDarkMode);
    await settings.setLanguageCode(_selectedLanguage);

    go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeHeader(languageCode: _selectedLanguage),
                const SizedBox(height: 40),
                WelcomeSettingsCard(selectedLanguage: _selectedLanguage, onLanguageChanged: (code) => setState(() => _selectedLanguage = code)),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    onPressed: _continue,
                    child: Text(WelcomeLanguageTexts.continueText(_selectedLanguage), style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
