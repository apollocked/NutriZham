import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/favorites_provider.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/nutrition_info_widget.dart';
import 'package:nutrizham/widgets/category_widgets.dart';
import 'package:nutrizham/utils/meals_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  int _userRating = 0;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesProvider>().loadFavorites();
  }

  Future<void> _saveRating(int rating) async {
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(duration: const Duration(milliseconds: 775), behavior: SnackBarBehavior.floating, content: Text('${loc.rating}: $rating/5'), backgroundColor: const Color(0xFF10B981)),
    );
    setState(() => _userRating = rating);
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    return Row(children: [
      Container(width: 4, height: 20, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(widget.recipe.id);

    final recipeTitle = widget.recipe.title[Localizations.localeOf(context).languageCode] ??
        widget.recipe.title['en'] ?? '';
    final ingredients = widget.recipe.ingredients[Localizations.localeOf(context).languageCode] ??
        widget.recipe.ingredients['en'] ?? [];
    final steps = widget.recipe.steps[Localizations.localeOf(context).languageCode] ??
        widget.recipe.steps['en'] ?? [];

    return Scaffold(
      appBar: CustomAppBar(
        title: recipeTitle,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline),
            color: isFavorite ? const Color(0xFFEF4444) : null,
            onPressed: () => favorites.toggleFavorite(widget.recipe.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: CategoryBadge(category: widget.recipe.category),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(widget.recipe.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFF59E0B))),
                      const SizedBox(width: 8),
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 28),
                    ]),
                    const SizedBox(height: 4),
                    Text('${widget.recipe.ratingCount} ${loc.ratings}', style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant)),
                  ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(loc.yourRating, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Row(children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => _saveRating(index + 1),
                        child: Padding(padding: const EdgeInsets.only(left: 2), child: Icon(index < _userRating ? Icons.star_rounded : Icons.star_outline_rounded, color: const Color(0xFFF59E0B), size: 22)),
                      );
                    })),
                  ]),
                ]),
              ),
              const SizedBox(height: 16),
              NutritionInfoCard(nutrition: widget.recipe.nutrition),
              const SizedBox(height: 24),
              _buildSectionHeader(loc.ingredients),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: ingredients.map((ing) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 7), decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(ing, style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface, height: 1.4))),
                  ]),
                )).toList()),
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(loc.preparationSteps),
              const SizedBox(height: 12),
              ...steps.asMap().entries.map((entry) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(14), border: Border.all(color: theme.colorScheme.outline)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('${entry.key + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(entry.value, style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurface, height: 1.4))),
                ]),
              )),
              const SizedBox(height: 24),
            ]),
          ),
        ]),
      ),
    );
  }
}
