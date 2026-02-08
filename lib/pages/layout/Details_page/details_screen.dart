// ignore_for_file: use_build_context_synchronously

import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/nutrition_info_widget.dart';
import 'package:nutrizham/widgets/category_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/favorites_helper.dart';
import 'dart:async';

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
  StreamSubscription<Set<String>>? _favoritesSubscription;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadUserRating();
    _setupFavoritesListener();
  }

  @override
  void dispose() {
    _favoritesSubscription?.cancel();
    super.dispose();
  }

  void _setupFavoritesListener() {
    _favoritesSubscription =
        FavoritesHelper.favoritesStream.listen((favorites) {
      if (mounted) {
        setState(() {
          _isFavorite = favorites.contains(widget.recipe.id);
        });
      }
    });
  }

  Future<void> _loadFavoriteStatus() async {
    final isFav = await FavoritesHelper.isFavorite(widget.recipe.id);
    if (mounted) {
      setState(() => _isFavorite = isFav);
    }
  }

  Future<void> _loadUserRating() async {
    // For now, we'll keep this simple
    // You can implement actual rating logic later
  }

  Future<void> _toggleFavorite() async {
    await FavoritesHelper.toggleFavorite(widget.recipe.id);
    AppLocalizations.of(widget.languageCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(_isFavorite ? "Removed from favorites" : 'Added to favorites'),
        duration: const Duration(seconds: 1),
        backgroundColor: _isFavorite ? AppColors.error : AppColors.success,
      ),
    );
  }

  Future<void> _saveRating(int rating) async {
    // Implement rating logic here
    final loc = AppLocalizations.of(widget.languageCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 775),
        behavior: SnackBarBehavior.floating,
        content: Text('${loc.rating}: $rating/5'),
        backgroundColor: AppColors.success,
      ),
    );
    setState(() => _userRating = rating);
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
      appBar: CustomAppBar(
        title: recipeTitle,
        isDarkMode: widget.isDarkMode,
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_outline),
            color: _isFavorite ? AppColors.accentRed : null,
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Padding(
              padding: const EdgeInsets.all(16),
              child: CategoryBadge(
                category: widget.recipe.category,
                languageCode: widget.languageCode,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          widget.isDarkMode ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
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
                                      widget.recipe.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.starActive,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.starActive,
                                      size: 28,
                                    ),
                                  ],
                                ),
                                Text(
                                  '${widget.recipe.ratingCount} ${loc.ratings}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: widget.isDarkMode
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  loc.yourRating,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: widget.isDarkMode
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (index) {
                                    return GestureDetector(
                                      onTap: () => _saveRating(index + 1),
                                      child: Icon(
                                        index < _userRating
                                            ? Icons.star
                                            : Icons.star_outline,
                                        color: AppColors.starActive,
                                        size: 20,
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

                  const SizedBox(height: 16),

                  // Nutrition Info
                  NutritionInfoCard(
                    nutrition: widget.recipe.nutrition,
                    isDarkMode: widget.isDarkMode,
                    languageCode: widget.languageCode,
                  ),

                  const SizedBox(height: 24),

                  // Ingredients
                  Text(
                    loc.ingredients,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          widget.isDarkMode ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ingredients
                          .map((ing) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryGreen,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ing,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Preparation Steps
                  Text(
                    loc.preparationSteps,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map((entry) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: widget.isDarkMode
                              ? AppColors.darkCard
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.isDarkMode
                                ? AppColors.darkDivider
                                : AppColors.lightDivider,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryGreen,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
