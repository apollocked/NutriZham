import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/profile/logout_dialog.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_header.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_stats_row.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_menu_card.dart';
import 'package:nutrizham/presentation/widgets/profile/profile_weekly_summary.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/utils/connectivity_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Recipe> _allRecipes = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final auth = context.read<AuthCubit>();
    final favorites = context.read<FavoritesCubit>();
    final planner = context.read<MealPlannerCubit>();
    await Future.wait([
      auth.loadCurrentUser(),
      favorites.loadFavorites(),
      planner.loadPlannedMeals(),
      _loadRecipesFromFirebase(),
    ]);
  }

  Future<void> _loadRecipesFromFirebase() async {
    try {
      final recipes = context.read<RecipeCubit>();
      final allRecipes = await recipes.getAllFresh();
      if (mounted) setState(() => _allRecipes = allRecipes);
    } catch (_) {}
  }

  List<Recipe> get _favoriteRecipes => _allRecipes
      .where((r) => context.read<FavoritesCubit>().isFavorite(r.id))
      .toList();

  Future<void> _logOutAccount() async {
    if (!context.guardOnline()) return;
    final auth = context.read<AuthCubit>();
    final settings = context.read<SettingsCubit>();
    final confirmed = await showLogoutDialog(context);
    if (confirmed == true) {
      settings.setLoggedIn(false);
      if (mounted) context.go('/login');
      auth.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (authState is AuthLoading || authState is AuthInitial) {
      return const Scaffold(
        body: SafeArea(child: ShimmerProfilePage()),
      );
    }

    if (authState is AuthAuthenticated) {
      final user = authState.user;
      final planner = context.watch<MealPlannerCubit>();
      final plannerState = planner.state;
      final mealPlans = plannerState is PlannerLoaded
          ? plannerState.mealPlans
          : <String, List<MealPlanEntry>>{};
      final weekStart = plannerState is PlannerLoaded
          ? plannerState.weekStart
          : DateTime.now();
      final favRecipes = _favoriteRecipes;

      return Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Column(children: [
                const SizedBox(height: 8),
                ProfileHeader(
                    username: user.username,
                    email: user.email,
                    age: user.age,
                    createdAt: user.createdAt),
                ProfileStatsRow(
                    favoriteCount: favRecipes.length,
                    totalRecipeCount: _allRecipes.length),
                ProfileWeeklySummary(
                  mealPlans: mealPlans,
                  weekStart: weekStart,
                  allRecipes: _allRecipes,
                ),
                ProfileMenuCard(
                    onFeatures: () => context.push('/features'),
                    onSettings: () => context.push('/settings'),
                    onLogout: _logOutAccount),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.couldNotLoadProfile,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
