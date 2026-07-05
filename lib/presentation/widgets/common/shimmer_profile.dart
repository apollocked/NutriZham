import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/common/shimmer_base.dart';

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
