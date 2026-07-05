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
    final isDarkMode = await PreferencesHelper.getIsDarkMode();
    final languageCode = await PreferencesHelper.getLanguageCode();
    final isLoggedIn = await CacheService().getIsLoggedIn();
    emit(SettingsState(
      isDarkMode: isDarkMode,
      languageCode: languageCode,
      isLoggedIn: isLoggedIn,
    ));
  }

  Future<void> setDarkMode(bool value) async {
    await PreferencesHelper.setIsDarkMode(value);
    emit(SettingsState(
      isDarkMode: value,
      languageCode: state.languageCode,
      isLoggedIn: state.isLoggedIn,
    ));
  }

  Future<void> setLanguageCode(String code) async {
    await PreferencesHelper.setLanguageCode(code);
    emit(SettingsState(
      isDarkMode: state.isDarkMode,
      languageCode: code,
      isLoggedIn: state.isLoggedIn,
    ));
  }

  Future<void> setLoggedIn(bool value) async {
    emit(SettingsState(
      isDarkMode: state.isDarkMode,
      languageCode: state.languageCode,
      isLoggedIn: value,
    ));
    CacheService().setIsLoggedIn(value);
  }

  Future<void> setWelcomeShown() async {
    await PreferencesHelper.setWelcomeShown(true);
  }
}
