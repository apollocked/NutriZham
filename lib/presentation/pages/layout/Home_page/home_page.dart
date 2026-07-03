import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/presentation/providers/recipe_provider.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
import 'package:nutrizham/presentation/widgets/home_category_chips.dart';
import 'package:nutrizham/presentation/widgets/recipe_of_the_day_card.dart';
import 'package:nutrizham/presentation/widgets/section_header.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  MealCategory? _selectedCategory;
  bool _showFavoritesOnly = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Recipe> _allRecipes = [];
  bool _isLoading = true, _isLoadingMore = false, _hasMore = true;
  String? _lastRecipeTitle;
  final int _pageSize = 25;
  late final FavoritesProvider _favoritesProvider;
  @override void initState() {
    super.initState();
    _favoritesProvider = context.read<FavoritesProvider>();
    _favoritesProvider.loadFavorites();
    _loadNextBatch();
    _scrollController.addListener(() {
      if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly &&
          _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _loadNextBatch();
      }
    });
  }
  @override void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  Future<void> _loadNextBatch() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);
    try {
      final newRecipes = await context.read<RecipeProvider>().getNextBatch(
        lastRecipeTitle: _lastRecipeTitle, limit: _pageSize);
      if (newRecipes.isEmpty) {
        setState(() { _hasMore = false; _isLoadingMore = false; _isLoading = false; });
        return;
      }
      if (mounted) { setState(() { _allRecipes.addAll(newRecipes); _lastRecipeTitle = newRecipes.last.title['en'] ?? ''; _hasMore = newRecipes.length == _pageSize; _isLoadingMore = false; _isLoading = false; }); }
    } catch (_) { if (mounted) { setState(() { _isLoadingMore = false; _isLoading = false; }); } }
  }
  List<Recipe> get _paginatedRecipes => _allRecipes.where((r) {
    final c = context.read<SettingsProvider>().languageCode;
    final t = r.title[c] ?? r.title['en'] ?? '';
    return (_searchQuery.isEmpty || t.toLowerCase().contains(_searchQuery.toLowerCase())) && (_selectedCategory == null || r.category == _selectedCategory) && (!_showFavoritesOnly || _favoritesProvider.isFavorite(r.id));
  }).toList();
  Recipe get _recipeOfTheDay => _allRecipes.isEmpty ? Recipe(id: '0', title: {}, icon: '', nutrition: NutritionalInfo(calories: 0, protein: 0, carbs: 0, fats: 0), ingredients: {}, steps: {}, category: MealCategory.snack) : _allRecipes[DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays % _allRecipes.length];
  @override Widget build(BuildContext context) {
    final paginatedRecipes = _paginatedRecipes;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: loc.appTitle, actions: [
        IconButton(
          icon: Icon(_showFavoritesOnly ? Icons.favorite : Icons.favorite_outline, color: _showFavoritesOnly ? const Color(0xFFEF4444) : null),
          onPressed: () => setState(() => _showFavoritesOnly = !_showFavoritesOnly)),
      ]),
      body: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: CustomSearchBar(
          hintText: loc.searchPlaceholder, searchQuery: _searchQuery,
          onChanged: (v) => setState(() => _searchQuery = v),
          onClear: () { setState(() { _searchQuery = ''; _searchController.clear(); }); },
          controller: _searchController,
        )),
        HomeCategoryChips(selectedCategory: _selectedCategory, onCategorySelected: (v) => setState(() => _selectedCategory = v)),
        if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly)
          RecipeOfTheDayCard(recipe: _recipeOfTheDay),
        SectionHeader(title: _showFavoritesOnly ? loc.favorites : loc.recipes, count: paginatedRecipes.length),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF10B981)))
              : paginatedRecipes.isEmpty
                  ? EmptyStateWidget(
                      icon: _showFavoritesOnly ? Icons.favorite_outline : Icons.search_off,
                      title: _showFavoritesOnly ? loc.noFavorites : loc.noRecipesFound,
                      subtitle: _showFavoritesOnly ? loc.tapToSave : loc.tryDifferentSearch)
                  : NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly &&
                            !_isLoadingMore && _hasMore &&
                            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
                          _loadNextBatch();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: paginatedRecipes.length + (_hasMore && _isLoadingMore ? 1 : 0),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          if (index == paginatedRecipes.length) {
                            return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(color: Color(0xFF10B981))));
                          }
                          final recipe = paginatedRecipes[index];
                          return RecipeCard(
                            recipe: recipe, isFavorite: context.watch<FavoritesProvider>().isFavorite(recipe.id),
                            onFavoriteToggle: () => context.read<FavoritesProvider>().toggleFavorite(recipe.id),
                            onTap: () => context.push('/recipe/$recipe.id', extra: recipe));
                        },
                      )),
        ),
      ])),
    );
  }
}
