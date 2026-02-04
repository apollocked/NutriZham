import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class PreferencesHelper {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _languageCodeKey = 'languageCode';
  static const String _isFirstLaunchKey = 'isFirstLaunch';
  static const String _welcomeShownKey = 'welcomeShown';

  // Theme Preferences
  static Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  static Future<void> setIsDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  // Language Preferences
  static Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if this is the first launch
    final isFirstLaunch = prefs.getBool(_isFirstLaunchKey) ?? true;

    if (isFirstLaunch) {
      // Get device language
      final deviceLanguage = _getDeviceLanguage();

      // Save the detected language
      await prefs.setString(_languageCodeKey, deviceLanguage);

      // Mark that the app has been launched
      await prefs.setBool(_isFirstLaunchKey, false);

      return deviceLanguage;
    }

    // Return saved language or default to English
    return prefs.getString(_languageCodeKey) ?? 'en';
  }

  static Future<void> setLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);
  }

  // Detect device language
  static String _getDeviceLanguage() {
    // Get the device's locale
    final deviceLocale = ui.PlatformDispatcher.instance.locale;
    final languageCode = deviceLocale.languageCode.toLowerCase();

    // Map device language to supported languages
    // Supported: English (en), Kurdish (ku), Arabic (ar)
    switch (languageCode) {
      case 'ku':
      case 'ckb': // Central Kurdish
        return 'ku';
      case 'ar':
        return 'ar';
      case 'en':
      default:
        return 'en';
    }
  }

  // Get device language without saving (for display purposes)
  static String getDeviceLanguageCode() {
    return _getDeviceLanguage();
  }

  // Check if this is the first launch
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  // Check if welcome page has been shown
  static Future<bool> hasWelcomeBeenShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_welcomeShownKey) ?? false;
  }

  // Set welcome page as shown
  static Future<void> setWelcomeShown(bool shown) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_welcomeShownKey, shown);
  }

  // Reset first launch flag (useful for testing)
  static Future<void> resetFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, true);
  }

  // Clear all preferences
  static Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isDarkModeKey);
    await prefs.remove(_languageCodeKey);
    // Keep the first launch flag to maintain the behavior
  }

  // Complete reset (including first launch flag and welcome shown)
  static Future<void> completeReset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isDarkModeKey);
    await prefs.remove(_languageCodeKey);
    await prefs.remove(_isFirstLaunchKey);
    await prefs.remove(_welcomeShownKey);
  }
}
