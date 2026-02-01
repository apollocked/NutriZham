// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/pages/details_screen.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/search_bar_widget.dart';
import 'package:nutrizham/widgets/category_widgets.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class SearchPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const SearchPage(
      {super.key, required this.isDarkMode, required this.languageCode});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final loc = AppLocalizations.of(widget.languageCode);
    final filteredRecipes = _filteredRecipes;
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: loc.search,
        isDarkMode: widget.isDarkMode,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSearchBar(
                hintText: loc.searchPlaceholder,
                searchQuery: _searchQuery,
                onChanged: (value) => setState(() => _searchQuery = value),
                onClear: () {
                  setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
                isDarkMode: widget.isDarkMode,
                controller: _searchController,
              )),
          CategoryFilterChips(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) =>
                setState(() => _selectedCategory = category),
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredRecipes.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.search_off,
                    title: loc.noRecipesFound,
                    subtitle: loc.tryDifferentSearch,
                    isDarkMode: widget.isDarkMode,
                  )
                : ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return CompactRecipeCard(
                        recipe: recipe,
                        isDarkMode: widget.isDarkMode,
                        languageCode: widget.languageCode,
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
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
