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
      return Center(child: Text(AppLocalizations.of(context)!.selectIngredientsHint));
    }
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: ingredients.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final ing = ingredients[i];
        final isSel = selected.contains(ing);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Material(
            color: isSel ? theme.colorScheme.primary.withOpacity(0.08) : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onToggle(ing),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSel ? theme.colorScheme.primary.withOpacity(0.4) : theme.colorScheme.outlineVariant,
                  ),
                ),
                child: Row(children: [
                  Icon(
                    isSel ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 22,
                    color: isSel ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _titleCase(ing),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSel ? FontWeight.w600 : FontWeight.w400,
                        color: theme.colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ]),
              ),
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
