import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/presentation/widgets/profile/stat_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileStatsRow extends StatelessWidget {
  final int favoriteCount;
  final int totalRecipeCount;

  const ProfileStatsRow({
    super.key,
    required this.favoriteCount,
    required this.totalRecipeCount,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.go('/home', extra: {'showFavorites': true}),
              child: StatCard(
                  icon: Icons.favorite_outline,
                  label: loc.favorites,
                  value: '$favoriteCount',
                  color: AppColors.accentRed),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.go('/home'),
              child: StatCard(
                  icon: Icons.menu_book_rounded,
                  label: loc.recipes,
                  value: '$totalRecipeCount',
                  color: AppColors.accentTeal),
            ),
          ),
        ),
      ]),
    );
  }
}
