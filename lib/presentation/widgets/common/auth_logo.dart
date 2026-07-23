import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  final double size;

  const AuthLogo({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.12),
            theme.colorScheme.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/logo/app_logo.png',
          width: size * 0.75,
          height: size * 0.75,
        ),
      ),
    );
  }
}
