import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextField(
      controller: controller,
      labelText: labelText,
      prefixIcon: Icons.lock_outline,
      obscureText: obscureText,
      textInputAction: textInputAction,
      suffixIcon: GestureDetector(
        onTap: onToggleVisibility,
        child: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: theme.colorScheme.primary,
        ),
      ),
      validator: validator,
    );
  }
}
