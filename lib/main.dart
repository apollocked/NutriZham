// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/services/favorites_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Load preferences
    final theme = await PreferencesHelper.getIsDarkMode();
    final lang = await PreferencesHelper.getLanguageCode();

    // For demo purposes, check if user is logged in
    // You can implement proper auth check here
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('is_logged_in') ?? false;

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
        home: LoginPageRefactored(
          isDarkMode: _isDarkMode,
          languageCode: _languageCode,
        ));
  }

  @override
  void dispose() {
    FavoritesHelper.dispose(); // Clean up stream controller
    super.dispose();
  }
}
