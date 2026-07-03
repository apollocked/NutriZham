import 'package:flutter/material.dart';

class WelcomeLanguageOption extends StatelessWidget {
  final String code;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const WelcomeLanguageOption({
    super.key,
    required this.code,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : (isDark ? const Color(0xFF111827) : Colors.grey[50]),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : (isDark
                    ? const Color(0xFF374151)
                    : const Color(0xFFE5E7EB)),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(code == 'en' ? Icons.language : Icons.translate,
                size: 20,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5)),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface))),
          if (isSelected)
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 16)),
        ]),
      ),
    );
  }
}

class WelcomeLanguageTexts {
  static String welcomeText(String code) {
    switch (code) {
      case 'ku':
        return 'بەخێربێیت';
      case 'ar':
        return 'مرحباً';
      default:
        return 'Welcome';
    }
  }

  static String subtitleText(String code) {
    switch (code) {
      case 'ku':
        return 'تکایە زمان و دۆخی پێشنیارکراوت هەڵبژێرە';
      case 'ar':
        return 'الرجاء اختيار اللغة والوضع المفضل';
      default:
        return 'Please select your preferred language and theme';
    }
  }

  static String darkModeText(String code) {
    switch (code) {
      case 'ku':
        return 'دۆخی تاریک';
      case 'ar':
        return 'الوضع المظلم';
      default:
        return 'Dark Mode';
    }
  }

  static String languageText(String code) {
    switch (code) {
      case 'ku':
        return 'زمان';
      case 'ar':
        return 'اللغة';
      default:
        return 'Language';
    }
  }

  static String continueText(String code) {
    switch (code) {
      case 'ku':
        return 'بەردەوامبوون';
      case 'ar':
        return 'متابعة';
      default:
        return 'Continue';
    }
  }
}
