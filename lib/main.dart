// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/pages/authotication/welcome_page.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'package:nutrizham/services/meal_planner_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const NutriZhamApp());
}

class NutriZhamApp extends StatefulWidget {
  const NutriZhamApp({super.key});

  @override
  State<NutriZhamApp> createState() => _NutriZhamAppState();
}

class _NutriZhamAppState extends State<NutriZhamApp> {
  bool _isDarkMode = false;
  String _languageCode = 'en';
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _welcomeShown = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Load all preferences
    final theme = await PreferencesHelper.getIsDarkMode();
    final lang = await PreferencesHelper.getLanguageCode();
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;

    // Get welcome shown status
    final welcomeShown = await PreferencesHelper.hasWelcomeBeenShown();

    // SYNC DATA WITH FIRESTORE IF LOGGED IN
    if (loggedIn) {
      try {
        print('User is logged in, checking for data sync...');

        // Check and sync favorites with Firestore
        await FavoritesHelper.checkAndSync();
        print('Favorites sync check completed');

        // Check and sync planned meals with Firestore
        await MealPlannerService.checkAndSync();
        print('Planned meals sync check completed');

        // Load favorites to initialize streams
        await FavoritesHelper.loadFavorites();
        print('Favorites loaded');

        // Load planned meals to initialize streams
        await MealPlannerService.loadPlannedMeals();
        print('Planned meals loaded');
      } catch (e) {
        print('Error syncing data on startup: $e');
        // Continue app even if sync fails - user can work offline
      }
    }

    setState(() {
      _isDarkMode = theme;
      _languageCode = lang;
      _isLoggedIn = loggedIn;
      _welcomeShown = welcomeShown;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: AppColors.primaryGreen),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriZham',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.lightBackground,
        cardColor: AppColors.lightCard,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryGreen,
          secondary: AppColors.primaryGreenLight,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryGreen,
        scaffoldBackgroundColor: AppColors.darkBackground,
        cardColor: AppColors.darkCard,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryGreen,
          secondary: AppColors.primaryGreenLight,
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // SHOW WELCOME PAGE IF NOT SHOWN BEFORE, OTHERWISE LOGIN PAGE
      home: _isLoggedIn
          ? MainNavigation(isDarkMode: _isDarkMode, languageCode: _languageCode)
          : _welcomeShown
              ? LoginPage(
                  isDarkMode: _isDarkMode,
                  languageCode: _languageCode,
                )
              : const WelcomePage(),
    );
  }

  @override
  void dispose() {
    // Clean up stream controllers
    FavoritesHelper.dispose();
    MealPlannerService.dispose();
    super.dispose();
  }
}
