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
    final cardColor =
        widget.isDarkMode ? AppColors.darkCard : AppColors.lightCard;
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
                  _buildAppLogo(),
                  const SizedBox(height: 32),

                  // App Title
                  _buildAppTitle(textColor, loc),
                  const SizedBox(height: 48),

                  // Login Form Card
                  _buildLoginCard(cardColor, loc),
                  const SizedBox(height: 24),

                  // Register Link
                  _buildRegisterLink(loc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.restaurant_menu,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAppTitle(Color textColor, AppLocalizations loc) {
    return Column(
      children: [
        Text(
          loc.appTitle,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          loc.login,
          style: TextStyle(
            fontSize: 18,
            color: widget.isDarkMode
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(Color cardColor, AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Email Field - Using Custom Widget
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

          // Password Field - Using Custom Widget
          CustomTextField(
            controller: _passwordController,
            labelText: loc.password,
            prefixIcon: Icons.lock_outline,
            isDarkMode: widget.isDarkMode,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: widget.isDarkMode
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
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

          // Login Button - Using Custom Widget
          PrimaryButton(
            text: loc.login,
            onPressed: _login,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink(AppLocalizations loc) {
    return Column(
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
        IconTextButton(
          text: loc.register,
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
          fontSize: 22,
        ),
      ],
    );
  }
}
