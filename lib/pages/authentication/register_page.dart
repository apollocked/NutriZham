import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/Form_Widgets/custom_buttons.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await context.read<AuthProvider>().register(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      age: int.tryParse(_ageController.text) ?? 20,
    );

    setState(() => _isLoading = false);
    if (!mounted) return;

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      context.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3), width: 1.5),
                    ),
                    child: Image.asset('assets/logo/app_logo.png', width: 40, height: 40),
                  ),
                  const SizedBox(height: 24),
                  Text(loc.appTitle, style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface, letterSpacing: -0.5)),
                  const SizedBox(height: 8),
                  Text(loc.register, style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 36),
                  Column(children: [
                    CustomTextField(controller: _usernameController, labelText: loc.username, prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next, validator: (v) => v?.isEmpty == true ? 'Please enter a username' : (v!.length < 3 ? 'Username must be at least 3 characters' : null)),
                    const SizedBox(height: 16),
                    CustomTextField(controller: _emailController, labelText: loc.email, prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, validator: (v) => v?.isEmpty == true ? 'Please enter your email' : (!v!.contains('@') ? 'Please enter a valid email' : null)),
                    const SizedBox(height: 16),
                    CustomTextField(controller: _ageController, labelText: loc.age, prefixIcon: Icons.calendar_today_outlined, keyboardType: TextInputType.number, textInputAction: TextInputAction.next, validator: (v) {
                      final age = int.tryParse(v ?? '');
                      if (age == null || age < 10 || age > 100) return 'Please enter a valid age (10-100)';
                      return null;
                    }),
                    const SizedBox(height: 16),
                    CustomTextField(controller: _passwordController, labelText: loc.password, prefixIcon: Icons.lock_outline, obscureText: _obscurePassword, textInputAction: TextInputAction.next, suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: theme.colorScheme.onSurfaceVariant), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), validator: (v) => v?.isEmpty == true ? 'Please enter your password' : (v!.length < 6 ? 'Password must be at least 6 characters' : null)),
                    const SizedBox(height: 16),
                    CustomTextField(controller: _confirmPasswordController, labelText: loc.confirmPassword, prefixIcon: Icons.lock_outlined, obscureText: _obscureConfirmPassword, textInputAction: TextInputAction.done, suffixIcon: IconButton(icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: theme.colorScheme.onSurfaceVariant), onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)), validator: (v) => v?.isEmpty == true ? 'Please confirm your password' : null),
                    const SizedBox(height: 28),
                    PrimaryButton(text: loc.register, onPressed: _register, isLoading: _isLoading),
                  ]),
                  const SizedBox(height: 40),
                  Text(loc.alreadyHaveAccount, style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14)),
                  const SizedBox(height: 10),
                  IconTextButton(text: loc.login, onPressed: () => context.go('/login')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
