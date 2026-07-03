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
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGreen.withOpacity(0.12),
                        AppColors.primaryGreenLight.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppColors.primaryGreen.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    'assets/logo/app_logo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 36),

                Text(
                  _getWelcomeText(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  'NutriZham',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreen,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  _getSubtitleText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryTextColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
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
                                fontWeight: FontWeight.w600,
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
                      const SizedBox(height: 24),

                      Divider(
                        color: _isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                        height: 1,
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.language_rounded,
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
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildLanguageOption(
                        'en',
                        'English',
                        textColor,
                        cardColor,
                      ),
                      const SizedBox(height: 10),
                      _buildLanguageOption(
                        'ku',
                        'کوردی',
                        textColor,
                        cardColor,
                      ),
                      const SizedBox(height: 10),
                      _buildLanguageOption(
                        'ar',
                        'العربية',
                        textColor,
                        cardColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: AppColors.primaryGreen.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _getContinueText(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryGreen.withOpacity(0.1)
              : (_isDarkMode ? AppColors.darkBackground : Colors.grey[50]),
          borderRadius: BorderRadius.circular(14),
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
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                code == 'en'
                    ? Icons.language
                    : code == 'ku'
                        ? Icons.translate
                        : Icons.translate,
                size: 20,
                color: isSelected ? AppColors.primaryGreen : textColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 12),
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
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
