import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class IngredientChipsList extends StatelessWidget {
  final List<String> ingredients;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const IngredientChipsList({
    super.key,
    required this.ingredients,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noRecipesFound));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: ingredients.map((ing) => FilterChip(
          label: Text(_capitalize(ing), style: const TextStyle(fontSize: 13)),
          selected: selected.contains(ing),
          onSelected: (_) => onToggle(ing),
        )).toList(),
      ),
    );
  }

  String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
