import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_base.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_recipe.dart';

class ShimmerPlanner extends StatelessWidget {
  final int mealCount;

  const ShimmerPlanner({super.key, this.mealCount = 4});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const ShimmerBox(height: 44, borderRadius: 8, width: 120),
                const SizedBox(height: 8),
                const ShimmerBox(height: 20, borderRadius: 4, width: 60),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (_) => const Column(
                      children: [
                        ShimmerBox(height: 28, width: 48, borderRadius: 6),
                        SizedBox(height: 4),
                        ShimmerBox(height: 12, width: 40, borderRadius: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ShimmerBox(height: 22, width: 4, borderRadius: 2),
                SizedBox(width: 8),
                ShimmerBox(height: 22, borderRadius: 4, width: 120),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            mealCount,
            (_) => const ShimmerCompactRecipeCard(),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ShimmerBox(height: 22, width: 4, borderRadius: 2),
                SizedBox(width: 8),
                ShimmerBox(height: 22, borderRadius: 4, width: 160),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            3,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: ShimmerCompactRecipeCard(),
            ),
          ),
        ],
      ),
    );
  }
}
