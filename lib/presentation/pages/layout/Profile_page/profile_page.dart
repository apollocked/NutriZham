// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/providers/meal_planner_provider.dart';
import 'package:nutrizham/presentation/providers/recipe_provider.dart';
import 'package:nutrizham/data/models/user_model.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/logout_dialog.dart';
import 'package:nutrizham/presentation/widgets/profile_header.dart';
import 'package:nutrizham/presentation/widgets/profile_stats_row.dart';
import 'package:nutrizham/presentation/widgets/profile_menu_card.dart';
import 'package:nutrizham/presentation/widgets/profile_favorites_section.dart';
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
      final recipes = context.read<RecipeProvider>();
      final allRecipes = await recipes.getAll();
      if (mounted) setState(() => _allRecipes = allRecipes);
    } catch (_) {}
  }

  Future<void> _logOutAccount() async {
    final confirmed = await showLogoutDialog(context);
    if (confirmed == true) {
      await context.read<AuthProvider>().logout();
      context.read<SettingsProvider>().setLoggedIn(false);
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ]),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            ProfileHeader(
              username: _currentUser!.username,
              email: _currentUser!.email,
              age: _currentUser!.age,
            ),
            ProfileStatsRow(
              favoriteCount: favoriteMeals.length,
              plannedCount: planner.count,
            ),
            ProfileMenuCard(
              onFeatures: () => context.push('/features'),
              onSettings: () => context.push('/settings'),
              onLogout: _logOutAccount,
            ),
            ProfileFavoritesSection(
              favoriteMeals: favoriteMeals,
              favoritesProvider: favorites,
              onToggleFavorite: (id) => favorites.toggleFavorite(id),
            ),
          ]),
        ),
      ),
    );
  }
}
