import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/nutrition_info_widget.dart';
import 'package:nutrizham/presentation/widgets/category_badge.dart';
import 'package:nutrizham/presentation/widgets/recipe_rating_card.dart';
import 'package:nutrizham/presentation/widgets/ingredients_list_widget.dart';
import 'package:nutrizham/presentation/widgets/steps_list_widget.dart';
import 'package:nutrizham/presentation/widgets/section_header.dart';

import 'package:nutrizham/l10n/app_localizations.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _userRating = 0;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesProvider>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(widget.recipe.id);

    final recipeTitle =
        widget.recipe.title[Localizations.localeOf(context).languageCode] ??
            widget.recipe.title['en'] ??
            '';
    final ingredients = widget
            .recipe.ingredients[Localizations.localeOf(context).languageCode] ??
        widget.recipe.ingredients['en'] ??
        [];
    final steps =
        widget.recipe.steps[Localizations.localeOf(context).languageCode] ??
            widget.recipe.steps['en'] ??
            [];

    return Scaffold(
      appBar: CustomAppBar(
        title: recipeTitle,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
            color: isFavorite ? const Color(0xFFEF4444) : null,
            onPressed: () => favorites.toggleFavorite(widget.recipe.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: CategoryBadge(category: widget.recipe.category),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RecipeRatingCard(
                rating: widget.recipe.rating,
                ratingCount: widget.recipe.ratingCount,
                userRating: _userRating,
                onRatingChanged: (rating) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 775),
                      behavior: SnackBarBehavior.floating,
                      content: Text('${loc.rating}: $rating/5'),
                      backgroundColor: const Color(0xFF10B981)),
                  );
                  setState(() => _userRating = rating);
                },
              ),
              const SizedBox(height: 16),
              NutritionInfoCard(nutrition: widget.recipe.nutrition),
              const SizedBox(height: 24),
              SectionHeader(title: loc.ingredients),
              const SizedBox(height: 12),
              IngredientsList(ingredients: ingredients),
              const SizedBox(height: 24),
              SectionHeader(title: loc.preparationSteps),
              const SizedBox(height: 12),
              StepsList(steps: steps),
              const SizedBox(height: 24),
            ]),
          ),
        ]),
      ),
    );
  }
}
