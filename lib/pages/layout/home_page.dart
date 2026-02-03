import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/search_bar_widget.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;

  const HomePage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  Set<String> _favoriteIds = {};
  bool _showFavoritesOnly = false;
  StreamSubscription<Set<String>>? _favoritesSubscription;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Pagination
  int _currentPage = 0;
  final int _recipesPerPage = 20;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _setupFavoritesListener();
    _setupScrollListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreRecipes();
      }
    });
  }

  void _setupFavoritesListener() {
    _favoritesSubscription =
        FavoritesHelper.favoritesStream.listen((favorites) {
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

  void _loadMoreRecipes() {
    if (_isLoadingMore) return;

    final filteredRecipes = _getAllFilteredRecipes();
    final maxPages = (filteredRecipes.length / _recipesPerPage).ceil();

    if (_currentPage < maxPages - 1) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _isLoadingMore = false);
        }
      });
    }
  }

  List<Recipe> _getAllFilteredRecipes() {
    return recipes.where((recipe) {
      final title =
          recipe.title[widget.languageCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = _searchQuery.isEmpty ||
          title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;
      final matchesFavorites =
          !_showFavoritesOnly || _favoriteIds.contains(recipe.id);
      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();
  }

  List<Recipe> get _paginatedRecipes {
    final allFiltered = _getAllFilteredRecipes();
    final endIndex = (_currentPage + 1) * _recipesPerPage;
    return allFiltered.take(endIndex.clamp(0, allFiltered.length)).toList();
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
      _currentPage = 0;
    });
  }

  Recipe get _recipeOfTheDay {
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return recipes[dayOfYear % recipes.length];
  }

  String _getCategoryName(MealCategory category) {
    final loc = AppLocalizations.of(widget.languageCode);
    switch (category) {
      case MealCategory.breakfast:
        return loc.breakfast;
      case MealCategory.lunch:
        return loc.lunch;
      case MealCategory.dinner:
        return loc.dinner;
      case MealCategory.snack:
        return loc.snack;
      case MealCategory.bulking:
        return loc.bulking;
      case MealCategory.cutting:
        return loc.cutting;
    }
  }

  @override
  Widget build(BuildContext context) {
    final paginatedRecipes = _paginatedRecipes;
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
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_outline,
              color: _showFavoritesOnly ? AppColors.accentRed : null,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
                _currentPage = 0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: loc.searchPlaceholder,
              searchQuery: _searchQuery,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _currentPage = 0;
                });
              },
              onClear: _clearSearch,
              isDarkMode: widget.isDarkMode,
              controller: _searchController,
            ),
          ),

          // Category Filter Chips
          _buildCategoryChips(loc),

          // Recipe of the Day (only show when not searching/filtering)
          if (_searchQuery.isEmpty &&
              _selectedCategory == null &&
              !_showFavoritesOnly)
            _buildRecipeOfTheDay(loc),

          // Recipes List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showFavoritesOnly ? loc.favorites : loc.recipes,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightText,
                  ),
                ),
                Text(
                  '${_paginatedRecipes.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Recipes List or Empty State
          Expanded(
            child: paginatedRecipes.isEmpty
                ? EmptyStateWidget(
                    icon: _showFavoritesOnly
                        ? Icons.favorite_outline
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
                    controller: _scrollController,
                    itemCount:
                        paginatedRecipes.length + (_isLoadingMore ? 1 : 0),
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      if (index == paginatedRecipes.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        );
                      }

                      final recipe = paginatedRecipes[index];
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

  Widget _buildCategoryChips(AppLocalizations loc) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(loc.all),
              selected: _selectedCategory == null,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = null;
                  _currentPage = 0;
                });
              },
              backgroundColor: widget.isDarkMode
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              selectedColor: AppColors.primaryGreen.withOpacity(0.1),
              labelStyle: TextStyle(
                color: _selectedCategory == null
                    ? AppColors.primaryGreen
                    : (widget.isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary),
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: _selectedCategory == null
                      ? AppColors.primaryGreen
                      : (widget.isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider),
                  width: 1,
                ),
              ),
            ),
          ),
          // Category chips
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_getCategoryName(category)),
                  selected: _selectedCategory == category,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                      _currentPage = 0;
                    });
                  },
                  backgroundColor: widget.isDarkMode
                      ? AppColors.darkSurface
                      : AppColors.lightSurface,
                  selectedColor: AppColors.primaryGreen.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: _selectedCategory == category
                        ? AppColors.primaryGreen
                        : (widget.isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary),
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: _selectedCategory == category
                          ? AppColors.primaryGreen
                          : (widget.isDarkMode
                              ? AppColors.darkDivider
                              : AppColors.lightDivider),
                      width: 1,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRecipeOfTheDay(AppLocalizations loc) {
    final recipe = _recipeOfTheDay;
    final isFavorite = _favoriteIds.contains(recipe.id);

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(Icons.star, color: AppColors.primaryGreen, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Reycipe of the Day",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
          RecipeCard(
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
          ),
        ],
      ),
    );
  }
}
