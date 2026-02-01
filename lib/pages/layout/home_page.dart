import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/search_bar_widget.dart';
import 'package:nutrizham/widgets/category_widgets.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class HomePageRefactored extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const HomePageRefactored({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<HomePageRefactored> createState() => _HomePageRefactoredState();
}

class _HomePageRefactoredState extends State<HomePageRefactored> {
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  Set<String> _favoriteIds = {};
  bool _showFavoritesOnly = false;
  StreamSubscription<Set<String>>? _favoritesSubscription;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _setupFavoritesListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _setupFavoritesListener() {
    _favoritesSubscription = FavoritesHelper.favoritesStream.listen((favorites) {
      if (mounted) {
        setState(() => _favoriteIds = favorites);
      }
    });
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoritesHelper.loadFavorites();
    if (mounted) {
      setState(() => _favoriteIds = favorites);
    }
  }

  Future<void> _toggleFavorite(String recipeId) async {
    await FavoritesHelper.toggleFavorite(recipeId);
  }

  List<Recipe> get _filteredRecipes {
    return recipes.where((recipe) {
      final title = recipe.title[widget.languageCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = _searchQuery.isEmpty ||
          title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;
      final matchesFavorites =
          !_showFavoritesOnly || _favoriteIds.contains(recipe.id);
      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = _filteredRecipes;
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: loc.appTitle,
        isDarkMode: widget.isDarkMode,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                ),
                color: _showFavoritesOnly ? AppColors.accentRed : Colors.white,
                onPressed: () =>
                    setState(() => _showFavoritesOnly = !_showFavoritesOnly),
              ),
              if (_favoriteIds.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.accentRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_favoriteIds.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          CustomSearchBar(
            hintText: loc.searchPlaceholder,
            searchQuery: _searchQuery,
            onChanged: (value) => setState(() => _searchQuery = value),
            onClear: _clearSearch,
            isDarkMode: widget.isDarkMode,
            controller: _searchController,
          ),

          // Category Filter Chips
          CategoryFilterChips(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) =>
                setState(() => _selectedCategory = category),
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
          ),

          // Recipes List or Empty State
          Expanded(
            child: filteredRecipes.isEmpty
                ? EmptyStateWidget(
                    icon: _showFavoritesOnly
                        ? Icons.favorite_border
                        : Icons.search_off,
                    title: _showFavoritesOnly
                        ? loc.noFavorites
                        : loc.noRecipesFound,
                    subtitle: _showFavoritesOnly
                        ? loc.tapToSave
                        : loc.tryDifferentSearch,
                    isDarkMode: widget.isDarkMode,
                  )
                : ListView.builder(
                    itemCount: filteredRecipes.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      final isFavorite = _favoriteIds.contains(recipe.id);

                      return RecipeCard(
                        recipe: recipe,
                        isDarkMode: widget.isDarkMode,
                        languageCode: widget.languageCode,
                        isFavorite: isFavorite,
                        onFavoriteToggle: () => _toggleFavorite(recipe.id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailScreen(
                                recipe: recipe,
                                isDarkMode: widget.isDarkMode,
                                languageCode: widget.languageCode,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
