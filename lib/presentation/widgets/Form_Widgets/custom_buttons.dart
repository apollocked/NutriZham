import 'package:flutter/material.dart';
import 'package:nutrizham/core/constants/app_colors.dart';
import 'package:nutrizham/presentation/widgets/common/scale_tap.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final double height;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.height = 56,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isLoading || onPressed == null;

    Widget button = SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          disabledBackgroundColor:
              (backgroundColor ?? AppColors.primary).withOpacity(0.6),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(text),
                ],
              ),
      ),
    );

    if (!isDisabled) {
      button = ScaleTap(child: button);
    }

    return button;
  }
}


