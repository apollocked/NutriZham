import 'dart:ui' as ui;
import 'package:nutrizham/core/cache/cache_service.dart';

class PreferencesHelper {
  static final _cache = CacheService();

  static Future<bool> getIsDarkMode() async => _cache.getIsDarkMode();

  static Future<void> setIsDarkMode(bool v) async => _cache.setIsDarkMode(v);

  static Future<String> getLanguageCode() async {
    if (await _cache.isFirstLaunch()) {
      final deviceLanguage = _getDeviceLanguage();
      await _cache.setLanguageCode(deviceLanguage);
      await _cache.setFirstLaunch(false);
      return deviceLanguage;
    }
    return _cache.getLanguageCode();
  }

  static Future<void> setLanguageCode(String v) async =>
      _cache.setLanguageCode(v);

  static String _getDeviceLanguage() {
    final locale = ui.PlatformDispatcher.instance.locale;
    switch (locale.languageCode.toLowerCase()) {
      case 'ku':
      case 'ckb':
        return 'ku';
      case 'ar':
        return 'ar';
      default:
        return 'en';
    }
  }

  static String getDeviceLanguageCode() => _getDeviceLanguage();

  static Future<bool> isFirstLaunch() async => _cache.isFirstLaunch();

  static Future<bool> hasWelcomeBeenShown() async =>
      _cache.hasWelcomeBeenShown();

  static Future<void> setWelcomeShown(bool v) async =>
      _cache.setWelcomeShown(v);

  static Future<void> resetFirstLaunch() async =>
      _cache.setFirstLaunch(true);

  static Future<void> clearAllPreferences() async {
    await _cache.remove('isDarkMode');
    await _cache.remove('languageCode');
  }

  static Future<void> completeReset() async {
    await _cache.remove('isDarkMode');
    await _cache.remove('languageCode');
    await _cache.remove('isFirstLaunch');
    await _cache.remove('welcomeShown');
  }
}
