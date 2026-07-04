import 'package:flutter/material.dart';

import 'package:nutrizham/l10n/app_localizations.dart';

class RecipeRatingCard extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final int userRating;
  final ValueChanged<int> onRatingChanged;

  const RecipeRatingCard({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.userRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outline)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(rating.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF59E0B))),
                const SizedBox(width: 8),
                const Icon(Icons.star_rounded,
                    color: Color(0xFFF59E0B), size: 28),
              ]),
              const SizedBox(height: 4),
              Text('$ratingCount ${loc.ratings}',
                  style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurfaceVariant)),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(loc.yourRating,
                  style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 4),
              Row(
                  children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => onRatingChanged(index + 1),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                          index < userRating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: const Color(0xFFF59E0B),
                          size: 22)),
                );
              })),
            ]),
          ]),
    );
  }
}
