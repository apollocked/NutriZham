import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  static final CacheService _instance = CacheService._();
  factory CacheService() => _instance;
  CacheService._();

  SharedPreferences? _prefs;
  late final FlutterSecureStorage _secure;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // Initialize secure storage after Flutter bindings are ready to ensure
    // platform channel handlers are registered. This avoids MissingPluginException
    // when the CacheService is constructed before plugin registration.
    _secure = const FlutterSecureStorage();
  }

  Future<bool> initCalled() async => _prefs != null;

  // SharedPreferences (non-sensitive)
  Future<bool> getBool(String key, {bool d = false}) async {
    try {
      return _prefs?.getBool(key) ?? d;
    } catch (e) {
      return d;
    }
  }

  Future<void> setBool(String key, bool v) async {
    try {
      await _prefs?.setBool(key, v);
    } catch (_) {}
  }

  Future<String> getString(String key, {String d = ''}) async {
    try {
      return _prefs?.getString(key) ?? d;
    } catch (e) {
      return d;
    }
  }

  Future<void> setString(String key, String v) async {
    try {
      await _prefs?.setString(key, v);
    } catch (_) {}
  }

  Future<List<String>> getStringList(String key) async {
    try {
      return _prefs?.getStringList(key) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> setStringList(String key, List<String> v) async {
    try {
      await _prefs?.setStringList(key, v);
    } catch (_) {}
  }

  Future<void> remove(String key) async {
    try {
      await _prefs?.remove(key);
    } catch (_) {}
  }

  // FlutterSecureStorage (sensitive - auth tokens only)
  Future<String?> getSecure(String key) async {
    try {
      return await _secure.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> setSecure(String key, String v) async {
    try {
      await _secure.write(key: key, value: v);
    } catch (_) {}
  }

  Future<void> removeSecure(String key) async {
    try {
      await _secure.delete(key: key);
    } catch (_) {}
  }

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
  Future<bool> isFirstLaunch() async => getBool(_firstLaunch, d: true);
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
  Future<List<String>> getPlannedMeals() async => getStringList(_plannedMeals);
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

  // Auth session (secure storage — sensitive)
  static const _isLoggedIn = 'is_logged_in';
  static const _currentUser = 'current_user';
  Future<bool> getIsLoggedIn() async {
    final v = await getSecure(_isLoggedIn);
    return v == 'true';
  }
  Future<void> setIsLoggedIn(bool v) async =>
      setSecure(_isLoggedIn, v.toString());
  Future<void> removeIsLoggedIn() async => removeSecure(_isLoggedIn);

  Future<String?> getCurrentUserJson() async => getSecure(_currentUser);
  Future<void> setCurrentUserJson(String v) async => setSecure(_currentUser, v);
  Future<void> removeCurrentUser() async => removeSecure(_currentUser);

  Future<void> clearAuth() async {
    await removeIsLoggedIn();
    await removeCurrentUser();
  }
}
