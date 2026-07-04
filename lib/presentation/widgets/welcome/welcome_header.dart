import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/settings/welcome_language_option.dart';

class WelcomeHeader extends StatelessWidget {
  final String languageCode;

  const WelcomeHeader({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: [
      Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.12), theme.colorScheme.secondary.withOpacity(0.08)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2), width: 2),
        ),
        child: Center(child: Image.asset('assets/logo/app_logo.png', width: 44, height: 44)),
      ),
      const SizedBox(height: 36),
      Text(WelcomeLanguageTexts.welcomeText(languageCode), style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
      const SizedBox(height: 8),
      Text('NutriZham', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: theme.colorScheme.primary, letterSpacing: -0.5)),
      const SizedBox(height: 16),
      Text(WelcomeLanguageTexts.subtitleText(languageCode), textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: theme.colorScheme.onSurfaceVariant, height: 1.4)),
    ]);
  }
}
