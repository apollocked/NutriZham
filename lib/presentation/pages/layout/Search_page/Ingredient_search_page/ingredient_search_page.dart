import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/core/utils/ingredient_index.dart';
import 'package:nutrizham/core/utils/add_to_planner_mixin.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/common/ingredient_chips_list.dart';
import 'package:nutrizham/presentation/widgets/common/matched_recipes_grid.dart';
import 'package:nutrizham/presentation/widgets/common/mode_chip.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class IngredientSearchPage extends StatefulWidget {
  final List<Recipe> allRecipes;
  const IngredientSearchPage({super.key, required this.allRecipes});

  @override
  State<IngredientSearchPage> createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage>
    with AddToPlannerMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  String _ingredientQuery = '';
  final Set<String> _selected = {};
  late final List<String> _allIngredients;
  List<Recipe> _cachedMatched = [];
  bool _matchedDirty = false;

  @override
  void initState() {
    super.initState();
    if (IngredientIndex.instance.recipeCount == 0) {
      IngredientIndex.instance.build(widget.allRecipes);
    }
    _allIngredients = IngredientIndex.instance.allIngredients;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<String> get _filteredIngredients {
    if (_ingredientQuery.isEmpty) return _allIngredients;
    return _allIngredients
        .where((i) => i.contains(_ingredientQuery.toLowerCase()))
        .toList();
  }

  void _toggleIngredient(String ing) {
    setState(() {
      if (_selected.contains(ing)) {
        _selected.remove(ing);
      } else {
        _selected.add(ing);
      }
      _matchedDirty = true;
    });
  }

  void _clearSelected() {
    setState(() {
      _selected.clear();
      _cachedMatched = [];
      _matchedDirty = false;
    });
  }

  List<Recipe> _computeMatches() {
    if (_selected.isEmpty) return [];
    final counts = <String, int>{};
    for (final ing in _selected) {
      for (final id in IngredientIndex.instance.recipesContaining(ing)) {
        counts[id] = (counts[id] ?? 0) + 1;
      }
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final recipeMap = {for (final r in widget.allRecipes) r.id: r};
    return sorted.map((e) => recipeMap[e.key]).whereType<Recipe>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final filteredIngs = _filteredIngredients;

    return Scaffold(
      appBar: CustomAppBar(title: loc.searchByIngredients),
      body: Column(children: [
        _buildSearchHeader(loc, theme),
        if (_selected.isNotEmpty) _buildSelectedBar(loc),
        Expanded(child: _buildContent(loc, theme, filteredIngs)),
      ]),
    );
  }

  Widget _buildSearchHeader(AppLocalizations loc, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3))),
      ),
      child: Column(children: [
        CustomSearchBar(
          hintText: loc.searchIngredients,
          searchQuery: _ingredientQuery,
          onChanged: (v) => setState(() => _ingredientQuery = v),
          onClear: () { setState(() => _ingredientQuery = ''); _searchCtrl.clear(); },
          controller: _searchCtrl,
        ),
        const SizedBox(height: 6),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            _selected.isEmpty
                ? loc.pickIngredients
                : '${_selected.length} ${loc.pickIngredients.toLowerCase()}',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildSelectedBar(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(children: [
        const SizedBox(width: 12),
        ModeChip(
          icon: Icons.restaurant,
          label: loc.selectedCount('${_selected.length}'),
          active: true,
          onTap: _clearSelected,
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: _clearSelected,
          icon: const Icon(Icons.close, size: 18),
          label: Text(loc.clear, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }

  Widget _buildContent(AppLocalizations loc, ThemeData theme, List<String> filteredIngs) {
    if (_selected.isEmpty) {
      if (filteredIngs.isEmpty) return _emptyState(theme, loc.selectIngredientsHint);
      return IngredientChipsList(ingredients: filteredIngs, selected: _selected, onToggle: _toggleIngredient);
    }
    if (_matchedDirty) {
      _cachedMatched = _computeMatches();
      _matchedDirty = false;
    }
    if (_cachedMatched.isEmpty) return _emptyState(theme, loc.noMatchingRecipes);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Row(children: [
          Icon(Icons.auto_awesome, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(loc.recipesYouCanMake, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(loc.recipeCount('${_cachedMatched.length}'), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ]),
      ),
      Expanded(child: MatchedRecipesGrid(
        recipes: _cachedMatched,
        onLongPress: addToPlanner,
      )),
    ]);
  }

  Widget _emptyState(ThemeData theme, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 48, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(message, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
