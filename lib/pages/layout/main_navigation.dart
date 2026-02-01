import 'package:flutter/material.dart';
import 'home_page.dart';

import 'planner_page.dart';
import 'package:nutrizham/pages/profile_page/profile_page.dart';
import 'package:nutrizham/pages/profile_page/search_page.dart';
import 'package:nutrizham/services/preferences_helper.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const MainNavigation({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late bool _isDarkMode;
  late String _languageCode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _languageCode = widget.languageCode;
  }

  Future<void> _updateTheme(bool isDark) async {
    await PreferencesHelper.setIsDarkMode(isDark); // Use PreferencesHelper
    setState(() => _isDarkMode = isDark);
  }

  Future<void> _updateLanguage(String lang) async {
    await PreferencesHelper.setLanguageCode(lang); // Use PreferencesHelper
    setState(() => _languageCode = lang);
  }

  List<Widget> _getPages() {
    return [
      HomePage(
        isDarkMode: _isDarkMode,
        languageCode: _languageCode,
        onThemeChanged: _updateTheme,
        onLanguageChanged: _updateLanguage,
      ),
      SearchPage(isDarkMode: _isDarkMode, languageCode: _languageCode),
      PlannerPage(isDarkMode: _isDarkMode, languageCode: _languageCode),
      ProfilePage(
        isDarkMode: _isDarkMode,
        languageCode: _languageCode,
        onThemeChanged: _updateTheme,
        onLanguageChanged: _updateLanguage,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(_languageCode);
    final pages = _getPages();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: _isDarkMode ? AppColors.darkCard : Colors.white,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: _isDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: loc.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              activeIcon: const Icon(Icons.search),
              label: loc.search,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today_outlined),
              activeIcon: const Icon(Icons.calendar_today),
              label: loc.planner,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: loc.profile,
            ),
          ],
        ),
      ),
    );
  }
}
