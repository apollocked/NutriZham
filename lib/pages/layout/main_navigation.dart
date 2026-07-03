import 'package:flutter/material.dart';
import 'package:nutrizham/pages/layout/Home_page/home_page.dart';
import 'package:nutrizham/pages/layout/Planner_page/planner_page.dart';
import 'package:nutrizham/pages/layout/Profile_page/profile_page.dart';
import 'package:nutrizham/pages/layout/Search_page/search_page.dart';
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
    await PreferencesHelper.setIsDarkMode(isDark);
    setState(() => _isDarkMode = isDark);
  }

  Future<void> _updateLanguage(String lang) async {
    await PreferencesHelper.setLanguageCode(lang);
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
    final navColor = _isDarkMode ? const Color(0xFF1A1A2E) : Colors.white;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: navColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) =>
                    setState(() => _currentIndex = index),
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                indicatorColor: AppColors.primaryGreen.withOpacity(0.15),
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                height: 64,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined,
                        color: _isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    selectedIcon:
                        const Icon(Icons.home, color: AppColors.primaryGreen),
                    label: loc.home,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_outlined,
                        color: _isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    selectedIcon:
                        const Icon(Icons.search, color: AppColors.primaryGreen),
                    label: loc.search,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.calendar_today_outlined,
                        color: _isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    selectedIcon: const Icon(Icons.calendar_today,
                        color: AppColors.primaryGreen),
                    label: loc.planner,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline,
                        color: _isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    selectedIcon:
                        const Icon(Icons.person, color: AppColors.primaryGreen),
                    label: loc.profile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
