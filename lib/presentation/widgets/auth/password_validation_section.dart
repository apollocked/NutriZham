import 'package:flutter/material.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class PasswordValidationSection extends StatelessWidget {
  final bool isVisible;
  final bool isLoading;
  final bool isValid;
  final String? errorMessage;
  final bool showValidateButton;
  final VoidCallback onValidate;

  const PasswordValidationSection({
    super.key,
    required this.isVisible,
    this.isLoading = false,
    this.isValid = false,
    this.errorMessage,
    this.showValidateButton = false,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (!isVisible) return const SizedBox.shrink();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(children: [
          if (isLoading)
            SizedBox(width: 16, height: 16,
                child: CircularProgressIndicator(strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary)))
          else if (isValid)
            Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 16)
          else if (errorMessage != null)
            Icon(Icons.error, color: theme.colorScheme.error, size: 16),
          const SizedBox(width: 8),
          Text(
            isLoading
                ? loc.validating
                : (isValid ? loc.passwordVerified : (errorMessage ?? '')),
            style: TextStyle(
                fontSize: 12,
                color: isLoading
                    ? theme.colorScheme.onSurfaceVariant
                    : (isValid
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error),
                fontWeight: FontWeight.w500),
          ),
        ]),
      ),
      if (showValidateButton)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : onValidate,
                icon: isLoading
                    ? SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary)))
                    : const Icon(Icons.check),
                label: Text(isLoading ? loc.validating : loc.verifyPassword),
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
              )),
        ),
    ]);
  }
}
