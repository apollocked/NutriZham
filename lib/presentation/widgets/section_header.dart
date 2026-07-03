import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final int? count;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? barHeight;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.count,
    this.fontSize,
    this.fontWeight,
    this.barHeight,
    this.padding,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultFontSize = fontSize ?? 18;
    final defaultFontWeight = fontWeight ?? FontWeight.w700;
    final defaultBarHeight = barHeight ?? 20;
    final defaultPadding = padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    final defaultTextColor = textColor ?? theme.colorScheme.onSurface;

    return Padding(
      padding: defaultPadding,
      child: Row(children: [
        Container(
            width: 4, height: defaultBarHeight,
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 10),
        Text(title, style: TextStyle(
            fontSize: defaultFontSize,
            fontWeight: defaultFontWeight,
            color: defaultTextColor)),
        const Spacer(),
        if (count != null)
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text('$count', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF10B981)))),
      ]),
    );
  }
}
