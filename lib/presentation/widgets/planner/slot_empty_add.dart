import 'package:flutter/material.dart';

class SlotEmpty extends StatelessWidget {
  final Color slotColor;
  final String label;
  final VoidCallback onAdd;
  final String tapToBrowse;

  const SlotEmpty({
    super.key,
    required this.slotColor,
    required this.label,
    required this.onAdd,
    required this.tapToBrowse,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: GestureDetector(
        onTap: onAdd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: slotColor.withOpacity(0.25),
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            color: slotColor.withOpacity(0.04),
          ),
          child: Column(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: slotColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add_rounded, size: 24, color: slotColor),
              ),
              const SizedBox(height: 10),
              Text('Add $label',
                  style: TextStyle(
                      color: slotColor, fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(tapToBrowse,
                  style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }
}

class SlotAddButton extends StatelessWidget {
  final Color slotColor;
  final String label;
  final VoidCallback onTap;

  const SlotAddButton({
    super.key,
    required this.slotColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: slotColor.withOpacity(0.06),
          border: Border.all(color: slotColor.withOpacity(0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: slotColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add_rounded, size: 16, color: slotColor),
            ),
            const SizedBox(width: 8),
            Text('Add $label',
                style: TextStyle(
                    color: slotColor, fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
