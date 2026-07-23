import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';

class EditGoalsDialog extends StatefulWidget {
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
  State<EditGoalsDialog> createState() => _EditGoalsDialogState();
}

class _EditGoalsDialogState extends State<EditGoalsDialog> {
  late final TextEditingController calCtrl;
  late final TextEditingController proteinCtrl;
  late final TextEditingController carbsCtrl;
  late final TextEditingController fatsCtrl;

  @override
  void initState() {
    super.initState();
    calCtrl = TextEditingController(text: widget.dailyCaloriesGoal.toString());
    proteinCtrl = TextEditingController(text: widget.dailyProteinGoal.toStringAsFixed(0));
    carbsCtrl = TextEditingController(text: widget.dailyCarbsGoal.toStringAsFixed(0));
    fatsCtrl = TextEditingController(text: widget.dailyFatsGoal.toStringAsFixed(0));
  }

  @override
  void dispose() {
    calCtrl.dispose();
    proteinCtrl.dispose();
    carbsCtrl.dispose();
    fatsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(loc.nutritionGoals, style: theme.textTheme.titleMedium),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _GoalField(controller: calCtrl, label: loc.caloriesGoal, suffix: ''),
            const SizedBox(height: 12),
            _GoalField(controller: proteinCtrl, label: loc.proteinGoal, suffix: 'g'),
            const SizedBox(height: 12),
            _GoalField(controller: carbsCtrl, label: loc.carbsGoal, suffix: 'g'),
            const SizedBox(height: 12),
            _GoalField(controller: fatsCtrl, label: loc.fatsGoal, suffix: 'g'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(loc.cancel),
        ),
        FilledButton(
          onPressed: () {
            context.read<MealPlannerCubit>().updateNutritionGoals(
                  calories: int.tryParse(calCtrl.text) ?? widget.dailyCaloriesGoal,
                  protein: double.tryParse(proteinCtrl.text) ?? widget.dailyProteinGoal,
                  carbs: double.tryParse(carbsCtrl.text) ?? widget.dailyCarbsGoal,
                  fats: double.tryParse(fatsCtrl.text) ?? widget.dailyFatsGoal,
                );
            Navigator.pop(context);
          },
          child: Text(loc.save),
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
