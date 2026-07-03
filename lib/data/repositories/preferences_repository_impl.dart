import 'package:nutrizham/domain/repositories/preferences_repository.dart';
import 'package:nutrizham/data/datasources/preferences_helper.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  @override
  Future<bool> getIsDarkMode() => PreferencesHelper.getIsDarkMode();

  @override
  Future<void> setIsDarkMode(bool value) =>
      PreferencesHelper.setIsDarkMode(value);

  @override
  Future<String> getLanguageCode() => PreferencesHelper.getLanguageCode();

  @override
  Future<void> setLanguageCode(String code) =>
      PreferencesHelper.setLanguageCode(code);

  @override
  Future<void> setWelcomeShown(bool shown) =>
      PreferencesHelper.setWelcomeShown(shown);

  @override
  Future<bool> hasWelcomeBeenShown() => PreferencesHelper.hasWelcomeBeenShown();
}
