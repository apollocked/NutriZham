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

              // Stats Cards
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
      decoration: BoxDecoration(
        color: widget.isDarkMode ? AppColors.darkCard : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: widget.isDarkMode
                ? AppColors.darkDivider
                : AppColors.lightDivider,
          ),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
            child: Text(
              _currentUser!.username[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 36,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // User Info
          Text(
            _currentUser!.username,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color:
                  widget.isDarkMode ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          Text(
            _currentUser!.email,
            style: TextStyle(
              color: widget.isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${loc.age}: ${_currentUser!.age}',
            style: TextStyle(
              color: widget.isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
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
              icon: Icons.favorite_outline,
              label: loc.favorites,
              value: '${favoriteMeals.length}',
              color: AppColors.accentRed,
              isDarkMode: widget.isDarkMode,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: StatCard(
              icon: Icons.calendar_today_outlined,
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDarkMode
              ? AppColors.darkDivider
              : AppColors.lightDivider,
        ),
      ),
      child: Column(
        children: [
          MenuItemTile(
            icon: Icons.settings_outlined,
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
          Text(
            loc.favorites,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),

          // Empty State or Favorites List
          if (favoriteMeals.isEmpty)
            EmptyStateWidget(
              icon: Icons.favorite_outline,
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
                    padding: const EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text(
                        '+ ${favoriteMeals.length - 5} more',
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
