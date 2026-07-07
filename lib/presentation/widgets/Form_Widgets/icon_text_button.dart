import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';

class IconTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final IconData icon;

  const IconTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.success,
    this.fontSize = 15,
    this.icon = Icons.arrow_forward_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text,
              style:
                  TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          Icon(icon, size: 18),
        ],
      ),
    );
  }
}
