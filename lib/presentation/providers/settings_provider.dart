import 'package:flutter/material.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';
import 'package:nutrizham/core/cache/cache_service.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _languageCode = 'en';
  bool _isLoading = true;
  bool _isLoggedIn = false;

  bool get isDarkMode => _isDarkMode;
  String get languageCode => _languageCode;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initialize() async {
    _isDarkMode = await PreferencesHelper.getIsDarkMode();
    _languageCode = await PreferencesHelper.getLanguageCode();
    _isLoggedIn = await CacheService().getIsLoggedIn();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await PreferencesHelper.setIsDarkMode(value);
    notifyListeners();
  }

  Future<void> setLanguageCode(String code) async {
    _languageCode = code;
    await PreferencesHelper.setLanguageCode(code);
    notifyListeners();
  }

  Future<void> setLoggedIn(bool value) async {
    _isLoggedIn = value;
    await CacheService().setIsLoggedIn(value);
    notifyListeners();
  }

  Future<void> setWelcomeShown() async {
    await PreferencesHelper.setWelcomeShown(true);
  }
}
