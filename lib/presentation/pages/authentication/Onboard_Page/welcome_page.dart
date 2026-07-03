// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _detectDeviceSettings();
  }

  Future<void> _detectDeviceSettings() async {
    final deviceLanguage = PreferencesHelper.getDeviceLanguageCode();
    final brightness = MediaQuery.of(context).platformBrightness;
    if (mounted) {
      setState(() {
        _selectedLanguage = deviceLanguage;
        _isDarkMode = brightness == Brightness.dark;
      });
    }
  }

  Future<void> _continue() async {
    await PreferencesHelper.setLanguageCode(_selectedLanguage);
    await PreferencesHelper.setIsDarkMode(_isDarkMode);
    final settings = context.read<SettingsProvider>();
    await PreferencesHelper.setWelcomeShown(true);
    if (!mounted) return;

    await settings.setDarkMode(_isDarkMode);
    await settings.setLanguageCode(_selectedLanguage);

    context.go('/login');
  }

  String _getWelcomeText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'بەخێربێیت';
      case 'ar':
        return 'مرحباً';
      default:
        return 'Welcome';
    }
  }

  String _getSubtitleText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'تکایە زمان و دۆخی پێشنیارکراوت هەڵبژێرە';
      case 'ar':
        return 'الرجاء اختيار اللغة والوضع المفضل';
      default:
        return 'Please select your preferred language and theme';
    }
  }

  String _getDarkModeText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'دۆخی تاریک';
      case 'ar':
        return 'الوضع المظلم';
      default:
        return 'Dark Mode';
    }
  }

  String _getLanguageText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'زمان';
      case 'ar':
        return 'اللغة';
      default:
        return 'Language';
    }
  }

  String _getContinueText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'بەردەوامبوون';
      case 'ar':
        return 'متابعة';
      default:
        return 'Continue';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = _isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.12),
                        theme.colorScheme.secondary.withOpacity(0.08)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        width: 2),
                  ),
                  child: Image.asset('assets/logo/app_logo.png',
                      width: 40, height: 40),
                ),
                const SizedBox(height: 36),
                Text(_getWelcomeText(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface)),
                const SizedBox(height: 8),
                const Text('NutriZham',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF10B981),
                        letterSpacing: -0.5)),
                const SizedBox(height: 16),
                Text(_getSubtitleText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4)),
                const SizedBox(height: 40),
                Container(
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
                          child: Text(_getDarkModeText(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface))),
                      Switch(
                          value: _isDarkMode,
                          onChanged: (v) => setState(() => _isDarkMode = v),
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
                          child: Text(_getLanguageText(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface))),
                    ]),
                    const SizedBox(height: 16),
                    _buildLanguageOption('en', 'English'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('ku', 'کوردی'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('ar', 'العربية'),
                  ]),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(_getContinueText(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name) {
    final isSelected = _selectedLanguage == code;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : (_isDarkMode ? const Color(0xFF111827) : Colors.grey[50]),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : (_isDarkMode
                    ? const Color(0xFF374151)
                    : const Color(0xFFE5E7EB)),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(code == 'en' ? Icons.language : Icons.translate,
                size: 20,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5)),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface))),
          if (isSelected)
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 16)),
        ]),
      ),
    );
  }
}
