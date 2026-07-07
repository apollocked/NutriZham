import 'package:nutrizham/data/models/meal_plan_entry.dart';

sealed class MealPlannerState {
  const MealPlannerState();
}

class PlannerInitial extends MealPlannerState {
  const PlannerInitial();
}

class PlannerLoading extends MealPlannerState {
  const PlannerLoading();
}

class PlannerLoaded extends MealPlannerState {
  final Map<String, List<MealPlanEntry>> mealPlans;
  final DateTime selectedDate;
  final DateTime weekStart;
  final int dailyCaloriesGoal;
  final double dailyProteinGoal;
  final double dailyCarbsGoal;
  final double dailyFatsGoal;

  const PlannerLoaded({
    required this.mealPlans,
    required this.selectedDate,
    required this.weekStart,
    this.dailyCaloriesGoal = 2000,
    this.dailyProteinGoal = 150,
    this.dailyCarbsGoal = 250,
    this.dailyFatsGoal = 65,
  });

  PlannerLoaded copyWith({
    Map<String, List<MealPlanEntry>>? mealPlans,
    DateTime? selectedDate,
    DateTime? weekStart,
    int? dailyCaloriesGoal,
    double? dailyProteinGoal,
    double? dailyCarbsGoal,
    double? dailyFatsGoal,
  }) {
    return PlannerLoaded(
      mealPlans: mealPlans ?? this.mealPlans,
      selectedDate: selectedDate ?? this.selectedDate,
      weekStart: weekStart ?? this.weekStart,
      dailyCaloriesGoal: dailyCaloriesGoal ?? this.dailyCaloriesGoal,
      dailyProteinGoal: dailyProteinGoal ?? this.dailyProteinGoal,
      dailyCarbsGoal: dailyCarbsGoal ?? this.dailyCarbsGoal,
      dailyFatsGoal: dailyFatsGoal ?? this.dailyFatsGoal,
    );
  }
}

class PlannerError extends MealPlannerState {
  final String message;
  const PlannerError(this.message);
}
