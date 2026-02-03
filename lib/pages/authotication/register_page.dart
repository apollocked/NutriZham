import 'package:flutter/material.dart';
import 'package:nutrizham/pages/authotication/login_page.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/custom_buttons.dart';

class RegisterPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const RegisterPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

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
  final _authService = AuthService();
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
          content: Text(AppLocalizations.of(widget.languageCode).error),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await _authService.register(
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
          backgroundColor: AppColors.success,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(
            isDarkMode: widget.isDarkMode,
            languageCode: widget.languageCode,
          ),
        ),
      );
    } else {
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
                    loc.register,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Registration Form
                  Column(
                    children: [
                      // Username Field
                      CustomTextField(
                        controller: _usernameController,
                        labelText: loc.username,
                        prefixIcon: Icons.person_outline,
                        isDarkMode: widget.isDarkMode,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          if (value.length < 3) {
                            return 'Username must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

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

                      // Age Field
                      CustomTextField(
                        controller: _ageController,
                        labelText: loc.age,
                        prefixIcon: Icons.calendar_today_outlined,
                        isDarkMode: widget.isDarkMode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          final age = int.tryParse(value);
                          if (age == null || age < 10 || age > 100) {
                            return 'Please enter a valid age (10-100)';
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
                        textInputAction: TextInputAction.next,
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
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      CustomTextField(
                        controller: _confirmPasswordController,
                        labelText: loc.confirmPassword,
                        prefixIcon: Icons.lock_outlined,
                        isDarkMode: widget.isDarkMode,
                        obscureText: _obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: widget.isDarkMode
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                          onPressed: () {
                            setState(() => _obscureConfirmPassword =
                                !_obscureConfirmPassword);
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Register Button
                      PrimaryButton(
                        text: loc.register,
                        onPressed: _register,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),

                  // Login Link
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.alreadyHaveAccount,
                        style: TextStyle(
                          color: widget.isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginPage(
                                isDarkMode: widget.isDarkMode,
                                languageCode: widget.languageCode,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          loc.login,
                          style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
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
