// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/favorites_helper.dart';

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

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _setupFavoritesListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }

  void _setupFavoritesListener() {
    // Listen to favorites changes in real-time
    _favoritesSubscription =
        FavoritesHelper.favoritesStream.listen((favorites) {
      if (mounted) {
        setState(() {
          _favoriteIds = favorites;
        });
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
    // No need to call setState here - stream listener will handle it
  }

  List<Recipe> get _filteredRecipes {
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
    final filteredRecipes = _filteredRecipes;
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('${loc.appTitle}'),
        backgroundColor:
            widget.isDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(_showFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: loc.searchPlaceholder,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryGreen),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''))
                    : null,
                filled: true,
                fillColor:
                    widget.isDarkMode ? AppColors.darkCard : Colors.grey[100],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(loc.all),
                    selected: _selectedCategory == null,
                    backgroundColor: widget.isDarkMode
                        ? AppColors.darkCard
                        : Colors.grey[200],
                    selectedColor: AppColors.primaryGreen,
                    labelStyle: TextStyle(
                        color: _selectedCategory == null
                            ? Colors.white
                            : textColor),
                    onSelected: (_) => setState(() => _selectedCategory = null),
                  ),
                ),
                ...MealCategory.values.map((category) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_getCategoryName(category)),
                      selected: _selectedCategory == category,
                      backgroundColor: widget.isDarkMode
                          ? AppColors.darkCard
                          : Colors.grey[200],
                      selectedColor: AppColors.primaryGreen,
                      labelStyle: TextStyle(
                          color: _selectedCategory == category
                              ? Colors.white
                              : textColor),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                    ))),
              ],
            ),
          ),
          if (filteredRecipes.isEmpty)
            Expanded(
                child: Center(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _showFavoritesOnly ? Icons.favorite_border : Icons.search_off,
                  size: 64,
                  color: textColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  _showFavoritesOnly ? loc.noFavorites : loc.noRecipesFound,
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
                if (_showFavoritesOnly)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      loc.tapToSave,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.5),
                      ),
                    ),
                  ),
              ],
            )))
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  final isFavorite = _favoriteIds.contains(recipe.id);

                  return Card(
                    color:
                        widget.isDarkMode ? AppColors.darkCard : Colors.white,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          recipe.icon,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[300],
                            child: const Icon(Icons.restaurant),
                          ),
                        ),
                      ),
                      title: Text(recipe.title[widget.languageCode] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                              '${recipe.nutrition.calories} kcal • ${_getCategoryName(recipe.category)}'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: AppColors.starActive, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                  '${recipe.rating.toStringAsFixed(1)} (${recipe.ratingCount})',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? AppColors.accentRed
                                    : Colors.grey),
                            onPressed: () => _toggleFavorite(recipe.id),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
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
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
