import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/home/home_category_chips.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_of_the_day_card.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_section_header.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_grid.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MealCategory? _selectedCategory;
  bool _showFavoritesOnly = false;
  bool _initialized = false;
  Recipe? _cachedRecipeOfTheDay;
  final ScrollController _scrollController = ScrollController();
  late final FavoritesCubit _favoritesProvider;

  @override
  void initState() {
    super.initState();
    _favoritesProvider = context.read<FavoritesCubit>();
    _favoritesProvider.loadFavorites();
    _loadNextBatch();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_selectedCategory == null &&
        !_showFavoritesOnly &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _loadNextBatch();
    }
  }

  Future<void> _loadNextBatch() async {
    final cubit = context.read<RecipeCubit>();
    if (cubit.isLoadingMore || !cubit.hasMore) return;
    if (cubit.isOffline) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noInternet),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    await cubit.loadNextBatch();
  }

  List<Recipe> get _paginatedRecipes {
    final cubit = context.read<RecipeCubit>();
    return cubit.recipes.where((r) {
      return (_selectedCategory == null || r.category == _selectedCategory) &&
          (!_showFavoritesOnly || _favoritesProvider.isFavorite(r.id));
    }).toList();
  }

  Recipe get _recipeOfTheDay {
    if (_cachedRecipeOfTheDay != null) return _cachedRecipeOfTheDay!;
    final cubit = context.read<RecipeCubit>();
    final all = cubit.recipes;
    if (all.isEmpty) {
      return Recipe(
          id: '0',
          title: {},
          icon: '',
          nutrition:
              NutritionalInfo(calories: 0, protein: 0, carbs: 0, fats: 0),
          ingredients: {},
          steps: {},
          category: MealCategory.snack);
    }
    final index =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays %
            all.length;
    _cachedRecipeOfTheDay = all[index];
    return _cachedRecipeOfTheDay!;
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _initialized = true;
      final extra = GoRouterState.of(context).extra;
      if (extra is Map && extra['showFavorites'] == true) {
        _showFavoritesOnly = true;
      }
    }
    final cubit = context.watch<RecipeCubit>();
    final paginatedRecipes = _paginatedRecipes;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.appTitle, actions: [
        IconButton(
            icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_outline,
                color: _showFavoritesOnly ? AppColors.accentRed : null),
            onPressed: () =>
                setState(() => _showFavoritesOnly = !_showFavoritesOnly)),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            HomeCategoryChips(
                selectedCategory: _selectedCategory,
                onCategorySelected: (v) =>
                    setState(() => _selectedCategory = v)),
            if (_selectedCategory == null && !_showFavoritesOnly)
              RecipeOfTheDayCard(
                recipe: _recipeOfTheDay,
                onTap: () => context.push('/recipe/${_recipeOfTheDay.id}',
                    extra: _recipeOfTheDay),
              ),
            RecipeSectionHeader(
              showFavoritesOnly: _showFavoritesOnly,
              count: paginatedRecipes.length,
            ),
            Expanded(
              child: cubit.recipes.isEmpty && cubit.isLoading
                  ? const ShimmerRecipeGrid()
                  : RecipeGrid(
                      recipes: paginatedRecipes,
                      hasMore: cubit.hasMore,
                      isLoadingMore: cubit.isLoadingMore,
                      isLoading: cubit.isLoading,
                      isOffline: cubit.isOffline,
                      showFavoritesOnly: _showFavoritesOnly,
                      scrollController: _scrollController,
                      onLoadMore:
                          _selectedCategory == null && !_showFavoritesOnly
                              ? _loadNextBatch
                              : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
