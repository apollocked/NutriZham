import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/cache/cache_service.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';

class SettingsState {
  final bool isDarkMode;
  final String languageCode;
  final bool isLoggedIn;

  const SettingsState({
    this.isDarkMode = false,
    this.languageCode = 'en',
    this.isLoggedIn = false,
  });
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> initialize() async {
    try {
      final isDarkMode = await PreferencesHelper.getIsDarkMode();
      final languageCode = await PreferencesHelper.getLanguageCode();
      final isLoggedIn = await CacheService().getIsLoggedIn();
      emit(SettingsState(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
        isLoggedIn: isLoggedIn,
      ));
    } catch (_) {}
  }

  Future<void> setDarkMode(bool value) async {
    try {
      await PreferencesHelper.setIsDarkMode(value);
      emit(SettingsState(
        isDarkMode: value,
        languageCode: state.languageCode,
        isLoggedIn: state.isLoggedIn,
      ));
    } catch (_) {}
  }

  Future<void> setLanguageCode(String code) async {
    try {
      await PreferencesHelper.setLanguageCode(code);
      emit(SettingsState(
        isDarkMode: state.isDarkMode,
        languageCode: code,
        isLoggedIn: state.isLoggedIn,
      ));
    } catch (_) {}
  }

  Future<void> setLoggedIn(bool value) async {
    try {
      emit(SettingsState(
        isDarkMode: state.isDarkMode,
        languageCode: state.languageCode,
        isLoggedIn: value,
      ));
      CacheService().setIsLoggedIn(value);
    } catch (_) {}
  }

  Future<void> setWelcomeShown() async {
    try {
      await PreferencesHelper.setWelcomeShown(true);
    } catch (_) {}
  }
}
