import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/utils/ingredient_index.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/core/utils/add_to_planner_mixin.dart';
import 'package:nutrizham/presentation/blocs/recipe_cubit.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/common/category_widgets.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_loading.dart';
import 'package:nutrizham/presentation/widgets/common/pressable.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AddToPlannerMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  List<Recipe> _allRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    _isLoading = true;
    if (mounted) setState(() {});
    final recipes = context.read<RecipeCubit>();
    try {
      final recipesList = await recipes.getAllFresh();
      if (!mounted) return;
      final langCode = Localizations.localeOf(context).languageCode;
      IngredientIndex.instance.build(recipesList, localeCode: langCode);
      setState(() { _allRecipes = recipesList; _isLoading = false; });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> get _filteredRecipes {
    final loc = AppLocalizations.of(context);
    final langCode = loc?.localeName ?? 'en';
    return _allRecipes.where((recipe) {
      final title = recipe.title[langCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = _searchQuery.isEmpty || title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || recipe.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final filteredRecipes = _filteredRecipes;

    return Scaffold(
      appBar: CustomAppBar(title: loc.search),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            children: [
              CustomSearchBar(
                hintText: loc.searchPlaceholder,
                searchQuery: _searchQuery,
                onChanged: (v) => setState(() => _searchQuery = v),
                onClear: () { setState(() { _searchQuery = ''; _searchController.clear(); }); },
                controller: _searchController,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Pressable(
                  onTap: () => context.push('/search/by-ingredients', extra: _allRecipes),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_basket_outlined, size: 18, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(loc.searchByIngredients, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        CategoryFilterChips(selectedCategory: _selectedCategory, onCategorySelected: (category) => setState(() => _selectedCategory = category)),
        const SizedBox(height: 8),
        Expanded(
          child: _isLoading
              ? const ShimmerRecipeGrid()
              : filteredRecipes.isEmpty
              ? EmptyStateWidget(icon: Icons.search_off, title: loc.noRecipesFound, subtitle: loc.tryDifferentSearch)
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  padding: const EdgeInsets.fromLTRB(11, 0, 11, 96),
                  itemCount: filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = filteredRecipes[index];
                    final favorites = context.watch<FavoritesCubit>();
                    return DelayedReveal(
                      index: index,
                      child: RecipeCard(
                        recipe: recipe,
                        isFavorite: favorites.isFavorite(recipe.id),
                        onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
                        onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
                        onLongPress: () => addToPlanner(recipe),
                      ),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}
