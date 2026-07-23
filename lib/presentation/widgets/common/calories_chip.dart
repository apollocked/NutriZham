import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class CaloriesChip extends StatelessWidget {
  final int calories;
  final double iconSize;
  final double fontSize;
  final bool showUnit;

  const CaloriesChip({
    super.key,
    required this.calories,
    this.iconSize = 12,
    this.fontSize = 11,
    this.showUnit = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.local_fire_department_rounded,
          size: iconSize,
          color: AppColors.caloriesColor.withValues(alpha: 0.7),
        ),
        const SizedBox(width: 2),
        Text(
          showUnit ? '$calories ${loc.kcal}' : '$calories',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: AppColors.caloriesColor,
          ),
        ),
      ],
    );
  }
}
