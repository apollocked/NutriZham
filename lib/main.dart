import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/providers/meal_planner_provider.dart';
import 'package:nutrizham/presentation/providers/recipe_provider.dart';
import 'package:nutrizham/presentation/router/app_router.dart';
import 'package:nutrizham/core/themes/app_theme.dart';
import 'package:nutrizham/data/datasources/favorites_helper.dart';
import 'package:nutrizham/data/datasources/meal_planner_service.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/utils/locale_helpers.dart';
import 'package:nutrizham/core/cache/cache_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheService().init();
  runApp(const NutriZhamApp());
}

class NutriZhamApp extends StatefulWidget {
  const NutriZhamApp({super.key});

  @override
  State<NutriZhamApp> createState() => _NutriZhamAppState();
}

class _NutriZhamAppState extends State<NutriZhamApp> {
  late final SettingsProvider _settingsProvider;
  GoRouter? _router;

  @override
  void initState() {
    super.initState();
    _settingsProvider = SettingsProvider();
    _initialize();
  }

  Future<void> _initialize() async {
    await _settingsProvider.initialize();

    if (_settingsProvider.isLoggedIn) {
      try {
        await FavoritesHelper.checkAndSync();
        await MealPlannerService.checkAndSync();
        await FavoritesHelper.loadFavorites();
        await MealPlannerService.loadPlannedMeals();
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>.value(
      value: _settingsProvider,
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          if (settings.isLoading) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFF10B981)),
                ),
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
                KurdishSafeMaterialDelegate(),
                KurdishSafeCupertinoDelegate(),
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            );
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => FavoritesProvider()),
              ChangeNotifierProvider(create: (_) => MealPlannerProvider()),
              ChangeNotifierProvider(create: (_) => RecipeProvider()),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'NutriZham',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              locale: Locale(settings.languageCode),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                KurdishSafeMaterialDelegate(),
                KurdishSafeCupertinoDelegate(),
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: _router ??= buildRouter(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    FavoritesHelper.dispose();
    MealPlannerService.dispose();
    super.dispose();
  }
}
