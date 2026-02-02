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

  Map<MealCategory, int> get _categoryCounts {
    final counts = <MealCategory, int>{};
    for (var recipe in recipes) {
      counts[recipe.category] = (counts[recipe.category] ?? 0) + 1;
    }
    return counts;
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
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
                ),
                color: _showFavoritesOnly ? AppColors.accentRed : Colors.white,
                onPressed: () {
                  setState(() {
                    _showFavoritesOnly = !_showFavoritesOnly;
                    _currentPage = 0;
                  });
                },
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
          // Recipe Count Banner
          _buildRecipeCountBanner(loc),

          // Search Bar
          CustomSearchBar(
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

          // Category Filter Chips with counts
          _buildCategoryChipsWithCounts(loc),

          // Recipe of the Day (only show when not searching/filtering)
          if (_searchQuery.isEmpty &&
              _selectedCategory == null &&
              !_showFavoritesOnly)
            _buildRecipeOfTheDay(loc),

          // Recipes List or Empty State
          Expanded(
            child: paginatedRecipes.isEmpty
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

  Widget _buildRecipeCountBanner(AppLocalizations loc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryGreen.withOpacity(0.1),
            AppColors.primaryGreenLight.withOpacity(0.05),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: widget.isDarkMode
                ? AppColors.darkDivider
                : AppColors.lightDivider,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.restaurant_menu,
            color: AppColors.primaryGreen,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '${recipes.length} ${loc.recipes}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  widget.isDarkMode ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '• Kurdish & Middle Eastern',
            style: TextStyle(
              fontSize: 12,
              color: widget.isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChipsWithCounts(AppLocalizations loc) {
    final counts = _categoryCounts;

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // "All" chip with total count
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text('${loc.all} (${recipes.length})'),
              selected: _selectedCategory == null,
              backgroundColor:
                  widget.isDarkMode ? AppColors.darkCard : Colors.grey[200],
              selectedColor: AppColors.primaryGreen,
              labelStyle: TextStyle(
                color: _selectedCategory == null
                    ? Colors.white
                    : (widget.isDarkMode
                        ? AppColors.darkText
                        : AppColors.lightText),
                fontWeight: _selectedCategory == null
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              onSelected: (_) {
                setState(() {
                  _selectedCategory = null;
                  _currentPage = 0;
                });
              },
            ),
          ),
          // Category chips with counts
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    '${_getCategoryName(category)} (${counts[category] ?? 0})',
                  ),
                  selected: _selectedCategory == category,
                  backgroundColor:
                      widget.isDarkMode ? AppColors.darkCard : Colors.grey[200],
                  selectedColor: AppColors.primaryGreen,
                  labelStyle: TextStyle(
                    color: _selectedCategory == category
                        ? Colors.white
                        : (widget.isDarkMode
                            ? AppColors.darkText
                            : AppColors.lightText),
                    fontWeight: _selectedCategory == category
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                      _currentPage = 0;
                    });
                  },
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
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.star, color: AppColors.starActive, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Recipe of the Day',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
              }),
        ],
      ),
    );
  }
}
