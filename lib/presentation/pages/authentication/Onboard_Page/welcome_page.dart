import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';
import 'package:nutrizham/presentation/widgets/welcome/welcome_header.dart';
import 'package:nutrizham/presentation/widgets/settings/welcome_settings_card.dart';

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
    final settingsCubit = context.read<SettingsCubit>();
    final go = context.go;
    await PreferencesHelper.setLanguageCode(_selectedLanguage);
    await PreferencesHelper.setWelcomeShown(true);
    if (!mounted) return;

    await settingsCubit.setDarkMode(settingsCubit.state.isDarkMode);
    await settingsCubit.setLanguageCode(_selectedLanguage);

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
                const WelcomeHeader(),
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
                    child: Text(AppLocalizations.of(context)!.continue_text, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600)),
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
