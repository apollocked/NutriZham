import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/core/utils/ingredient_index.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/core/utils/category_label.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/common/ingredient_chips_list.dart';
import 'package:nutrizham/presentation/widgets/common/matched_recipes_grid.dart';
import 'package:nutrizham/presentation/widgets/planner/choose_slot_dialog.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class IngredientSearchPage extends StatefulWidget {
  final List<Recipe> allRecipes;
  const IngredientSearchPage({super.key, required this.allRecipes});

  @override
  State<IngredientSearchPage> createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _ingredientQuery = '';
  final Set<String> _selected = {};
  late final List<String> _allIngredients;

  @override
  void initState() {
    super.initState();
    IngredientIndex.instance.build(widget.allRecipes);
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

  List<Recipe> _matchedRecipes() {
    if (_selected.isEmpty) return [];
    final scored = <_RecipeMatch>[];
    for (final r in widget.allRecipes) {
      final recipeIngs = IngredientIndex.instance.ingredientsFor(r.id);
      final matched = _selected.where((s) => recipeIngs.contains(s));
      if (matched.isNotEmpty) {
        scored.add(_RecipeMatch(r, matched.length));
      }
    }
    scored.sort((a, b) => b.matchCount.compareTo(a.matchCount));
    return scored.map((s) => s.recipe).toList();
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Set<String> _addedSlots(String recipeId) {
    final ps = context.read<MealPlannerCubit>().state;
    if (ps is! PlannerLoaded) return {};
    final entries = ps.mealPlans[_dateKey(ps.selectedDate)] ?? [];
    return entries.where((e) => e.recipeId == recipeId).map((e) => e.slot).toSet();
  }

  Future<void> _addToPlanner(Recipe recipe) async {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final recipeTitle = recipe.title[locale] ?? recipe.title['en'] ?? '';
    final addedSlots = _addedSlots(recipe.id);
    final slot = await showChooseSlotDialog(context, recipeTitle: recipeTitle, addedSlots: addedSlots);
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
            onClear: () { setState(() { _ingredientQuery = ''; _searchCtrl.clear(); }); },
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
                child: const Text('Clear'),
                onPressed: () { setState(() => _selected.clear()); },
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
          onToggle: (ing) => setState(() {
            if (_selected.contains(ing)) { _selected.remove(ing); } else { _selected.add(ing); }
          }),
        )),
      ]);
    }
    final matched = _matchedRecipes();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: _sectionLabel(loc.recipesYouCanMake, theme),
      ),
      Expanded(child: MatchedRecipesGrid(
        recipes: matched,
        onLongPress: _addToPlanner,
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

class _RecipeMatch {
  final Recipe recipe;
  final int matchCount;
  const _RecipeMatch(this.recipe, this.matchCount);
}
