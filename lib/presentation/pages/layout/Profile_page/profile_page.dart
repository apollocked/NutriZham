import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/data/models/user_model.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/profile/logout_dialog.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_header.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_stats_row.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_menu_card.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_favorites_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _currentUser;
  List<Recipe> _allRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final auth = context.read<AuthCubit>();
    final favorites = context.read<FavoritesCubit>();
    final planner = context.read<MealPlannerCubit>();
    await auth.loadCurrentUser();
    await favorites.loadFavorites();
    await planner.loadPlannedMeals();
    await _loadRecipesFromFirebase();
    if (mounted) {
      setState(() {
        _currentUser = auth.currentUser;
      });
    }
  }

  Future<void> _loadRecipesFromFirebase() async {
    try {
      final recipes = context.read<RecipeCubit>();
      final allRecipes = await recipes.getAll();
      if (mounted) setState(() => _allRecipes = allRecipes);
    } catch (_) {}
  }

  Future<void> _logOutAccount() async {
    final auth = context.read<AuthCubit>();
    final settings = context.read<SettingsCubit>();
    final confirmed = await showLogoutDialog(context);
    if (confirmed == true) {
      await auth.logout();
      settings.setLoggedIn(false);
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesCubit>();
    final planner = context.watch<MealPlannerCubit>();
    final favoriteMeals =
        _allRecipes.where((r) => favorites.isFavorite(r.id)).toList();

    final authState = context.watch<AuthCubit>().state;
    if (authState is AuthLoading || _currentUser == null) {
      return const Scaffold(
        body: SafeArea(child: ShimmerProfilePage()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 8),
            ProfileHeader(
                username: _currentUser!.username,
                email: _currentUser!.email,
                age: _currentUser!.age),
            ProfileStatsRow(
                favoriteCount: favoriteMeals.length,
                plannedCount: planner.count),
            ProfileMenuCard(
                onFeatures: () => context.push('/features'),
                onSettings: () => context.push('/settings'),
                onLogout: _logOutAccount),
            ProfileFavoritesSection(
                favoriteMeals: favoriteMeals,
                favoritesProvider: favorites,
                onToggleFavorite: (id) => favorites.toggleFavorite(id)),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
