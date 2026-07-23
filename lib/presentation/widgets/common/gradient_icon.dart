import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData? icon;
  final String? emoji;
  final Color color;
  final double size;
  final double padding;
  final double borderRadius;

  const GradientIcon({
    super.key,
    this.icon,
    this.emoji,
    required this.color,
    this.size = 22,
    this.padding = 10,
    this.borderRadius = 12,
  }) : assert(icon != null || emoji != null, 'Either icon or emoji must be provided');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: emoji != null
          ? Center(
              child: Text(emoji!, style: TextStyle(fontSize: size)),
            )
          : Icon(icon, color: color, size: size),
    );
  }
}
