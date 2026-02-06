// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/register_page.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';

import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/custom_buttons.dart';

class LoginPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Add this method in _LoginPageState:
  Future<void> _forgotPassword() async {
    final loc = AppLocalizations.of(widget.languageCode);

    final email = await showDialog<String>(
      context: context,
      builder: (context) {
        final emailController = TextEditingController();
        return AlertDialog(
          title: Text(loc.forgotPassword),
          content: CustomTextField(
            controller: emailController,
            labelText: loc.email,
            prefixIcon: Icons.email_outlined,
            isDarkMode: widget.isDarkMode,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.cancel),
            ),
            TextButton(
              onPressed: () {
                if (emailController.text.contains('@')) {
                  Navigator.pop(context, emailController.text.trim());
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );

    if (email != null) {
      final result = await _authService.resetPassword(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor:
              result['success'] ? AppColors.success : AppColors.error,
        ),
      );
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success']) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainNavigation(
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
          ),
        ),
      );
    } else {
      print('Login error: ${result['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryGreen.withOpacity(0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 40,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // App Title
                  Text(
                    loc.appTitle,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.login,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Login Form
                  Column(
                    children: [
                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        labelText: loc.email,
                        prefixIcon: Icons.email_outlined,
                        isDarkMode: widget.isDarkMode,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        labelText: loc.password,
                        prefixIcon: Icons.lock_outline,
                        isDarkMode: widget.isDarkMode,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: widget.isDarkMode
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          onPressed: () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      PrimaryButton(
                        text: loc.login,
                        onPressed: _login,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Add forgot password button in login form (after login button):
                      TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          loc.forgotPassword,
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Register Link
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.dontHaveAccount,
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterPage(
                                isDarkMode: widget.isDarkMode,
                                languageCode: widget.languageCode,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          loc.register,
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
