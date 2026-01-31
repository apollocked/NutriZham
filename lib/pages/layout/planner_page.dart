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
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 64,
                          color: textColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          loc.addToPlan,
                          style: TextStyle(
                            fontSize: 18,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${loc.tapToSave} recommended meals below',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
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
                            child: Image.network(
                              recipe.icon,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[300],
                                child: const Icon(Icons.restaurant,
                                    size: 30, color: Colors.grey),
                              ),
                            ),
                          ),
                          title: Text(
                            recipe.title[widget.languageCode] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textColor),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                  '${recipe.nutrition.calories} kcal • ${_getCategoryName(recipe.category)}'),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.starActive, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                      '${recipe.rating.toStringAsFixed(1)} (${recipe.ratingCount})',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
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
                return Card(
                  color: widget.isDarkMode ? AppColors.darkCard : Colors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        recipe.icon,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                          child: const Icon(Icons.restaurant,
                              size: 25, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(
                      recipe.title[widget.languageCode] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                            '${recipe.nutrition.calories} kcal • ${_getCategoryName(recipe.category)}'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.starActive, size: 16),
                            const SizedBox(width: 4),
                            Text(
                                '${recipe.rating.toStringAsFixed(1)} (${recipe.ratingCount})',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle,
                          color: AppColors.primaryGreen),
                      onPressed: () => _toggleMealInPlan(recipe.id),
                    ),
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
