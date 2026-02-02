import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/recipe_card.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class PlannerPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const PlannerPage(
      {super.key, required this.isDarkMode, required this.languageCode});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  List<String> _plannedMealIds = [];

  @override
  void initState() {
    super.initState();
    _loadPlannedMeals();
  }

  Future<void> _loadPlannedMeals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _plannedMealIds = prefs.getStringList('planned_meals') ?? [];
    });
  }

  Future<void> _toggleMealInPlan(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_plannedMealIds.contains(recipeId)) {
        _plannedMealIds.remove(recipeId);
      } else {
        _plannedMealIds.add(recipeId);
      }
    });
    await prefs.setStringList('planned_meals', _plannedMealIds);
  }

  int get _totalCalories {
    return recipes
        .where((r) => _plannedMealIds.contains(r.id))
        .fold(0, (sum, r) => sum + r.nutrition.calories);
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
        recipes.where((r) => _plannedMealIds.contains(r.id)).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: loc.mealPlanner,
        isDarkMode: widget.isDarkMode,
      ),
      body: Column(
        children: [
          // Today's meals header with total calories
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.primaryGreenLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(loc.todaysMeals,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${loc.totalCalories}: $_totalCalories kcal',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  '${plannedMeals.length} ${plannedMeals.length == 1 ? loc.recipeFound : loc.recipesFound}',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          // Planned meals list
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              loc.dailyPlan,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: plannedMeals.isEmpty
                ? Expanded(
                    child: EmptyStateWidget(
                      icon: Icons.calendar_today,
                      title: loc.addToPlan,
                      subtitle: '${loc.tapToSave} ',
                      isDarkMode: widget.isDarkMode,
                    ),
                  )
                : ListView.builder(
                    itemCount: plannedMeals.length,
                    itemBuilder: (context, index) {
                      final recipe = plannedMeals[index];
                      return CompactRecipeCard(
                        recipe: recipe,
                        isDarkMode: widget.isDarkMode,
                        languageCode: widget.languageCode,
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: AppColors.error),
                          onPressed: () => _toggleMealInPlan(recipe.id),
                        ),
                      );
                    },
                  ),
          ),
          // Recommended meals section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              loc.recommendedMeals,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes
                  .where((r) => !_plannedMealIds.contains(r.id))
                  .take(5)
                  .length,
              itemBuilder: (context, index) {
                final recipe = recipes
                    .where((r) => !_plannedMealIds.contains(r.id))
                    .toList()[index];
                return CompactRecipeCard(
                  recipe: recipe,
                  isDarkMode: widget.isDarkMode,
                  languageCode: widget.languageCode,
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.primaryGreen),
                    onPressed: () => _toggleMealInPlan(recipe.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
