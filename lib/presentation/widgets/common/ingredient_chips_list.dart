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
    return ListView.builder(
      itemCount: ingredients.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final ing = ingredients[i];
        final isSel = selected.contains(ing);
        return InkWell(
          onTap: () => onToggle(ing),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              children: [
                Icon(
                  isSel ? Icons.check_circle : Icons.circle_outlined,
                  size: 22,
                  color: isSel ? Theme.of(context).colorScheme.primary : null,
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    _titleCase(ing),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSel ? FontWeight.w600 : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s.split(' ').map((w) {
      if (w.isEmpty) return w;
      return '${w[0].toUpperCase()}${w.substring(1)}';
    }).join(' ');
  }
}
