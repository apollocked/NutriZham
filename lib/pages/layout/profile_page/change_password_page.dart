import 'package:flutter/material.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/services/firebase_auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/custom_buttons.dart';

class ChangePasswordPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;

  const ChangePasswordPage({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = FirebaseAuthService();

  bool _isLoading = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  String? _passwordStrength;
  Color? _passwordStrengthColor;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Save changes and update password in Firebase
  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if new passwords match
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _authService.changePassword(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor:
              result['success'] ? AppColors.success : AppColors.error,
        ),
      );

      if (result['success']) {
        // Navigate back to MainNavigation after successful password change
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => MainNavigation(
              isDarkMode: widget.isDarkMode,
              languageCode: widget.languageCode,
            ),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final secondaryTextColor = widget.isDarkMode
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: 'Change Password',
        isDarkMode: widget.isDarkMode,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Information section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryGreen.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Please enter your current password and your new password. Make sure your new password is strong and unique.',
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.isDarkMode
                              ? AppColors.darkText
                              : AppColors.lightText,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Current Password Field
              Text(
                'Current Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _currentPasswordController,
                labelText: 'Enter current password',
                prefixIcon: Icons.lock_outline,
                isDarkMode: widget.isDarkMode,
                obscureText: !_showCurrentPassword,
                textInputAction: TextInputAction.next,
                suffixIcon: GestureDetector(
                  onTap: () => setState(
                      () => _showCurrentPassword = !_showCurrentPassword),
                  child: Icon(
                    _showCurrentPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.primaryGreen,
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Current password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // New Password Field
              Text(
                'New Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _newPasswordController,
                labelText: 'Enter new password',
                prefixIcon: Icons.lock_outline,
                isDarkMode: widget.isDarkMode,
                obscureText: !_showNewPassword,
                textInputAction: TextInputAction.next,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _showNewPassword = !_showNewPassword),
                  child: Icon(
                    _showNewPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.primaryGreen,
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'New password is required';
                  }
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Password Strength Indicator
              if (_passwordStrength != null && _passwordStrength!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Password Strength: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryTextColor,
                            ),
                          ),
                          Text(
                            _passwordStrength ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _passwordStrengthColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _getPasswordStrengthValue(),
                          minHeight: 4,
                          backgroundColor: AppColors.lightDivider,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              _passwordStrengthColor ?? AppColors.error),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Use a mix of uppercase, lowercase, numbers, and symbols for stronger security.',
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),

              // Confirm Password Field
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm new password',
                prefixIcon: Icons.lock_outline,
                isDarkMode: widget.isDarkMode,
                obscureText: !_showConfirmPassword,
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  onTap: () => setState(
                      () => _showConfirmPassword = !_showConfirmPassword),
                  child: Icon(
                    _showConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.primaryGreen,
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Buttons Row
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: SecondaryButton(
                        text: 'Cancel',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Update Password',
                        onPressed: _isLoading ? null : _changePassword,
                        isLoading: _isLoading,
                        icon: Icons.check,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get password strength indicator value (0 to 1)
  double _getPasswordStrengthValue() {
    switch (_passwordStrength) {
      case 'Weak':
        return 0.25;
      case 'Fair':
        return 0.5;
      case 'Good':
        return 0.75;
      case 'Strong':
        return 1.0;
      default:
        return 0.0;
    }
  }
}

/// Password Requirement Check Item
// ignore: unused_element
class _PasswordRequirement extends StatelessWidget {
  final String text;
  final bool isDarkMode;
  final bool isMet;

  const _PasswordRequirement({
    required this.text,
    required this.isDarkMode,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isMet ? AppColors.success : AppColors.lightDivider,
          ),
          child: isMet
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 12,
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isMet
                  ? AppColors.success
                  : (isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary),
              fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
