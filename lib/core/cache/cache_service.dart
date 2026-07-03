import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  static final CacheService _instance = CacheService._();
  factory CacheService() => _instance;
  CacheService._();

  SharedPreferences? _prefs;
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> initCalled() async => _prefs != null;

  // SharedPreferences (non-sensitive)
  Future<bool> getBool(String key, {bool d = false}) async =>
      _prefs?.getBool(key) ?? d;

  Future<void> setBool(String key, bool v) async =>
      await _prefs?.setBool(key, v);

  Future<String> getString(String key, {String d = ''}) async =>
      _prefs?.getString(key) ?? d;

  Future<void> setString(String key, String v) async =>
      await _prefs?.setString(key, v);

  Future<List<String>> getStringList(String key) async =>
      _prefs?.getStringList(key) ?? [];

  Future<void> setStringList(String key, List<String> v) async =>
      await _prefs?.setStringList(key, v);

  Future<void> remove(String key) async => await _prefs?.remove(key);

  // FlutterSecureStorage (sensitive - auth)
  Future<String?> getSecure(String key) async => await _secure.read(key: key);

  Future<void> setSecure(String key, String v) async =>
      await _secure.write(key: key, value: v);

  Future<void> removeSecure(String key) async =>
      await _secure.delete(key: key);

  // Convenience: Theme
  static const _isDarkMode = 'isDarkMode';
  Future<bool> getIsDarkMode() async => getBool(_isDarkMode);
  Future<void> setIsDarkMode(bool v) async => setBool(_isDarkMode, v);

  // Convenience: Language
  static const _langCode = 'languageCode';
  Future<String> getLanguageCode() async => getString(_langCode);
  Future<void> setLanguageCode(String v) async => setString(_langCode, v);

  // Convenience: First launch
  static const _firstLaunch = 'isFirstLaunch';
  Future<bool> isFirstLaunch() async =>
      getBool(_firstLaunch, d: true);
  Future<void> setFirstLaunch(bool v) async => setBool(_firstLaunch, v);

  // Convenience: Welcome
  static const _welcomeShown = 'welcomeShown';
  Future<bool> hasWelcomeBeenShown() async => getBool(_welcomeShown);
  Future<void> setWelcomeShown(bool v) async => setBool(_welcomeShown, v);

  // Convenience: Favorites
  static const _favorites = 'favorites';
  Future<List<String>> getFavorites() async => getStringList(_favorites);
  Future<void> setFavorites(List<String> v) async =>
      setStringList(_favorites, v);
  Future<void> removeFavorites() async => remove(_favorites);

  // Convenience: Planned meals
  static const _plannedMeals = 'planned_meals';
  Future<List<String>> getPlannedMeals() async =>
      getStringList(_plannedMeals);
  Future<void> setPlannedMeals(List<String> v) async =>
      setStringList(_plannedMeals, v);
  Future<void> removePlannedMeals() async => remove(_plannedMeals);

  // Convenience: Sync flags
  static const _needsSync = 'needs_sync';
  Future<bool> needsSync() async => getBool(_needsSync);
  Future<void> setNeedsSync(bool v) async => setBool(_needsSync, v);

  static const _plannedSync = 'planned_meals_needs_sync';
  Future<bool> plannedMealsNeedsSync() async => getBool(_plannedSync);
  Future<void> setPlannedMealsNeedsSync(bool v) async =>
      setBool(_plannedSync, v);

  // Secure: Auth session
  static const _currentUser = 'current_user';
  static const _isLoggedIn = 'is_logged_in';
  Future<String?> getCurrentUserJson() async => getSecure(_currentUser);
  Future<void> setCurrentUserJson(String v) async =>
      setSecure(_currentUser, v);
  Future<void> removeCurrentUser() async => removeSecure(_currentUser);

  Future<bool> getIsLoggedIn() async {
    final v = await getSecure(_isLoggedIn);
    return v == 'true';
  }

  Future<void> setIsLoggedIn(bool v) async =>
      setSecure(_isLoggedIn, v.toString());

  Future<void> removeIsLoggedIn() async => removeSecure(_isLoggedIn);

  Future<void> clearAuth() async {
    await removeCurrentUser();
    await removeIsLoggedIn();
  }
}
