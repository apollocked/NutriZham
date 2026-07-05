import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_base.dart';

class ShimmerRecipeCard extends StatelessWidget {
  const ShimmerRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shimmer = theme.colorScheme.surfaceContainerHighest;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: shimmer,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(height: 14, borderRadius: 4),
                    SizedBox(height: 8),
                    ShimmerBox(height: 14, borderRadius: 4, width: 120),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        ShimmerBox(height: 18, width: 60, borderRadius: 6),
                        Spacer(),
                        ShimmerBox(height: 12, width: 12, borderRadius: 6),
                        SizedBox(width: 4),
                        ShimmerBox(height: 12, width: 40, borderRadius: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerRecipeGrid extends StatelessWidget {
  final int itemCount;

  const ShimmerRecipeGrid({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.82,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: itemCount,
        itemBuilder: (_, __) => const ShimmerRecipeCard(),
      ),
    );
  }
}

class ShimmerCompactRecipeCard extends StatelessWidget {
  const ShimmerCompactRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withValues(alpha: 0.5),
            ),
          ),
          child: const Row(
            children: [
              ShimmerBox(height: 42, width: 42, borderRadius: 12),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(height: 14, borderRadius: 4, width: 140),
                    SizedBox(height: 4),
                    ShimmerBox(height: 12, borderRadius: 4, width: 80),
                  ],
                ),
              ),
              SizedBox(width: 8),
              ShimmerBox(height: 20, width: 20, borderRadius: 10),
            ],
          ),
        ),
      ),
    );
  }
}
