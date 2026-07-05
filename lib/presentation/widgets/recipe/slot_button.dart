import 'package:flutter/material.dart';

class SlotButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isAdded;
  final VoidCallback onTap;

  const SlotButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isAdded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            decoration: BoxDecoration(
              gradient: isAdded
                  ? LinearGradient(
                      colors: [color.withOpacity(0.2), color.withOpacity(0.08)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : LinearGradient(
                      colors: [color.withOpacity(0.06), color.withOpacity(0.02)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isAdded ? color.withOpacity(0.4) : color.withOpacity(0.12),
                width: isAdded ? 1.5 : 1,
              ),
              boxShadow: isAdded
                  ? [BoxShadow(color: color.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 2))]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isAdded
                      ? Icon(Icons.check_circle_rounded, key: const ValueKey('added'),
                          color: color, size: 24)
                      : Icon(icon, key: const ValueKey('normal'),
                          color: color.withOpacity(0.7), size: 22),
                ),
                const SizedBox(height: 6),
                Text(label,
                    style: TextStyle(
                        color: isAdded ? color : color.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: isAdded ? FontWeight.w700 : FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
