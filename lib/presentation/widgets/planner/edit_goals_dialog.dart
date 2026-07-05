import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';

class EditGoalsDialog extends StatelessWidget {
  final int dailyCaloriesGoal;
  final double dailyProteinGoal;
  final double dailyCarbsGoal;
  final double dailyFatsGoal;

  const EditGoalsDialog({
    super.key,
    required this.dailyCaloriesGoal,
    required this.dailyProteinGoal,
    required this.dailyCarbsGoal,
    required this.dailyFatsGoal,
  });

  static Future<void> show(BuildContext context, {
    required int dailyCaloriesGoal,
    required double dailyProteinGoal,
    required double dailyCarbsGoal,
    required double dailyFatsGoal,
  }) {
    return showDialog(
      context: context,
      builder: (_) => EditGoalsDialog(
        dailyCaloriesGoal: dailyCaloriesGoal,
        dailyProteinGoal: dailyProteinGoal,
        dailyCarbsGoal: dailyCarbsGoal,
        dailyFatsGoal: dailyFatsGoal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calCtrl = TextEditingController(text: dailyCaloriesGoal.toString());
    final proteinCtrl = TextEditingController(text: dailyProteinGoal.toStringAsFixed(0));
    final carbsCtrl = TextEditingController(text: dailyCarbsGoal.toStringAsFixed(0));
    final fatsCtrl = TextEditingController(text: dailyFatsGoal.toStringAsFixed(0));

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Daily Nutrition Goals', style: theme.textTheme.titleMedium),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _GoalField(controller: calCtrl, label: 'Calories (kcal)', suffix: ''),
            const SizedBox(height: 12),
            _GoalField(controller: proteinCtrl, label: 'Protein (g)', suffix: 'g'),
            const SizedBox(height: 12),
            _GoalField(controller: carbsCtrl, label: 'Carbs (g)', suffix: 'g'),
            const SizedBox(height: 12),
            _GoalField(controller: fatsCtrl, label: 'Fats (g)', suffix: 'g'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            context.read<MealPlannerCubit>().updateNutritionGoals(
                  calories: int.tryParse(calCtrl.text) ?? dailyCaloriesGoal,
                  protein: double.tryParse(proteinCtrl.text) ?? dailyProteinGoal,
                  carbs: double.tryParse(carbsCtrl.text) ?? dailyCarbsGoal,
                  fats: double.tryParse(fatsCtrl.text) ?? dailyFatsGoal,
                );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _GoalField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String suffix;

  const _GoalField({
    required this.controller,
    required this.label,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
