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
  bool _isCurrentPasswordValid = false;
  String? _currentPasswordError;
  bool _showValidateButton = false;

  @override
  void initState() {
    super.initState();
    // Listen to current password changes
    _currentPasswordController.addListener(() {
      setState(() {
        _showValidateButton = _currentPasswordController.text.isNotEmpty &&
            !_isCurrentPasswordValid;
      });
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validate current password by attempting reauthentication
  Future<void> _validateCurrentPassword() async {
    final password = _currentPasswordController.text.trim();
    final localization = AppLocalizations.of(widget.languageCode);

    if (password.isEmpty) {
      setState(() {
        _isCurrentPasswordValid = false;
        _currentPasswordError = null;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _authService.validateCurrentPassword(password);

      if (!mounted) return;

      setState(() {
        _isCurrentPasswordValid = result['success'];
        _currentPasswordError = result['success'] ? null : result['message'];
        _isLoading = false;
        _showValidateButton = !result['success'];
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isCurrentPasswordValid = false;
        _currentPasswordError = localization.wrongPassword;
        _isLoading = false;
        _showValidateButton = true;
      });
    }
  }

  /// Save changes and update password in Firebase
  Future<void> _changePassword() async {
    final localization = AppLocalizations.of(widget.languageCode);

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localization.pleaseFillAllFields),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (!_isCurrentPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localization.pleaseVerifyCurrentPassword),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localization.passwordsDoNotMatch),
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
          content: Text(localization.errorUpdatingPassword),
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
    final localization = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: localization.changePassword,
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
                        localization.passwordInfoMessage,
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

              // Current Password Section
              Text(
                localization.currentPassword,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _currentPasswordController,
                labelText: localization.enterCurrentPassword,
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
                    return localization.currentPasswordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Current Password Validation Status and Button
              if (_currentPasswordController.text.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status indicator
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          if (_isLoading)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryGreen),
                              ),
                            )
                          else if (_isCurrentPasswordValid)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 16,
                            )
                          else if (_currentPasswordError != null)
                            const Icon(
                              Icons.error,
                              color: AppColors.error,
                              size: 16,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            _isLoading
                                ? localization.validating
                                : (_isCurrentPasswordValid
                                    ? localization.passwordVerified
                                    : (_currentPasswordError ?? '')),
                            style: TextStyle(
                              fontSize: 12,
                              color: _isLoading
                                  ? AppColors.lightTextSecondary
                                  : (_isCurrentPasswordValid
                                      ? AppColors.success
                                      : AppColors.error),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Validate button - ONLY shown once, when needed
                    if (_showValidateButton)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed:
                                _isLoading ? null : _validateCurrentPassword,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.check),
                            label: Text(
                              _isLoading
                                  ? localization.validating
                                  : localization.verifyPassword,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

              const SizedBox(height: 24),

              // New Password Field
              Text(
                localization.newPassword,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _newPasswordController,
                labelText: localization.enterNewPassword,
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
                    return localization.newPasswordRequired;
                  }
                  if (value!.length < 6) {
                    return localization.passwordTooShort;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Confirm Password Field
              Text(
                localization.confirmPassword,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: localization.confirmNewPassword,
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
                    return localization.confirmPasswordRequired;
                  }
                  if (value != _newPasswordController.text) {
                    return localization.passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: localization.cancel,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      text: localization.updatePassword,
                      onPressed: (_isLoading || !_isCurrentPasswordValid)
                          ? null
                          : _changePassword,
                      isLoading: _isLoading,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
