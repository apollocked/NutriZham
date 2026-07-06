import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/favorites_cubit.dart';
import 'package:nutrizham/presentation/blocs/meal_planner_cubit.dart';
import 'package:nutrizham/core/utils/category_label.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe/recipe_card.dart';
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
  List<String> _allIngredients = [];

  @override
  void initState() {
    super.initState();
    final seen = <String>{};
    for (final r in widget.allRecipes) {
      for (final list in r.ingredients.values) {
        for (final ing in list) {
          final cleaned = ing.trim().toLowerCase();
          if (cleaned.isNotEmpty) seen.add(cleaned);
        }
      }
    }
    _allIngredients = seen.toList()..sort();
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

  List<_RecipeMatch> _matchedRecipes(AppLocalizations loc) {
    if (_selected.isEmpty) return [];
    final lang = loc.localeName;
    final scored = <_RecipeMatch>[];
    for (final r in widget.allRecipes) {
      final recipeIngs = <String>{};
      for (final list in r.ingredients.values) {
        for (final ing in list) {
          recipeIngs.add(ing.trim().toLowerCase());
        }
      }
      final matched = _selected.where((s) => recipeIngs.contains(s));
      if (matched.isNotEmpty) {
        final title = r.title[lang] ?? r.title['en'] ?? '';
        scored.add(_RecipeMatch(r, matched.length, title));
      }
    }
    scored.sort((a, b) => b.matchCount.compareTo(a.matchCount));
    return scored;
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
    final matched = _matchedRecipes(loc);
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
            onClear: () => setState(() { _ingredientQuery = ''; _searchCtrl.clear(); }),
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
                child: Text(loc.clear),
                onPressed: () => setState(_selected.clear()),
              ),
            ]),
          ),
        Expanded(
          child: _selected.isEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: _buildSectionLabel(loc.pickIngredients, theme),
                  ),
                  Expanded(child: _buildChipsList(filteredIngs)),
                ])
              : Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: _buildSectionLabel(loc.recipesYouCanMake, theme),
                  ),
                  Expanded(child: matched.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off, size: 48, color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(height: 8),
                            Text(loc.noMatchingRecipes, style: theme.textTheme.bodyLarge),
                          ],
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.82, crossAxisSpacing: 0, mainAxisSpacing: 0,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        itemCount: matched.length,
                        itemBuilder: (_, i) {
                          final m = matched[i];
                          final favorites = context.watch<FavoritesCubit>();
                          return DelayedReveal(
                            index: i,
                            child: RecipeCard(
                              recipe: m.recipe,
                              isFavorite: favorites.isFavorite(m.recipe.id),
                              onFavoriteToggle: () => favorites.toggleFavorite(m.recipe.id),
                              onTap: () => context.push('/recipe/${m.recipe.id}', extra: m.recipe),
                              onLongPress: () => _addToPlanner(m.recipe),
                            ),
                          );
                        },
                      ),
                  ),
                ]),
        ),
      ]),
    );
  }

  Widget _buildChipsList(List<String> ingredients) {
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
          selected: _selected.contains(ing),
          onSelected: (v) => setState(() {
            if (v) { _selected.add(ing); } else { _selected.remove(ing); }
          }),
        )).toList(),
      ),
    );
  }

  Widget _buildSectionLabel(String label, ThemeData theme) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(label, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}

class _RecipeMatch {
  final Recipe recipe;
  final int matchCount;
  final String title;
  const _RecipeMatch(this.recipe, this.matchCount, this.title);
}
