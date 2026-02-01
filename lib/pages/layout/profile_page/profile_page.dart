import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/widgets/stat_and_menu_widgets.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';
import 'package:nutrizham/pages/layout/profile_page/settings_page.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/models/user_model.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'dart:async';

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
  StreamSubscription<Set<String>>? _favoritesSubscription;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _setupFavoritesListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }

  void _setupFavoritesListener() {
    _favoritesSubscription =
        FavoritesHelper.favoritesStream.listen((favorites) {
      if (mounted) {
        setState(() {
          _favoriteIds = favorites;
        });
      }
    });
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    final favorites = await FavoritesHelper.loadFavorites();

    if (mounted) {
      setState(() {
        _currentUser = user;
        _favoriteIds = favorites;
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    // Clear favorites when logging out
    await FavoritesHelper.clearAllFavorites();
    await _authService.logout();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginPageRefactored(
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
        body: LoadingWidget(
          message: loc.loading,
          isDarkMode: widget.isDarkMode,
        ),
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
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.favorite,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            '${_favoriteIds.length} ${loc.favorites.toLowerCase()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.favorite,
                        label: loc.favorites,
                        value: '${favoriteMeals.length}',
                        color: AppColors.accentRed,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        icon: Icons.calendar_today,
                        label: loc.dailyPlan,
                        value: '0',
                        color: AppColors.accentBlue,
                        isDarkMode: widget.isDarkMode,
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
                    MenuItemTile(
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
                      },
                      isDarkMode: widget.isDarkMode,
                    ),
                    Divider(
                        color: widget.isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                        height: 1),
                    MenuItemTile(
                      icon: Icons.logout,
                      title: loc.logout,
                      onTap: _logout,
                      iconColor: AppColors.error,
                      textColor: AppColors.error,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ],
                ),
              ),

              // Favorite Meals Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(loc.favorites,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        if (favoriteMeals.isNotEmpty)
                          Text(
                            '${favoriteMeals.length}',
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (favoriteMeals.isEmpty)
                      Center(
                          child: EmptyStateWidget(
                        icon: Icons.favorite_border,
                        title: loc.noFavorites,
                        subtitle: loc.tapToSave,
                        isDarkMode: widget.isDarkMode,
                      ))
                    else
                      ...favoriteMeals
                          .take(5)
                          .map((recipe) => CompactRecipeCard(
                                recipe: recipe,
                                isDarkMode: widget.isDarkMode,
                                languageCode: widget.languageCode,
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite,
                                      color: AppColors.accentRed),
                                  onPressed: () =>
                                      FavoritesHelper.toggleFavorite(recipe.id),
                                ),
                              )),
                    if (favoriteMeals.length > 5)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: Text(
                            '+ ${favoriteMeals.length - 5} more favorites',
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
