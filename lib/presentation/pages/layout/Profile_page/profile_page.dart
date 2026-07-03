// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/providers/meal_planner_provider.dart';
import 'package:nutrizham/data/models/user_model.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/stat_and_menu_widgets.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _currentUser;
  List<Recipe> _allRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final auth = context.read<AuthProvider>();
    final favorites = context.read<FavoritesProvider>();
    final planner = context.read<MealPlannerProvider>();
    await auth.loadCurrentUser();
    await favorites.loadFavorites();
    await planner.loadPlannedMeals();
    await _loadRecipesFromFirebase();
    if (mounted) {
      setState(() {
        _currentUser = auth.currentUser;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadRecipesFromFirebase() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('recipes').get();
      final recipesList =
          snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
      if (mounted) setState(() => _allRecipes = recipesList);
    } catch (_) {}
  }

  Future<void> _logOutAccount() async {
    final loc = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.logout),
        content: Text(loc.areYouSure),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(loc.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444)),
              child: Text(loc.logout)),
        ],
      ),
    );
    if (confirmed == true) {
      await context.read<AuthProvider>().logout();
      context.read<SettingsProvider>().setLoggedIn(false);
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();
    final planner = context.watch<MealPlannerProvider>();
    final favoriteMeals =
        _allRecipes.where((r) => favorites.isFavorite(r.id)).toList();

    if (_isLoading || _currentUser == null) {
      return Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CircularProgressIndicator(color: Color(0xFF10B981)),
            const SizedBox(height: 16),
            Text(loc.loading,
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
          ]),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            _buildProfileHeader(loc, theme),
            _buildStatsSection(loc, theme, favorites, planner, favoriteMeals),
            _buildMenuSection(loc, theme),
            _buildFavoritesSection(loc, theme, favorites, favoriteMeals),
          ]),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AppLocalizations loc, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary.withOpacity(0.08),
          theme.colorScheme.secondary.withOpacity(0.04)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
          child: Text(_currentUser!.username[0].toUpperCase(),
              style: const TextStyle(
                  fontSize: 36,
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 16),
        Text(_currentUser!.username,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: Text(_currentUser!.email,
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 8),
        Text('${loc.age}: ${_currentUser!.age}',
            style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant, fontSize: 14)),
      ]),
    );
  }

  Widget _buildStatsSection(
      AppLocalizations loc,
      ThemeData theme,
      FavoritesProvider favorites,
      MealPlannerProvider planner,
      List<Recipe> favoriteMeals) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Expanded(
            child: StatCard(
                icon: Icons.favorite_outline,
                label: loc.favorites,
                value: '${favoriteMeals.length}',
                color: const Color(0xFFEF4444))),
        const SizedBox(width: 16),
        Expanded(
            child: StatCard(
                icon: Icons.calendar_today_outlined,
                label: loc.mealPlanner,
                value: '${planner.count}',
                color: const Color(0xFF3B82F6))),
      ]),
    );
  }

  Widget _buildMenuSection(AppLocalizations loc, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outline)),
      child: Column(children: [
        MenuItemTile(
            icon: Icons.favorite_rounded,
            title: loc.appFeature,
            onTap: () => context.push('/features')),
        Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
        MenuItemTile(
            icon: Icons.settings_outlined,
            title: loc.settings,
            onTap: () => context.push('/settings')),
        Divider(color: theme.colorScheme.outline, height: 1, indent: 60),
        MenuItemTile(
            icon: Icons.logout,
            title: loc.logout,
            onTap: _logOutAccount,
            iconColor: const Color(0xFFEF4444),
            textColor: const Color(0xFFEF4444)),
      ]),
    );
  }

  Widget _buildFavoritesSection(AppLocalizations loc, ThemeData theme,
      FavoritesProvider favorites, List<Recipe> favoriteMeals) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 10),
          Text(loc.favorites,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface)),
        ]),
        const SizedBox(height: 16),
        if (favoriteMeals.isEmpty)
          EmptyStateWidget(
              icon: Icons.favorite_outline,
              title: loc.noFavorites,
              subtitle: loc.tapToSave)
        else
          Column(children: [
            ...favoriteMeals.take(5).map((recipe) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RecipeCard(
                      recipe: recipe,
                      isFavorite: true,
                      onFavoriteToggle: () =>
                          favorites.toggleFavorite(recipe.id),
                      onTap: () {}),
                )),
            if (favoriteMeals.length > 5)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('+ ${favoriteMeals.length - 5} more',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF10B981))),
                  ),
                ),
              ),
          ]),
      ]),
    );
  }
}
