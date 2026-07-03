import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/settings_provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/data/models/meals_data.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/empty_state_widget.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/search_bar_widget.dart';
import 'package:nutrizham/presentation/widgets/recipe_card.dart';
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
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  final int _pageSize = 25;

  late final FavoritesProvider _favoritesProvider;

  @override
  void initState() {
    super.initState();
    _favoritesProvider = context.read<FavoritesProvider>();
    _favoritesProvider.loadFavorites();
    _setupScrollListener();
    _loadNextBatch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly) {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
          _loadNextBatch();
        }
      }
    });
  }

  Future<void> _loadNextBatch() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    try {
      Query query = FirebaseFirestore.instance.collection('recipes').orderBy('title').limit(_pageSize);
      if (_lastDocument != null) query = query.startAfterDocument(_lastDocument!);

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        setState(() { _hasMore = false; _isLoadingMore = false; _isLoading = false; });
        return;
      }

      final newRecipes = snapshot.docs.map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>)).toList();
      if (mounted) setState(() {
        _allRecipes.addAll(newRecipes);
        _lastDocument = snapshot.docs.last;
        _hasMore = newRecipes.length == _pageSize;
        _isLoadingMore = false;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() { _isLoadingMore = false; _isLoading = false; });
    }
  }

  List<Recipe> get _paginatedRecipes {
    final langCode = context.read<SettingsProvider>().languageCode;
    return _allRecipes.where((recipe) {
      final title = recipe.title[langCode] ?? recipe.title['en'] ?? '';
      final matchesSearch = _searchQuery.isEmpty || title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || recipe.category == _selectedCategory;
      final matchesFavorites = !_showFavoritesOnly || _favoritesProvider.isFavorite(recipe.id);
      return matchesSearch && matchesCategory && matchesFavorites;
    }).toList();
  }

  Recipe get _recipeOfTheDay {
    if (_allRecipes.isEmpty) return Recipe(id: '0', title: {}, icon: '', nutrition: NutritionalInfo(calories: 0, protein: 0, carbs: 0, fats: 0), ingredients: {}, steps: {}, category: MealCategory.snack);
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return _allRecipes[dayOfYear % _allRecipes.length];
  }

  String _getCategoryName(MealCategory category) {
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

  @override
  Widget build(BuildContext context) {
    final paginatedRecipes = _paginatedRecipes;
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.appTitle,
        actions: [
          IconButton(
            icon: Icon(_showFavoritesOnly ? Icons.favorite : Icons.favorite_outline, color: _showFavoritesOnly ? const Color(0xFFEF4444) : null),
            onPressed: () => setState(() => _showFavoritesOnly = !_showFavoritesOnly),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: loc.searchPlaceholder,
              searchQuery: _searchQuery,
              onChanged: (v) => setState(() => _searchQuery = v),
              onClear: () { setState(() { _searchQuery = ''; _searchController.clear(); }); },
              controller: _searchController,
            ),
          ),
          _buildCategoryChips(),
          if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly) _buildRecipeOfTheDay(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              Container(width: 4, height: 20, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Text(_showFavoritesOnly ? loc.favorites : loc.recipes, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text('${paginatedRecipes.length}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF10B981)))),
            ]),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF10B981)))
                : paginatedRecipes.isEmpty
                    ? EmptyStateWidget(
                        icon: _showFavoritesOnly ? Icons.favorite_outline : Icons.search_off,
                        title: _showFavoritesOnly ? loc.noFavorites : loc.noRecipesFound,
                        subtitle: _showFavoritesOnly ? loc.tapToSave : loc.tryDifferentSearch,
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (_searchQuery.isEmpty && _selectedCategory == null && !_showFavoritesOnly && !_isLoadingMore && _hasMore &&
                              scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) _loadNextBatch();
                          return false;
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: paginatedRecipes.length + (_hasMore && _isLoadingMore ? 1 : 0),
                          padding: const EdgeInsets.only(bottom: 16),
                          itemBuilder: (context, index) {
                            if (index == paginatedRecipes.length) return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(color: Color(0xFF10B981))));
                            final recipe = paginatedRecipes[index];
                            final isFavorite = favorites.isFavorite(recipe.id);
                            return RecipeCard(
                              recipe: recipe,
                              isFavorite: isFavorite,
                              onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
                              onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
                            );
                          },
                        ),
                      ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(loc.all),
              selected: _selectedCategory == null,
              onSelected: (_) => setState(() => _selectedCategory = null),
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.cardColor,
              labelStyle: TextStyle(color: _selectedCategory == null ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: _selectedCategory == null ? theme.colorScheme.primary : theme.colorScheme.outline, width: 1)),
            ),
          ),
          ...MealCategory.values.map((category) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(_getCategoryName(category)),
              selected: _selectedCategory == category,
              onSelected: (bool selected) => setState(() => _selectedCategory = selected ? category : null),
              backgroundColor: theme.colorScheme.surface,
              selectedColor: theme.cardColor,
              labelStyle: TextStyle(color: _selectedCategory == category ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: _selectedCategory == category ? theme.colorScheme.primary : theme.colorScheme.outline, width: 1)),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRecipeOfTheDay() {
    final recipe = _recipeOfTheDay;
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [theme.colorScheme.primary.withOpacity(0.08), theme.colorScheme.secondary.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.star_rounded, color: Color(0xFF10B981), size: 18)),
          const SizedBox(width: 10),
          Text(loc.recipeOfTheDay, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
        ]),
        const SizedBox(height: 12),
        RecipeCard(
          recipe: recipe, isFavorite: favorites.isFavorite(recipe.id),
          onFavoriteToggle: () => favorites.toggleFavorite(recipe.id),
          onTap: () => context.push('/recipe/${recipe.id}', extra: recipe),
        ),
      ]),
    );
  }
}
