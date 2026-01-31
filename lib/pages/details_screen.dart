// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final bool isDarkMode;
  final String languageCode;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;
  int _userRating = 0;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadUserRating();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    setState(() => _isFavorite = favorites.contains(widget.recipe.id));
  }

  Future<void> _loadUserRating() async {
    final prefs = await SharedPreferences.getInstance();
    final rating = prefs.getInt('rating_${widget.recipe.id}') ?? 0;
    setState(() => _userRating = rating);
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    if (_isFavorite) {
      favorites.remove(widget.recipe.id);
    } else {
      favorites.add(widget.recipe.id);
    }
    await prefs.setStringList('favorites', favorites);
    setState(() => _isFavorite = !_isFavorite);
  }

  Future<void> _saveRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rating_${widget.recipe.id}', rating);
    setState(() => _userRating = rating);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(widget.languageCode).submitRating),
        backgroundColor: AppColors.success,
      ),
    );
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
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final recipeTitle = widget.recipe.title[widget.languageCode] ??
        widget.recipe.title['en'] ??
        '';
    final ingredients = widget.recipe.ingredients[widget.languageCode] ??
        widget.recipe.ingredients['en'] ??
        [];
    final steps = widget.recipe.steps[widget.languageCode] ??
        widget.recipe.steps['en'] ??
        [];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(recipeTitle),
        backgroundColor:
            widget.isDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            color: _isFavorite ? AppColors.accentRed : Colors.white,
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.recipe.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant, size: 64)),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.getCategoryColor(
                            widget.recipe.category.toString().split('.').last),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(_getCategoryName(widget.recipe.category),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Section
                  Card(
                    color:
                        widget.isDarkMode ? AppColors.darkCard : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          '${widget.recipe.rating.toStringAsFixed(1)}',
                                          style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.starActive)),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.star,
                                          color: AppColors.starActive,
                                          size: 32),
                                    ],
                                  ),
                                  Text(
                                      '${widget.recipe.ratingCount} ${loc.ratings}',
                                      style: TextStyle(
                                          color: widget.isDarkMode
                                              ? AppColors.darkTextSecondary
                                              : AppColors.lightTextSecondary)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(loc.yourRating,
                                      style: const TextStyle(fontSize: 12)),
                                  Row(
                                    children: List.generate(5, (index) {
                                      return GestureDetector(
                                        onTap: () => _saveRating(index + 1),
                                        child: Icon(
                                          index < _userRating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: AppColors.starActive,
                                          size: 24,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Nutrition Info
                  Card(
                    color:
                        widget.isDarkMode ? AppColors.darkCard : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.nutritionalInfo,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildNutrient(
                                  '${widget.recipe.nutrition.calories}',
                                  loc.calories,
                                  AppColors.caloriesColor,
                                  Icons.local_fire_department),
                              _buildNutrient(
                                  '${widget.recipe.nutrition.protein}g',
                                  loc.protein,
                                  AppColors.proteinColor,
                                  Icons.fitness_center),
                              _buildNutrient(
                                  '${widget.recipe.nutrition.carbs}g',
                                  loc.carbs,
                                  AppColors.carbsColor,
                                  Icons.bakery_dining),
                              _buildNutrient(
                                  '${widget.recipe.nutrition.fats}g',
                                  loc.fats,
                                  AppColors.fatsColor,
                                  Icons.water_drop),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(loc.ingredients,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  const SizedBox(height: 12),
                  Card(
                    color:
                        widget.isDarkMode ? AppColors.darkCard : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ingredients
                            .map((ing) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      const Text('• ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryGreen)),
                                      Expanded(
                                          child: Text(ing,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: textColor))),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(loc.preparationSteps,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map((entry) => Card(
                        color: widget.isDarkMode
                            ? AppColors.darkCard
                            : Colors.white,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryGreen,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                    child: Text('${entry.key + 1}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Text(entry.value,
                                      style: TextStyle(
                                          fontSize: 16, color: textColor))),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient(
      String value, String label, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                color: widget.isDarkMode
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary)),
      ],
    );
  }
}
