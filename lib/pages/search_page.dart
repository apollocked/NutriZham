import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/pages/details_screen.dart';

class SearchPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const SearchPage(
      {super.key, required this.isDarkMode, required this.languageCode});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  MealCategory? _selectedCategory;

  List<Recipe> get _filteredRecipes {
    return recipes.where((recipe) {
      final title =
          recipe.title[widget.languageCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = _searchQuery.isEmpty ||
          title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final filteredRecipes = _filteredRecipes;
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(loc.search),
        backgroundColor:
            widget.isDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: loc.searchPlaceholder,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryGreen),
                filled: true,
                fillColor:
                    widget.isDarkMode ? AppColors.darkCard : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? Center(
                    child: Text(loc.noRecipesFound,
                        style: TextStyle(color: textColor)))
                : ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(recipe.image,
                              width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        title: Text(recipe.title[widget.languageCode] ?? '',
                            style: TextStyle(color: textColor)),
                        subtitle: Text(
                            '${recipe.nutrition.calories} ${loc.calories}'),
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
