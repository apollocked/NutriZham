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

  Future<void> _loadUserRating() async {}

  Future<void> _toggleFavorite() async {
    await FavoritesHelper.toggleFavorite(widget.recipe.id);
    AppLocalizations.of(widget.languageCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isFavorite ? 'Added to favorites' : "Removed from favorites",
            style: TextStyle(
                color: widget.isDarkMode
                    ? AppColors.lightText
                    : AppColors.darkText)),
        duration: const Duration(seconds: 1),
        backgroundColor: _isFavorite ? AppColors.success : AppColors.error,
      ),
    );
  }

  Future<void> _saveRating(int rating) async {
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

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: widget.isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final cardColor = widget.isDarkMode ? AppColors.darkCard : Colors.white;
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: widget.isDarkMode
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                    child: Row(
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
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.starActive,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.starActive,
                                  size: 28,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Icon(
                                      index < _userRating
                                          ? Icons.star_rounded
                                          : Icons.star_outline_rounded,
                                      color: AppColors.starActive,
                                      size: 22,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  NutritionInfoCard(
                    nutrition: widget.recipe.nutrition,
                    isDarkMode: widget.isDarkMode,
                    languageCode: widget.languageCode,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader(loc.ingredients),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
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
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      margin: const EdgeInsets.only(top: 7),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        ing,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: textColor,
                                          height: 1.4,
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
                  _buildSectionHeader(loc.preparationSteps),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map((entry) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: widget.isDarkMode
                                ? AppColors.darkDivider
                                : AppColors.lightDivider,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryGreen,
                                    AppColors.primaryGreenDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
