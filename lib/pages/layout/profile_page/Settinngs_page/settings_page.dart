import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/Edit_account_page/edit_account_page.dart';
import 'package:nutrizham/services/Auth_Services/auth_service.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/stat_and_menu_widgets.dart';

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

  // In _deleteAccount method:
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
      final result =
          await _authService.deleteAccount(''); // Empty string or user ID

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor:
              result['success'] ? AppColors.success : AppColors.error,
        ),
      );

      if (result['success']) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginPage(
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
    await PreferencesHelper.setIsDarkMode(isDark);
    widget.onThemeChanged(isDark);
  }

  Future<void> _handleLanguageChanged(String lang) async {
    setState(() {
      _currentLanguage = lang;
    });
    await PreferencesHelper.setLanguageCode(lang);
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
      appBar: CustomAppBar(
        title: loc.settings,
        isDarkMode: _currentDarkMode,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // Account Section
          _buildSectionHeader(loc.accountSettings),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _currentDarkMode
                    ? AppColors.darkDivider
                    : AppColors.lightDivider,
              ),
            ),
            child: Column(
              children: [
                MenuItemTile(
                  icon: Icons.edit_outlined,
                  title: loc.editAccount,
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
                  isDarkMode: _currentDarkMode,
                ),
                Divider(
                    color: _currentDarkMode
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                    height: 1),
                MenuItemTile(
                  icon: Icons.delete_outline,
                  title: loc.deleteAccount,
                  onTap: _deleteAccount,
                  iconColor: AppColors.error,
                  textColor: AppColors.error,
                  showTrailing: false,
                  isDarkMode: _currentDarkMode,
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Appearance Section
          _buildSectionHeader('Appearance'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _currentDarkMode
                    ? AppColors.darkDivider
                    : AppColors.lightDivider,
              ),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: Icon(
                    _currentDarkMode
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
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
                  leading: const Icon(Icons.language_outlined,
                      color: AppColors.primaryGreen),
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
                            Text(loc.kurdish,
                                style: TextStyle(color: textColor)),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(loc.arabic,
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
          fontWeight: FontWeight.w500,
          color: _currentDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
