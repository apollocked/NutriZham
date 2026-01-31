import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/pages/settings_page.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/models/user_model.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authService = AuthService();
  UserModel? _currentUser;
  Set<String> _favoriteIds = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];

    setState(() {
      _currentUser = user;
      _favoriteIds = favorites.toSet();
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          isDarkMode: widget.isDarkMode,
          languageCode: widget.languageCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final favoriteMeals =
        recipes.where((r) => _favoriteIds.contains(r.id)).toList();

    if (_isLoading || _currentUser == null) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGreen)),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        _currentUser!.username[0].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 36,
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(_currentUser!.username,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(_currentUser!.email,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text('${loc.age}: ${_currentUser!.age}',
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.favorite,
                        label: loc.favorites,
                        value: '${favoriteMeals.length}',
                        color: AppColors.accentRed,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.calendar_today,
                        label: loc.dailyPlan,
                        value: '0',
                        color: AppColors.accentBlue,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: loc.settings,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SettingsPage(
                              isDarkMode: widget.isDarkMode,
                              languageCode: widget.languageCode,
                              onThemeChanged: widget.onThemeChanged,
                              onLanguageChanged: widget.onLanguageChanged,
                            ),
                          ),
                        );
                        _loadUserData();
                      },
                    ),
                    Divider(
                        color: widget.isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                        height: 1),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: loc.logout,
                      color: AppColors.error,
                      onTap: _logout,
                    ),
                  ],
                ),
              ),

              // Favorite Meals Section
              if (favoriteMeals.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.favorites,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor)),
                      const SizedBox(height: 12),
                      ...favoriteMeals.take(3).map((recipe) => Card(
                            color: widget.isDarkMode
                                ? AppColors.darkCard
                                : Colors.white,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(recipe.image,
                                    width: 50, height: 50, fit: BoxFit.cover),
                              ),
                              title: Text(
                                  recipe.title[widget.languageCode] ?? '',
                                  style: TextStyle(color: textColor)),
                              subtitle:
                                  Text('${recipe.nutrition.calories} kcal'),
                            ),
                          )),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: widget.isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary)),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final itemColor =
        color ?? (widget.isDarkMode ? AppColors.darkText : AppColors.lightText);
    return ListTile(
      leading: Icon(icon, color: itemColor),
      title: Text(title, style: TextStyle(color: itemColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: itemColor),
      onTap: onTap,
    );
  }
}
