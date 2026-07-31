import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/data/datasources/ratings_service.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/data/models/meal_plan_entry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/recipe/nutrition_info_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_rating_card.dart';
import 'package:nutrizham/presentation/widgets/recipe/ingredients_list_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/steps_list_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_header_card.dart';
import 'package:nutrizham/core/utils/category_label.dart';
import 'package:nutrizham/presentation/widgets/recipe/slot_button.dart';
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
  double _displayRating = 0.0;
  late int _ratingCount = widget.recipe.ratingCount;
  final RatingsService _ratingsService = RatingsService();

  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
    _displayRating = widget.recipe.rating;
    _loadUserRating();
  }

  Future<void> _loadUserRating() async {
    final rating = await _ratingsService.getUserRating(widget.recipe.id);
    if (!mounted) return;
    setState(() => _userRating = rating);
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Set<String> _slotsWithRecipe(List<MealPlanEntry> entries, String recipeId) {
    return entries.where((e) => e.recipeId == recipeId).map((e) => e.slot).toSet();
  }

  Future<void> _addToSlot(String slot) async {
    await context.read<MealPlannerCubit>().addMealToDate(widget.recipe.id, slot);
    if (!mounted) return;
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    final title = widget.recipe.title[locale] ?? widget.recipe.title['en'] ?? '';
    final slotLabel = categoryLabelFromName(slot, loc);
    messenger.showSnackBar(
      SnackBar(
        content: Text(loc.addedToSlot(title, slotLabel)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: theme.colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final favorites = context.watch<FavoritesCubit>();
    final isFavorite = favorites.isFavorite(widget.recipe.id);

    final planner = context.watch<MealPlannerCubit>();
    final ps = planner.state;
    final Set<String> addedSlots;
    if (ps is PlannerLoaded) {
      final entries = ps.mealPlans[_dateKey(ps.selectedDate)] ?? [];
      addedSlots = _slotsWithRecipe(entries, widget.recipe.id);
    } else {
      addedSlots = {};
    }

    final recipeTitle =
        widget.recipe.title[Localizations.localeOf(context).languageCode] ??
            widget.recipe.title['en'] ?? '';
    final ingredients = widget
            .recipe.ingredients[Localizations.localeOf(context).languageCode] ??
        widget.recipe.ingredients['en'] ?? [];
    final steps =
        widget.recipe.steps[Localizations.localeOf(context).languageCode] ??
            widget.recipe.steps['en'] ?? [];

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
          RecipeHeaderCard(recipe: widget.recipe, categoryColor: catColor, title: recipeTitle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RecipeRatingCard(
                rating: _displayRating,
                ratingCount: _ratingCount,
                userRating: _userRating,
                onRatingChanged: (rating) async {
                  final previous = _userRating;
                  setState(() => _userRating = rating);
                  try {
                    final newAvg = await _ratingsService.saveRating(widget.recipe.id, rating);
                    if (!mounted) return;
                    setState(() {
                      _displayRating = newAvg > 0 ? newAvg : _displayRating;
                      _ratingCount = previous == 0 && rating > 0
                          ? _ratingCount + 1
                          : _ratingCount;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: const Duration(milliseconds: 775),
                          behavior: SnackBarBehavior.floating,
                          content: Text('${loc.rating}: $rating/5'),
                          backgroundColor: Theme.of(context).colorScheme.primary),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    setState(() => _userRating = previous);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loc.ratingSaveFailed),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              NutritionInfoCard(nutrition: widget.recipe.nutrition),
              const SizedBox(height: 24),
              SectionHeader(title: loc.planThisMeal),
              const SizedBox(height: 12),
              Row(
                children: [
                  SlotButton(
                    icon: Icons.wb_sunny_rounded,
                    label: loc.breakfast,
                    color: AppColors.getCategoryColor('breakfast'),
                    isAdded: addedSlots.contains('breakfast'),
                    onTap: () => _addToSlot('breakfast'),
                  ),
                  const SizedBox(width: 8),
                  SlotButton(
                    icon: Icons.light_mode_rounded,
                    label: loc.lunch,
                    color: AppColors.getCategoryColor('lunch'),
                    isAdded: addedSlots.contains('lunch'),
                    onTap: () => _addToSlot('lunch'),
                  ),
                  const SizedBox(width: 8),
                  SlotButton(
                    icon: Icons.nightlight_round,
                    label: loc.dinner,
                    color: AppColors.getCategoryColor('dinner'),
                    isAdded: addedSlots.contains('dinner'),
                    onTap: () => _addToSlot('dinner'),
                  ),
                  const SizedBox(width: 8),
                  SlotButton(
                    icon: Icons.cookie_rounded,
                    label: loc.snack,
                    color: AppColors.getCategoryColor('snack'),
                    isAdded: addedSlots.contains('snack'),
                    onTap: () => _addToSlot('snack'),
                  ),
                ],
              ),
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
