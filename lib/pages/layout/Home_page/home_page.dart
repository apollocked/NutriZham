// ignore_for_file: unnecessary_cast, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrizham/pages/layout/Details_page/details_screen.dart';
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

  // Firestore Pagination variables
  final List<Recipe> _allRecipes = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true; // To check if there are more docs in DB
  DocumentSnapshot? _lastDocument; // To keep track of the last doc fetched
  final int _pageSize = 20; // Number of items to fetch per batch

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _setupFavoritesListener();
    _setupScrollListener();
    _loadNextBatch(); // Load the first batch
  }

  // 1. Load a batch of recipes from Firestore
  Future<void> _loadNextBatch() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      Query query = FirebaseFirestore.instance
          .collection('recipes')
          .orderBy('title') // Important: Must order by a field for pagination
          .limit(_pageSize);

      // If we have a previous document, start after it
      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoadingMore = false;
          _isLoading = false;
        });
        return;
      }

      final newRecipes = snapshot.docs.map((doc) {
        return Recipe.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (mounted) {
        setState(() {
          _allRecipes.addAll(newRecipes);
          _lastDocument = snapshot.docs.last;
          _hasMore = newRecipes.length ==
              _pageSize; // If less than page size, we reached end
          _isLoadingMore = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading recipes: $e");
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
          _isLoading = false;
        });
      }
    }
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
      // Only load more if not searching/filtering (Searching works on local data)
      if (_searchQuery.isEmpty &&
          _selectedCategory == null &&
          !_showFavoritesOnly) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          _loadNextBatch();
        }
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

  // NOTE: Pagination logic for local filtering (Search/Category)
  // When filtering, we use the loaded _allRecipes and slice them.
  // When scrolling in "All" mode, we trigger _loadNextBatch.
  List<Recipe> get _paginatedRecipes {
    // 1. Filter recipes (from the locally loaded list)
    var filtered = _allRecipes.where((recipe) {
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

    // Note: We do NOT slice the list here anymore.
    // The ListView.builder handles displaying all items currently in memory.
    // Real infinite scrolling for "Search" is complex (requires backend search),
    // so we rely on the user scrolling in "All" view to populate _allRecipes.
    return filtered;
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  Recipe get _recipeOfTheDay {
    if (_allRecipes.isEmpty) {
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
    final dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return _allRecipes[dayOfYear % _allRecipes.length];
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
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
                    '${paginatedRecipes.length}',
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

            // Recipes List
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGreen,
                      ),
                    )
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
                              : loc.tryDifferentSearch,
                          isDarkMode: widget.isDarkMode,
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            // Handle scroll loading here only if in "All" view
                            if (_searchQuery.isEmpty &&
                                _selectedCategory == null &&
                                !_showFavoritesOnly &&
                                !_isLoadingMore &&
                                _hasMore &&
                                scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 200) {
                              _loadNextBatch();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            controller: _scrollController,
                            // If loading more, add 1 for the spinner
                            itemCount: paginatedRecipes.length +
                                (_hasMore && _isLoadingMore ? 1 : 0),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemBuilder: (context, index) {
                              // Show spinner at the bottom
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
                              final isFavorite =
                                  _favoriteIds.contains(recipe.id);

                              return RecipeCard(
                                recipe: recipe,
                                isDarkMode: widget.isDarkMode,
                                languageCode: widget.languageCode,
                                isFavorite: isFavorite,
                                onFavoriteToggle: () =>
                                    _toggleFavorite(recipe.id),
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
            ),
          ],
        ),
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(loc.all),
              selected: _selectedCategory == null,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = null;
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
          ...MealCategory.values.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_getCategoryName(category)),
                  selected: _selectedCategory == category,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
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
                  "Recipe of the Day",
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
