import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_buttons.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/icon_text_button.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      children: [
        CustomTextField(
          controller: widget.emailController,
          labelText: loc.email,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) return loc.emailRequired;
            if (!value.contains('@')) return loc.invalidEmail;
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: widget.passwordController,
          labelText: loc.password,
          prefixIcon: Icons.lock_outline,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: theme.colorScheme.onSurfaceVariant),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return loc.passwordRequired;
            if (value.length < 6) return loc.passwordTooShort;
            return null;
          },
        ),
        const SizedBox(height: 24),
        PrimaryButton(text: loc.login, onPressed: widget.onLogin, isLoading: widget.isLoading),
        const SizedBox(height: 16),
        IconTextButton(onPressed: widget.onForgotPassword, text: loc.forgotPassword, color: Colors.transparent, icon: Icons.help_outline_outlined),
      ],
    );
  }
}
