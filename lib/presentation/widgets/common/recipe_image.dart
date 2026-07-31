import 'package:flutter/material.dart';
import 'package:nutrizham/data/models/meals_data.dart';

class RecipeImage extends StatelessWidget {
  final Recipe recipe;
  final Color color;
  final double emojiSize;

  const RecipeImage({
    super.key,
    required this.recipe,
    required this.color,
    this.emojiSize = 38,
  });

  Widget _emojiFallback(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        recipe.icon,
        style: TextStyle(fontSize: emojiSize, color: color),
      ),
    );
  }

  Widget _loadingPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color.withValues(alpha: 0.06),
      alignment: Alignment.center,
      child: SizedBox(
        width: emojiSize * 0.8,
        height: emojiSize * 0.8,
        child: CircularProgressIndicator(strokeWidth: 2, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final url = recipe.imageUrl;
    if (url == null || url.isEmpty) return _emojiFallback(context);

    return Image.network(
      url,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _emojiFallback(context),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _loadingPlaceholder(context);
      },
    );
  }
}
