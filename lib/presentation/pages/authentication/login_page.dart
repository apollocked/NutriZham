import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/blocs/settings_cubit.dart';
import 'package:nutrizham/presentation/widgets/auth/login_form.dart';
import 'package:nutrizham/presentation/widgets/auth/forgot_password_dialog.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/icon_text_button.dart';
import 'package:nutrizham/core/utils/connectivity_helper.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _forgotPassword() async {
    if (!context.guardOnline()) return;
    final auth = context.read<AuthCubit>();
    final email = await showForgotPasswordDialog(context);
    if (email == null || !mounted) return;
    final result = await auth.resetPassword(email);
    if (mounted) {
      final theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: result['success'] ? theme.colorScheme.primary : theme.colorScheme.error),
      );
    }
  }

  Future<void> _login() async {
    if (!context.guardOnline()) return;
    if (!_formKey.currentState!.validate()) return;
    final result = await context.read<AuthCubit>().login(email: _emailController.text.trim(), password: _passwordController.text);
    if (!mounted) return;
    if (result['success']) {
      context.read<SettingsCubit>().setLoggedIn(true);
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Theme.of(context).colorScheme.error),
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
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary.withOpacity(0.12), theme.colorScheme.primary.withOpacity(0.04)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: theme.colorScheme.primary.withOpacity(0.15), width: 1.5),
                    ),
                    child: Center(child: Image.asset('assets/logo/app_logo.png', width: 48, height: 48)),
                  ),
                  const SizedBox(height: 28),
                  Text(loc.appTitle, style: theme.textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text(loc.login, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 40),
                  LoginForm(formKey: _formKey, emailController: _emailController, passwordController: _passwordController, isLoading: context.watch<AuthCubit>().state is AuthLoading, onLogin: _login, onForgotPassword: _forgotPassword),
                  const SizedBox(height: 40),
                  Text(loc.dontHaveAccount, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  IconTextButton(text: loc.register, onPressed: () => context.push('/register')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
