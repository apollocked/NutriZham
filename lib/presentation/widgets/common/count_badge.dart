import 'package:flutter/material.dart';

class CountBadge extends StatelessWidget {
  final String text;
  final Color color;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;

  const CountBadge({
    super.key,
    required this.text,
    required this.color,
    this.horizontalPadding = 12,
    this.verticalPadding = 5,
    this.borderRadius = 10,
  });

  const CountBadge.number({
    super.key,
    required int count,
    required this.color,
    this.horizontalPadding = 12,
    this.verticalPadding = 5,
    this.borderRadius = 10,
  }) : text = '$count';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
