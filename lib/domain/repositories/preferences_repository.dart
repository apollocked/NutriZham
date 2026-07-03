abstract class PreferencesRepository {
  Future<bool> getIsDarkMode();
  Future<void> setIsDarkMode(bool value);
  Future<String> getLanguageCode();
  Future<void> setLanguageCode(String code);
  Future<void> setWelcomeShown(bool shown);
  Future<bool> hasWelcomeBeenShown();
}
