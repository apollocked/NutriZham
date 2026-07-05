import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

String categoryLabel(MealCategory category, BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  switch (category) {
    case MealCategory.breakfast: return loc.breakfast;
    case MealCategory.lunch: return loc.lunch;
    case MealCategory.dinner: return loc.dinner;
    case MealCategory.snack: return loc.snack;
    case MealCategory.bulking: return loc.bulking;
    case MealCategory.cutting: return loc.cutting;
  }
}

String categoryLabelFromName(String name, AppLocalizations loc) {
  switch (name) {
    case 'breakfast': return loc.breakfast;
    case 'lunch': return loc.lunch;
    case 'dinner': return loc.dinner;
    case 'snack': return loc.snack;
    default: return name;
  }
}
