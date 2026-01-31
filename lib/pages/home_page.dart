// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  Set<String> _favoriteIds = {};
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favoriteIds = favorites.toSet();
    });
  }

  Future<void> _toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favoriteIds.contains(recipeId)) {
        _favoriteIds.remove(recipeId);
      } else {
        _favoriteIds.add(recipeId);
      }
    });
    await prefs.setStringList('favorites', _favoriteIds.toList());
  }

  List<Recipe> get _filteredRecipes {
    var filtered = recipes.where((recipe) {
      final matchesSearch = recipe.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          recipe.ingredients
              .any((i) => i.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;

      final matchesFavorites =
          !_showFavoritesOnly || _favoriteIds.contains(recipe.id);

      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();

    return filtered;
  }

  String _getCategoryName(MealCategory category) {
    switch (category) {
      case MealCategory.breakfast:
        return 'Breakfast';
      case MealCategory.lunch:
        return 'Lunch';
      case MealCategory.dinner:
        return 'Dinner';
      case MealCategory.snack:
        return 'Snack';
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = _filteredRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriZham Recipes'),
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search recipes or ingredients...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Category filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = null;
                      });
                    },
                  ),
                ),
                ...MealCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_getCategoryName(category)),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Results count
          if (filteredRecipes.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      _showFavoritesOnly
                          ? 'No favorites yet'
                          : 'No recipes found',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _showFavoritesOnly
                          ? 'Tap the heart icon on recipes to save them'
                          : 'Try a different search or filter',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${filteredRecipes.length} recipe${filteredRecipes.length == 1 ? '' : 's'} found',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),

          // Recipe list
          if (filteredRecipes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  final isFavorite = _favoriteIds.contains(recipe.id);

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          recipe.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 70,
                              height: 70,
                              color: Colors.grey[300],
                              child: const Icon(Icons.restaurant),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        recipe.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            '${recipe.nutrition.calories} kcal • ${_getCategoryName(recipe.category)}',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildNutrientChip(
                                  'P: ${recipe.nutrition.protein}g',
                                  Colors.blue),
                              const SizedBox(width: 4),
                              _buildNutrientChip(
                                  'C: ${recipe.nutrition.carbs}g',
                                  Colors.orange),
                              const SizedBox(width: 4),
                              _buildNutrientChip('F: ${recipe.nutrition.fats}g',
                                  Colors.purple),
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
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => _toggleFavorite(recipe.id),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(
                              recipe: recipe,
                              isFavorite: isFavorite,
                              onFavoriteToggle: () =>
                                  _toggleFavorite(recipe.id),
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

  Widget _buildNutrientChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style:
            TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
