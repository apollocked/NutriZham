import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/providers/recipe_provider.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/category_widgets.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  List<Recipe> _allRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = context.read<RecipeProvider>();
    final recipesList = await recipes.getAll();
    if (mounted) setState(() => _allRecipes = recipesList);
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
          child: CustomSearchBar(
            hintText: loc.searchPlaceholder,
            searchQuery: _searchQuery,
            onChanged: (v) => setState(() => _searchQuery = v),
            onClear: () { setState(() { _searchQuery = ''; _searchController.clear(); }); },
            controller: _searchController,
          ),
        ),
        CategoryFilterChips(selectedCategory: _selectedCategory, onCategorySelected: (category) => setState(() => _selectedCategory = category)),
        const SizedBox(height: 8),
        Expanded(
          child: filteredRecipes.isEmpty
              ? EmptyStateWidget(icon: Icons.search_off, title: loc.noRecipesFound, subtitle: loc.tryDifferentSearch)
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  itemCount: filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = filteredRecipes[index];
                    final favorites = context.watch<FavoritesProvider>();
                    return RecipeCard(
                      recipe: recipe,
                      isFavorite: favorites.isFavorite(recipe.id),
                      onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
                      onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
                    );
                  },
                ),
        ),
      ]),
    );
  }
}
