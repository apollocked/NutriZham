import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';
import 'package:nutrizham/presentation/widgets/home/home_category_chips.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_of_the_day_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MealCategory? _selectedCategory;
  bool _showFavoritesOnly = false;
  final ScrollController _scrollController = ScrollController();
  late final FavoritesCubit _favoritesProvider;

  @override
  void initState() {
    super.initState();
    _favoritesProvider = context.read<FavoritesCubit>();
    _favoritesProvider.loadFavorites();
    _loadNextBatch();
    _scrollController.addListener(() {
      if (_selectedCategory == null &&
          !_showFavoritesOnly &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        _loadNextBatch();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadNextBatch() async {
    final cubit = context.read<RecipeCubit>();
    if (cubit.isLoadingMore || !cubit.hasMore) return;
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
    return all[DateTime.now()
            .difference(DateTime(DateTime.now().year, 1, 1))
            .inDays %
        all.length];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RecipeCubit>();
    final paginatedRecipes = _paginatedRecipes;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: loc.appTitle, actions: [
        IconButton(
            icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_outline,
                color: _showFavoritesOnly ? Colors.red.shade400 : null),
            onPressed: () =>
                setState(() => _showFavoritesOnly = !_showFavoritesOnly)),
      ]),
      body: SafeArea(
          child: Column(children: [
        HomeCategoryChips(
            selectedCategory: _selectedCategory,
            onCategorySelected: (v) => setState(() => _selectedCategory = v)),
        if (_selectedCategory == null && !_showFavoritesOnly)
          RecipeOfTheDayCard(recipe: _recipeOfTheDay),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.4)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(_showFavoritesOnly ? loc.favorites : loc.recipes,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${paginatedRecipes.length}',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary)),
            ),
          ]),
        ),
        Expanded(
          child: cubit.recipes.isEmpty && cubit.isLoading
              ? const ShimmerRecipeGrid()
              : paginatedRecipes.isEmpty
                  ? EmptyStateWidget(
                      icon: _showFavoritesOnly
                          ? Icons.favorite_outline
                          : Icons.search_off,
                      title: _showFavoritesOnly
                          ? loc.noFavorites
                          : loc.noRecipesFound,
                      subtitle: _showFavoritesOnly
                          ? loc.tapToSave
                          : loc.tryDifferentSearch)
                  : NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (_selectedCategory == null &&
                            !_showFavoritesOnly &&
                            !cubit.isLoadingMore &&
                            cubit.hasMore &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 200) {
                          _loadNextBatch();
                        }
                        return false;
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.82,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        itemCount: paginatedRecipes.length +
                            (cubit.hasMore && cubit.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == paginatedRecipes.length) {
                            return const ShimmerRecipeCard();
                          }
                          final recipe = paginatedRecipes[index];
                          return RecipeCard(
                              recipe: recipe,
                              isFavorite: context
                                  .watch<FavoritesCubit>()
                                  .isFavorite(recipe.id),
                              onFavoriteToggle: () => context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(recipe.id),
                              onTap: () => context.push('/recipe/$recipe.id',
                                  extra: recipe));
                        },
                      )),
        ),
      ])),
    );
  }
}
