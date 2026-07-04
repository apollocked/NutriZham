import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/recipe/nutrition_info_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/category_badge.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_rating_card.dart';
import 'package:nutrizham/presentation/widgets/recipe/ingredients_list_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/steps_list_widget.dart';
import 'package:nutrizham/presentation/widgets/common/section_header.dart';
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
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final favorites = context.watch<FavoritesCubit>();
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

    final catName = widget.recipe.category.toString().split('.').last;
    final catColor = AppColors.getCategoryColor(catName);

    return Scaffold(
      appBar: CustomAppBar(
        title: recipeTitle,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
            color: isFavorite ? AppColors.accentRed : null,
            onPressed: () => favorites.toggleFavorite(widget.recipe.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  catColor.withOpacity(0.12),
                  catColor.withOpacity(0.03)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: catColor.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                Text(widget.recipe.icon, style: const TextStyle(fontSize: 52)),
                const SizedBox(height: 16),
                CategoryBadge(category: widget.recipe.category),
                const SizedBox(height: 16),
                Text(recipeTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text('${widget.recipe.nutrition.calories} kcal',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.caloriesColor)),
              ],
            ),
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
                        backgroundColor: Theme.of(context).colorScheme.primary),
                  );
                  setState(() => _userRating = rating);
                },
              ),
              const SizedBox(height: 16),
              NutritionInfoCard(nutrition: widget.recipe.nutrition),
              const SizedBox(height: 24),
              SectionHeader(title: loc.ingredients),
              const SizedBox(height: 8),
              IngredientsList(ingredients: ingredients),
              const SizedBox(height: 24),
              SectionHeader(title: loc.preparationSteps),
              const SizedBox(height: 8),
              StepsList(steps: steps),
              const SizedBox(height: 32),
            ]),
          ),
        ]),
      ),
    );
  }
}
