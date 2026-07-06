import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/core/utils/ingredient_index.dart';
import 'package:nutrizham/core/utils/add_to_planner_mixin.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/common/ingredient_chips_list.dart';
import 'package:nutrizham/presentation/widgets/common/matched_recipes_grid.dart';
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: CustomSearchBar(
            hintText: loc.searchIngredients,
            searchQuery: _ingredientQuery,
            onChanged: (v) => setState(() => _ingredientQuery = v),
            onClear: () { setState(() => _ingredientQuery = ''); _searchCtrl.clear(); },
            controller: _searchCtrl,
          ),
        ),
        if (_selected.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Text('${_selected.length} ${loc.pickIngredients.toLowerCase()}',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
              const Spacer(),
              TextButton(
                onPressed: _clearSelected,
                child: const Text('Clear'),
              ),
            ]),
          ),
        Expanded(child: _buildContent(loc, theme, filteredIngs)),
      ]),
    );
  }

  Widget _buildContent(AppLocalizations loc, ThemeData theme, List<String> filteredIngs) {
    if (_selected.isEmpty) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: _sectionLabel(loc.pickIngredients, theme),
        ),
        Expanded(child: IngredientChipsList(
          ingredients: filteredIngs,
          selected: _selected,
          onToggle: _toggleIngredient,
        )),
      ]);
    }
    if (_matchedDirty) {
      _cachedMatched = _computeMatches();
      _matchedDirty = false;
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: _sectionLabel(loc.recipesYouCanMake, theme),
      ),
      Expanded(child: MatchedRecipesGrid(
        recipes: _cachedMatched,
        onLongPress: addToPlanner,
      )),
    ]);
  }

  Widget _sectionLabel(String label, ThemeData theme) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(label, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
