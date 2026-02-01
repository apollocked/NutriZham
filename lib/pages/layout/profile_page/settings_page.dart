import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/pages/profile_page/edit_account_page.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _authService = AuthService();
  bool _currentDarkMode = false;
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _currentDarkMode = widget.isDarkMode;
    _currentLanguage = widget.languageCode;
  }

  Future<void> _deleteAccount() async {
    final loc = AppLocalizations.of(_currentLanguage);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteAccount),
        content: Text(loc.areYouSure),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(loc.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        await _authService.deleteAccount(user.id);
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginPageRefactored(
              isDarkMode: _currentDarkMode,
              languageCode: _currentLanguage,
            ),
          ),
          (route) => false,
        );
      }
    }
  }

  Future<void> _handleThemeChanged(bool isDark) async {
    setState(() {
      _currentDarkMode = isDark;
    });
    await PreferencesHelper.setIsDarkMode(isDark); // Use PreferencesHelper
    widget.onThemeChanged(isDark);
  }

  Future<void> _handleLanguageChanged(String lang) async {
    setState(() {
      _currentLanguage = lang;
    });
    await PreferencesHelper.setLanguageCode(lang); // Use PreferencesHelper
    widget.onLanguageChanged(lang);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(_currentLanguage);
    final bgColor =
        _currentDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        _currentDarkMode ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(loc.settings),
        backgroundColor:
            _currentDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // Account Section
          _buildSectionHeader(loc.accountSettings),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: _currentDarkMode ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.edit, color: AppColors.primaryGreen),
                  title:
                      Text(loc.editAccount, style: TextStyle(color: textColor)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditAccountPage(
                          isDarkMode: _currentDarkMode,
                          languageCode: _currentLanguage,
                        ),
                      ),
                    );
                  },
                ),
                Divider(
                    color: _currentDarkMode
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                    height: 1),
                ListTile(
                  leading:
                      const Icon(Icons.delete_forever, color: AppColors.error),
                  title: Text(loc.deleteAccount,
                      style: const TextStyle(color: AppColors.error)),
                  onTap: _deleteAccount,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Appearance Section
          _buildSectionHeader('Appearance'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: _currentDarkMode ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: Icon(
                    _currentDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: AppColors.primaryGreen,
                  ),
                  title: Text(loc.darkMode, style: TextStyle(color: textColor)),
                  value: _currentDarkMode,
                  activeColor: AppColors.primaryGreen,
                  onChanged: _handleThemeChanged,
                ),
                Divider(
                    color: _currentDarkMode
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                    height: 1),
                ListTile(
                  leading:
                      const Icon(Icons.language, color: AppColors.primaryGreen),
                  title: Text(loc.language, style: TextStyle(color: textColor)),
                  trailing: DropdownButton<String>(
                    value: _currentLanguage,
                    dropdownColor:
                        _currentDarkMode ? AppColors.darkCard : Colors.white,
                    underline: Container(height: 0),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🇬🇧 '),
                            Text(loc.english,
                                style: TextStyle(color: textColor)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ku',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🇹🇯 '),
                            Text(loc.kurdish,
                                style: TextStyle(color: textColor)),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _handleLanguageChanged(value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _currentDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
