import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/pages/layout/profile_page/settings_page.dart';

import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/models/user_model.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'package:nutrizham/services/meal_planner_service.dart';
import 'package:nutrizham/widgets/stat_and_menu_widgets.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

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
  List<String> _plannedMealIds = [];
  bool _isLoading = true;
  StreamSubscription<Set<String>>? _favoritesSubscription;
  StreamSubscription<List<String>>? _plannerSubscription;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _setupFavoritesListener();
    _setupPlannerListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    _plannerSubscription?.cancel();
    super.dispose();
  }

  void _setupFavoritesListener() {
    _favoritesSubscription =
        FavoritesHelper.favoritesStream.listen((favorites) {
      if (mounted) {
        setState(() => _favoriteIds = favorites);
      }
    });
  }

  void _setupPlannerListener() {
    _plannerSubscription =
        MealPlannerService.plannedMealsStream.listen((plannedMeals) {
      if (mounted) {
        setState(() => _plannedMealIds = plannedMeals);
      }
    });
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    final favorites = await FavoritesHelper.loadFavorites();
    final plannedMeals = await MealPlannerService.loadPlannedMeals();

    if (mounted) {
      setState(() {
        _currentUser = user;
        _favoriteIds = favorites;
        _plannedMealIds = plannedMeals;
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await FavoritesHelper.clearAllFavorites();
    await MealPlannerService.clearAllPlannedMeals();
    await _authService.logout();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginPage(
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
              _buildProfileHeader(loc),

              // Stats Cards with Meal Plan count
              _buildStatsSection(loc, favoriteMeals),

              // Menu Items
              _buildMenuSection(loc),

              // Favorite Meals Section
              _buildFavoritesSection(loc, favoriteMeals),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AppLocalizations loc) {
    return Container(
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
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Text(
              _currentUser!.username[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 36,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // User Info
          Text(
            _currentUser!.username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            _currentUser!.email,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            '${loc.age}: ${_currentUser!.age}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),

          // Quick Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Favorites Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '${_favoriteIds.length} ${loc.favorites.toLowerCase()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Meal Plan Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '${_plannedMealIds.length} ${loc.mealPlanner.toLowerCase()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(AppLocalizations loc, List<Recipe> favoriteMeals) {
    return Padding(
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
              label: loc.mealPlanner,
              value: '${_plannedMealIds.length}',
              color: AppColors.accentBlue,
              isDarkMode: widget.isDarkMode,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(AppLocalizations loc) {
    return Container(
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
            height: 1,
          ),
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
    );
  }

  Widget _buildFavoritesSection(
      AppLocalizations loc, List<Recipe> favoriteMeals) {
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.favorites,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (favoriteMeals.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  '(${favoriteMeals.length})',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          // Empty State or Favorites List
          if (favoriteMeals.isEmpty)
            EmptyStateWidget(
              icon: Icons.favorite_border,
              title: loc.noFavorites,
              subtitle: loc.tapToSave,
              isDarkMode: widget.isDarkMode,
            )
          else
            Column(
              children: [
                ...favoriteMeals.take(5).map((recipe) => CompactRecipeCard(
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
        ],
      ),
    );
  }
}
