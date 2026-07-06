import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/core/utils/category_label.dart';
import 'package:nutrizham/presentation/widgets/planner/choose_slot_dialog.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

mixin AddToPlannerMixin<T extends StatefulWidget> on State<T> {
  String dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Set<String> addedSlots(String recipeId) {
    final ps = context.read<MealPlannerCubit>().state;
    if (ps is! PlannerLoaded) return {};
    final entries = ps.mealPlans[dateKey(ps.selectedDate)] ?? [];
    return entries.where((e) => e.recipeId == recipeId).map((e) => e.slot).toSet();
  }

  Future<void> addToPlanner(Recipe recipe) async {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final recipeTitle = recipe.title[locale] ?? recipe.title['en'] ?? '';
    final slots = addedSlots(recipe.id);
    final slot = await showChooseSlotDialog(context, recipeTitle: recipeTitle, addedSlots: slots);
    if (slot == null || !mounted) return;
    context.read<MealPlannerCubit>().addMealToDate(recipe.id, slot);
    if (!mounted) return;
    final slotLabel = categoryLabelFromName(slot, loc);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.addedToSlot(recipeTitle, slotLabel)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
