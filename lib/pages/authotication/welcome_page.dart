import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';

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
    // Detect device language
    final deviceLanguage = PreferencesHelper.getDeviceLanguageCode();

    // Detect system brightness for dark mode suggestion
    final brightness = MediaQuery.of(context).platformBrightness;
    final suggestedDarkMode = brightness == Brightness.dark;

    setState(() {
      _selectedLanguage = deviceLanguage;
      _isDarkMode = suggestedDarkMode;
    });
  }

  Future<void> _continue() async {
    await PreferencesHelper.setLanguageCode(_selectedLanguage);
    await PreferencesHelper.setIsDarkMode(_isDarkMode);
    await PreferencesHelper.setWelcomeShown(true);

    if (!mounted) return;

    // Navigate to login page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginPage(
          isDarkMode: _isDarkMode,
          languageCode: _selectedLanguage,
        ),
      ),
    );
  }

  String _getWelcomeText() {
    switch (_selectedLanguage) {
      case 'ku':
        return 'بەخێربێیت';
      case 'ar':
        return 'مرحباً';
      case 'en':
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
      case 'en':
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
      case 'en':
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
      case 'en':
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
      case 'en':
      default:
        return 'Continue';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor =
        _isDarkMode ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = _isDarkMode ? AppColors.darkText : AppColors.lightText;
    final cardColor = _isDarkMode ? AppColors.darkCard : Colors.white;
    final secondaryTextColor = _isDarkMode
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.primaryGreen.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.restaurant_menu,
                    size: 50,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 32),

                // Welcome Text
                Text(
                  _getWelcomeText(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),

                // App Title
                const Text(
                  'NutriZham',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  _getSubtitleText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 48),

                // Settings Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Dark Mode Toggle
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                              color: AppColors.primaryGreen,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _getDarkModeText(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ),
                          Switch(
                            value: _isDarkMode,
                            onChanged: (value) {
                              setState(() => _isDarkMode = value);
                            },
                            activeColor: AppColors.primaryGreen,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      Divider(
                        color: _isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                        height: 1,
                      ),
                      const SizedBox(height: 20),

                      // Language Selection
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.language,
                              color: AppColors.primaryGreen,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _getLanguageText(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Language Options
                      _buildLanguageOption(
                        'en',
                        'English',
                        textColor,
                        cardColor,
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageOption(
                        'ku',
                        'کوردی',
                        textColor,
                        cardColor,
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageOption(
                        'ar',
                        'العربية',
                        textColor,
                        cardColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _getContinueText(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    String code,
    String name,
    Color textColor,
    Color cardColor,
  ) {
    final isSelected = _selectedLanguage == code;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedLanguage = code);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen.withOpacity(0.1)
              : (_isDarkMode ? AppColors.darkBackground : Colors.grey[50]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : (_isDarkMode
                    ? AppColors.darkDivider
                    : AppColors.lightDivider),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primaryGreen : textColor,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryGreen,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
