import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/stat_card.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ProfileStatsRow extends StatelessWidget {
  final int favoriteCount;
  final int plannedCount;

  const ProfileStatsRow({
    super.key,
    required this.favoriteCount,
    required this.plannedCount,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(children: [
        Expanded(child: StatCard(icon: Icons.favorite_outline, label: loc.favorites, value: '$favoriteCount', color: Colors.red.shade400)),
        const SizedBox(width: 16),
        Expanded(child: StatCard(icon: Icons.calendar_today_outlined, label: loc.mealPlanner, value: '$plannedCount', color: Theme.of(context).colorScheme.primary)),
      ]),
    );
  }
}
