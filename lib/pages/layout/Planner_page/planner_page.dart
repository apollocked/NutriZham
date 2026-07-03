import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/meal_planner_provider.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<Recipe> _allRecipes = [];
  late final MealPlannerProvider _plannerProvider;

  @override
  void initState() {
    super.initState();
    _plannerProvider = context.read<MealPlannerProvider>();
    _plannerProvider.loadPlannedMeals();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('recipes').get();
    final recipesList =
        snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
    if (mounted) setState(() => _allRecipes = recipesList);
  }

  Future<void> _toggleMealInPlan(String recipeId) async {
    await _plannerProvider.toggleMealInPlan(recipeId);
    if (mounted) {
      final isInPlan = _plannerProvider.isInPlan(recipeId);
      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isInPlan ? loc.addToPlan : loc.removeFromPlan),
          duration: const Duration(seconds: 1),
          backgroundColor: isInPlan
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  int get _totalCalories => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0, (sum, r) => sum + r.nutrition.calories);
  // ignore: avoid_types_as_parameter_names
  double get _totalProtein => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (sum, r) => sum + r.nutrition.protein);
  double get _totalCarbs => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (sum, r) => sum + r.nutrition.carbs);
  double get _totalFats => _allRecipes
      .where((r) => _plannerProvider.isInPlan(r.id))
      .fold(0.0, (sum, r) => sum + r.nutrition.fats);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final planner = context.watch<MealPlannerProvider>();

    final plannedMeals =
        _allRecipes.where((r) => planner.isInPlan(r.id)).toList();
    final recommendedMeals =
        _allRecipes.where((r) => !planner.isInPlan(r.id)).take(25).toList();

    return Scaffold(
      appBar: CustomAppBar(title: loc.mealPlanner),
      body: Column(children: [
        _buildNutritionSummary(loc, theme, planner, plannedMeals),
        Expanded(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildSectionHeader(loc.dailyPlan, theme),
              _buildPlannedMealsList(loc, theme, planner, plannedMeals),
              const SizedBox(height: 24),
              _buildSectionHeader(loc.recommendedMeals, theme),
              _buildRecommendedMealsList(theme, planner, recommendedMeals),
              const SizedBox(height: 16),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildNutritionSummary(AppLocalizations loc, ThemeData theme,
      MealPlannerProvider planner, List<Recipe> plannedMeals) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary.withOpacity(0.05),
          theme.colorScheme.secondary.withOpacity(0.03)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: Column(children: [
        Text(loc.todaysMeals,
            style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outline),
              boxShadow: [
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ]),
          child: Column(children: [
            Text('$_totalCalories',
                style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 40,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            const Text('kcal',
                style: TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
                '${plannedMeals.length} ${plannedMeals.length == 1 ? loc.recipeFound : loc.recipesFound}',
                style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant, fontSize: 13)),
          ]),
        ),
        const SizedBox(height: 16),
        if (plannedMeals.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.colorScheme.outline)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroItem(
                      'Protein',
                      '${_totalProtein.toStringAsFixed(0)}g',
                      const Color(0xFF3B82F6)),
                  Container(
                      width: 1, height: 40, color: theme.colorScheme.outline),
                  _buildMacroItem('Carbs', '${_totalCarbs.toStringAsFixed(0)}g',
                      const Color(0xFFF59E0B)),
                  Container(
                      width: 1, height: 40, color: theme.colorScheme.outline),
                  _buildMacroItem('Fats', '${_totalFats.toStringAsFixed(0)}g',
                      const Color(0xFF8B5CF6)),
                ]),
          ),
      ]),
    );
  }

  Widget _buildMacroItem(String label, String value, Color color) {
    final theme = Theme.of(context);
    return Column(children: [
      Text(value,
          style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(children: [
        Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface)),
      ]),
    );
  }

  Widget _buildPlannedMealsList(AppLocalizations loc, ThemeData theme,
      MealPlannerProvider planner, List<Recipe> plannedMeals) {
    if (plannedMeals.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: EmptyStateWidget(
            icon: Icons.calendar_today_outlined,
            title: loc.emptyPlan,
            subtitle: loc.tapToSave),
      );
    }
    return Column(
        children: plannedMeals
            .map((recipe) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CompactRecipeCard(
                    recipe: recipe,
                    trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Color(0xFFEF4444)),
                        onPressed: () => _toggleMealInPlan(recipe.id)),
                  ),
                ))
            .toList());
  }

  Widget _buildRecommendedMealsList(ThemeData theme,
      MealPlannerProvider planner, List<Recipe> recommendedMeals) {
    return Column(
        children: recommendedMeals
            .map((recipe) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CompactRecipeCard(
                    recipe: recipe,
                    trailing: IconButton(
                        icon: const Icon(Icons.add_circle_outline,
                            color: Color(0xFF10B981)),
                        onPressed: () => _toggleMealInPlan(recipe.id)),
                  ),
                ))
            .toList());
  }
}
