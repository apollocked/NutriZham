// ignore_for_file: use_build_context_synchronously, unnecessary_cast, avoid_types_as_parameter_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/services/meal_planner_service.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class PlannerPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const PlannerPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<String> _plannedMealIds = [];
  StreamSubscription<List<String>>? _plannerSubscription;
  List<Recipe> _allRecipes = []; // Cache list

  @override
  void initState() {
    super.initState();
    _loadPlannedMeals();
    _setupPlannerListener();
    _loadRecipes(); //Load data
  }

  Future<void> _loadRecipes() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recipes').get();
    final recipesList = snapshot.docs
        .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    if (mounted) {
      setState(() => _allRecipes = recipesList);
    }
  }

  @override
  void dispose() {
    _plannerSubscription?.cancel();
    super.dispose();
  }

  void _setupPlannerListener() {
    _plannerSubscription =
        MealPlannerService.plannedMealsStream.listen((plannedMeals) {
      if (mounted) {
        setState(() => _plannedMealIds = plannedMeals);
      }
    });
  }

  Future<void> _loadPlannedMeals() async {
    final plannedMeals = await MealPlannerService.loadPlannedMeals();
    if (mounted) {
      setState(() => _plannedMealIds = plannedMeals);
    }
  }

  Future<void> _toggleMealInPlan(String recipeId, dynamic loc) async {
    await MealPlannerService.toggleMealInPlan(recipeId);

    if (mounted) {
      final isInPlan = _plannedMealIds.contains(recipeId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isInPlan ? loc.removeFromPlan : loc.addToPlan),
          duration: const Duration(seconds: 1),
          backgroundColor: isInPlan ? AppColors.error : AppColors.success,
        ),
      );
    }
  }

  int get _totalCalories {
    return _allRecipes
        .where((r) => _plannedMealIds.contains(r.id))
        .fold(0, (sum, r) => sum + r.nutrition.calories);
  }

  double get _totalProtein {
    return _allRecipes
        .where((r) => _plannedMealIds.contains(r.id))
        .fold(0.0, (sum, r) => sum + r.nutrition.protein);
  }

  double get _totalCarbs {
    return _allRecipes
        .where((r) => _plannedMealIds.contains(r.id))
        .fold(0.0, (sum, r) => sum + r.nutrition.carbs);
  }

  double get _totalFats {
    return _allRecipes
        .where((r) => _plannedMealIds.contains(r.id))
        .fold(0.0, (sum, r) => sum + r.nutrition.fats);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final plannedMeals =
        _allRecipes.where((r) => _plannedMealIds.contains(r.id)).toList();
    final recommendedMeals = _allRecipes
        .where((r) => !_plannedMealIds.contains(r.id))
        .take(25)
        .toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: loc.mealPlanner,
        isDarkMode: widget.isDarkMode,
      ),
      body: Column(
        children: [
          // Nutrition Summary
          _buildNutritionSummary(loc, plannedMeals),

          // Planned meals list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Plan Section
                  _buildSectionHeader(loc.dailyPlan, textColor),
                  _buildPlannedMealsList(loc, plannedMeals),

                  const SizedBox(height: 24),

                  // Recommended Meals Section
                  _buildSectionHeader(loc.recommendedMeals, textColor),
                  _buildRecommendedMealsList(recommendedMeals),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary(
      AppLocalizations loc, List<Recipe> plannedMeals) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? AppColors.darkCard : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: widget.isDarkMode
                ? AppColors.darkDivider
                : AppColors.lightDivider,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            loc.todaysMeals,
            style: TextStyle(
              color: widget.isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Total Calories
          Text(
            '$_totalCalories kcal',
            style: TextStyle(
              color:
                  widget.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${plannedMeals.length} ${plannedMeals.length == 1 ? loc.recipeFound : loc.recipesFound}',
            style: TextStyle(
              color: widget.isDarkMode
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 16),

          // Macros breakdown
          if (plannedMeals.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.isDarkMode
                      ? AppColors.darkDivider
                      : AppColors.lightDivider,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroItem('P', '${_totalProtein.toStringAsFixed(0)}g',
                      AppColors.proteinColor),
                  Container(
                      width: 1,
                      height: 30,
                      color: widget.isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider),
                  _buildMacroItem('C', '${_totalCarbs.toStringAsFixed(0)}g',
                      AppColors.carbsColor),
                  Container(
                      width: 1,
                      height: 30,
                      color: widget.isDarkMode
                          ? AppColors.darkDivider
                          : AppColors.lightDivider),
                  _buildMacroItem('F', '${_totalFats.toStringAsFixed(0)}g',
                      AppColors.fatsColor),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildPlannedMealsList(
      AppLocalizations loc, List<Recipe> plannedMeals) {
    if (plannedMeals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: EmptyStateWidget(
          icon: Icons.calendar_today_outlined,
          title: loc.emptyplan,
          subtitle: '${loc.tapToSave} ',
          isDarkMode: widget.isDarkMode,
        ),
      );
    }

    return Column(
      children: plannedMeals.map((recipe) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: CompactRecipeCard(
            recipe: recipe,
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline,
                  color: AppColors.error),
              onPressed: () => _toggleMealInPlan(
                  recipe.id, AppLocalizations.of(widget.languageCode)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommendedMealsList(List<Recipe> recommendedMeals) {
    return Column(
      children: recommendedMeals.map((recipe) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: CompactRecipeCard(
            recipe: recipe,
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline,
                  color: AppColors.primaryGreen),
              onPressed: () => _toggleMealInPlan(
                  recipe.id, AppLocalizations.of(widget.languageCode)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
