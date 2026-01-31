import 'package:flutter/material.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeListScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(String) onLanguageChanged;
  final bool isDarkMode;
  final String languageCode;

  const RecipeListScreen({
    super.key,
    required this.onThemeChanged,
    required this.onLanguageChanged,
    required this.isDarkMode,
    required this.languageCode,
  });

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
      final title = recipe.title[widget.languageCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (recipe.ingredients[widget.languageCode] ?? recipe.ingredients['en'] ?? [])
              .any((i) => i.toLowerCase().contains(_searchQuery.toLowerCase()));
      
      final matchesCategory = _selectedCategory == null || recipe.category == _selectedCategory;
      
      final matchesFavorites = !_showFavoritesOnly || _favoriteIds.contains(recipe.id);

      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();

    return filtered;
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

  void _showSettingsBottomSheet() {
    final loc = AppLocalizations.of(widget.languageCode);
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.settings,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Dark mode toggle
                  ListTile(
                    leading: Icon(
                      widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: widget.isDarkMode ? Colors.orange : Colors.grey[700],
                    ),
                    title: Text(
                      loc.darkMode,
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: Switch(
                      value: widget.isDarkMode,
                      onChanged: (value) {
                        widget.onThemeChanged(value);
                        setModalState(() {});
                        setState(() {});
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Language selection
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: widget.isDarkMode ? Colors.blue : Colors.grey[700],
                    ),
                    title: Text(
                      loc.language,
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: DropdownButton<String>(
                      value: widget.languageCode,
                      dropdownColor: widget.isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Row(
                            children: [
                              const Text('🇬🇧 '),
                              Text(loc.english),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ku',
                          child: Row(
                            children: [
                              const Text('🇹🇯 '),
                              Text(loc.kurdish),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          widget.onLanguageChanged(newValue);
                          Navigator.pop(context);
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = _filteredRecipes;
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode ? const Color(0xFF121212) : Colors.white;
    final cardColor = widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = widget.isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('${loc.appTitle} ${loc.recipes}'),
        backgroundColor: widget.isDarkMode ? const Color(0xFF1E1E1E) : Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : (widget.isDarkMode ? Colors.white : Colors.white),
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: loc.searchPlaceholder,
                hintStyle: TextStyle(color: subtitleColor),
                prefixIcon: Icon(Icons.search, color: subtitleColor),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: subtitleColor),
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
                fillColor: widget.isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey[100],
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
                    label: Text(loc.all),
                    labelStyle: TextStyle(
                      color: _selectedCategory == null 
                          ? Colors.white 
                          : (widget.isDarkMode ? Colors.white : Colors.black),
                    ),
                    selected: _selectedCategory == null,
                    backgroundColor: widget.isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey[200],
                    selectedColor: Colors.green,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = null;
                      });
                    },
                  ),
                ),
                ...MealCategory.values.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_getCategoryName(category)),
                      labelStyle: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : (widget.isDarkMode ? Colors.white : Colors.black),
                      ),
                      selected: isSelected,
                      backgroundColor: widget.isDarkMode ? const Color(0xFF2C2C2C) : Colors.grey[200],
                      selectedColor: Colors.green,
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

          // Results count or empty state
          if (filteredRecipes.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: subtitleColor),
                    const SizedBox(height: 16),
                    Text(
                      _showFavoritesOnly ? loc.noFavorites : loc.noRecipesFound,
                      style: TextStyle(fontSize: 18, color: subtitleColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _showFavoritesOnly ? loc.tapToSave : loc.tryDifferentSearch,
                      style: TextStyle(color: subtitleColor),
                    ),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${filteredRecipes.length} ${filteredRecipes.length == 1 ? loc.recipeFound : loc.recipesFound}',
                style: TextStyle(color: subtitleColor, fontSize: 14),
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
                  final recipeTitle = recipe.title[widget.languageCode] ?? recipe.title['en'] ?? '';

                  return Card(
                    color: cardColor,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        recipeTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            '${recipe.nutrition.calories} ${loc.calories.toLowerCase()} • ${_getCategoryName(recipe.category)}',
                            style: TextStyle(color: subtitleColor, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildNutrientChip('P: ${recipe.nutrition.protein}g', Colors.blue),
                              const SizedBox(width: 4),
                              _buildNutrientChip('C: ${recipe.nutrition.carbs}g', Colors.orange),
                              const SizedBox(width: 4),
                              _buildNutrientChip('F: ${recipe.nutrition.fats}g', Colors.purple),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : subtitleColor,
                            ),
                            onPressed: () => _toggleFavorite(recipe.id),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(
                              recipe: recipe,
                              isFavorite: isFavorite,
                              onFavoriteToggle: () => _toggleFavorite(recipe.id),
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
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
