import 'package:flutter/material.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 12,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
    );
  }
}

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

class ShimmerProfileHeader extends StatelessWidget {
  const ShimmerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          ShimmerCircle(size: 96),
          SizedBox(height: 16),
          ShimmerBox(height: 28, borderRadius: 6, width: 160),
          SizedBox(height: 8),
          ShimmerBox(height: 18, borderRadius: 10, width: 200),
          SizedBox(height: 14),
          ShimmerBox(height: 14, borderRadius: 4, width: 80),
        ],
      ),
    );
  }
}

class ShimmerStatCard extends StatelessWidget {
  const ShimmerStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: const Column(
        children: [
          ShimmerBox(height: 12, width: 12, borderRadius: 14),
          SizedBox(height: 10),
          ShimmerBox(height: 28, borderRadius: 6, width: 48),
          SizedBox(height: 4),
          ShimmerBox(height: 14, borderRadius: 4, width: 64),
        ],
      ),
    );
  }
}

class ShimmerProfileStats extends StatelessWidget {
  const ShimmerProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(child: ShimmerStatCard()),
          SizedBox(width: 16),
          Expanded(child: ShimmerStatCard()),
        ],
      ),
    );
  }
}

class ShimmerProfileMenu extends StatelessWidget {
  const ShimmerProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: List.generate(
              3,
              (_) => const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    ShimmerBox(height: 22, width: 22, borderRadius: 12),
                    SizedBox(width: 16),
                    Expanded(
                      child: ShimmerBox(height: 16, borderRadius: 4),
                    ),
                    SizedBox(width: 8),
                    ShimmerBox(height: 16, width: 16, borderRadius: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
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
                        ShimmerBox(
                          height: 28,
                          width: 48,
                          borderRadius: 6,
                        ),
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

class ShimmerProfilePage extends StatelessWidget {
  const ShimmerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8),
          ShimmerProfileHeader(),
          ShimmerProfileStats(),
          SizedBox(height: 16),
          ShimmerProfileMenu(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
