import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final authService = AuthService();

    final isDark = prefs.getBool('isDarkMode') ?? false;
    final lang = prefs.getString('languageCode') ?? 'en';
    final loggedIn = await authService.isLoggedIn();

    setState(() {
      _isDarkMode = isDark;
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
      home: _isLoggedIn
          ? MainNavigation(
              isDarkMode: _isDarkMode,
              languageCode: _languageCode,
            )
          : LoginScreen(
              isDarkMode: _isDarkMode,
              languageCode: _languageCode,
            ),
    );
  }
}
