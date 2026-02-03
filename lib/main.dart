// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/services/favorites_helper.dart';

// --- ADD THESE TWO IMPORTS ---
// Make sure the paths match where you saved your files!
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // 1. Required for Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase
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
  bool _isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _initialize(); // This line calls the method below
  }

  // THIS IS THE METHOD YOU WERE MISSING
  Future<void> _initialize() async {
    // --- LOAD PREFERENCES ---
    final theme = await PreferencesHelper.getIsDarkMode();
    final lang = await PreferencesHelper.getLanguageCode();
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;

    // --- NO UPLOAD CODE HERE ANYMORE ---

    setState(() {
      _isDarkMode = theme;
      _languageCode = lang;
      _isLoggedIn = loggedIn;
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
        home: LoginPage(
          isDarkMode: _isDarkMode,
          languageCode: _languageCode,
        ));
  }

  @override
  void dispose() {
    FavoritesHelper.dispose();
    super.dispose();
  }
}
