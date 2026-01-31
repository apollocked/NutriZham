import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';

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
      appBar: AppBar(
        title: Text(loc.mealPlanner),
        backgroundColor:
            widget.isDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.primaryGreen,
            child: Column(
              children: [
                Text(loc.todaysMeals,
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                Text('${loc.totalCalories}: $_totalCalories kcal',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: plannedMeals.isEmpty
                ? Center(
                    child: Text('${loc.addToPlan} meals',
                        style: TextStyle(color: textColor)))
                : ListView.builder(
                    itemCount: plannedMeals.length,
                    itemBuilder: (context, index) {
                      final recipe = plannedMeals[index];
                      return Card(
                        color: widget.isDarkMode
                            ? AppColors.darkCard
                            : Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(recipe.image,
                                width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text(recipe.title[widget.languageCode] ?? '',
                              style: TextStyle(color: textColor)),
                          subtitle: Text('${recipe.nutrition.calories} kcal'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: AppColors.error),
                            onPressed: () => _toggleMealInPlan(recipe.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(loc.recommendedMeals,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
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
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(recipe.image,
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(recipe.title[widget.languageCode] ?? '',
                      style: TextStyle(color: textColor)),
                  subtitle: Text('${recipe.nutrition.calories} kcal'),
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
