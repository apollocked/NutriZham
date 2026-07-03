import 'package:flutter/material.dart';
import 'package:nutrizham/services/preferences_helper.dart';

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

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> setWelcomeShown() async {
    await PreferencesHelper.setWelcomeShown(true);
  }
}
