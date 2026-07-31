import 'package:flutter/material.dart';

SliverGridDelegate adaptiveRecipeGridDelegate(double availableWidth, double textScale) {
  const minCardWidth = 160.0;
  final padding = availableWidth >= 600 ? 24.0 : 11.0;
  final usable = availableWidth - padding * 2;
  final columns = (usable / minCardWidth).floor().clamp(2, 6);
  final cardWidth = usable / columns;
  final imageHeight = cardWidth / 1.6;
  final textBlockHeight = 34 + 60 * textScale;
  final ratio = cardWidth / (imageHeight + textBlockHeight);
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    childAspectRatio: ratio,
  );
}
