import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/common/section_header.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_buttons.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/secondary_button.dart';
import 'package:nutrizham/presentation/widgets/auth/password_validation_section.dart';
import 'package:nutrizham/presentation/widgets/auth/password_info_banner.dart';
import 'package:nutrizham/presentation/widgets/auth/password_field.dart';
import 'package:nutrizham/core/utils/connectivity_helper.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
    _currentPasswordController.addListener(() {
      setState(() => _showValidateButton =
          _currentPasswordController.text.isNotEmpty && !_isCurrentPasswordValid);
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _validateCurrentPassword() async {
    final password = _currentPasswordController.text.trim();
    if (password.isEmpty) {
      setState(() { _isCurrentPasswordValid = false; _currentPasswordError = null; });
      return;
    }
    setState(() => _isLoading = true);
    try {
      final result = await context.read<AuthCubit>().validatePassword(password);
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
        _currentPasswordError = AppLocalizations.of(context)!.wrongPassword;
        _isLoading = false;
        _showValidateButton = true;
      });
    }
  }

  Future<void> _changePassword() async {
    if (!context.guardOnline()) return;
    final loc = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loc.pleaseFillAllFields),
          backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }
    if (!_isCurrentPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loc.pleaseVerifyCurrentPassword),
          backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(loc.passwordsDoNotMatch),
          backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final result = await context.read<AuthCubit>().changePassword(
          currentPassword: _currentPasswordController.text.trim(),
          newPassword: _newPasswordController.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['message']),
          backgroundColor: result['success']
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error));
      if (result['success']) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(loc.errorUpdatingPassword),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.changePassword),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            PasswordInfoBanner(message: loc.passwordInfoMessage),
            const SizedBox(height: 32),
            SectionHeader(title: loc.currentPassword, padding: EdgeInsets.zero),
            const SizedBox(height: 8),
            PasswordField(
              controller: _currentPasswordController,
              labelText: loc.enterCurrentPassword,
              obscureText: !_showCurrentPassword,
              onToggleVisibility: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
              validator: (v) => v?.isEmpty == true ? loc.currentPasswordRequired : null,
            ),
            const SizedBox(height: 8),
            PasswordValidationSection(
              isVisible: _currentPasswordController.text.isNotEmpty,
              isLoading: _isLoading,
              isValid: _isCurrentPasswordValid,
              errorMessage: _currentPasswordError,
              showValidateButton: _showValidateButton,
              onValidate: _validateCurrentPassword,
            ),
            const SizedBox(height: 24),
            SectionHeader(title: loc.newPassword, padding: EdgeInsets.zero),
            const SizedBox(height: 8),
            PasswordField(
              controller: _newPasswordController,
              labelText: loc.enterNewPassword,
              obscureText: !_showNewPassword,
              onToggleVisibility: () => setState(() => _showNewPassword = !_showNewPassword),
              validator: (v) {
                if (v?.isEmpty == true) return loc.newPasswordRequired;
                if (v!.length < 6) return loc.passwordTooShort;
                return null;
              },
            ),
            const SizedBox(height: 24),
            SectionHeader(title: loc.confirmPassword, padding: EdgeInsets.zero),
            const SizedBox(height: 8),
            PasswordField(
              controller: _confirmPasswordController,
              labelText: loc.confirmNewPassword,
              obscureText: !_showConfirmPassword,
              textInputAction: TextInputAction.done,
              onToggleVisibility: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              validator: (v) {
                if (v?.isEmpty == true) return loc.confirmPasswordRequired;
                if (v != _newPasswordController.text) return loc.passwordsDoNotMatch;
                return null;
              },
            ),
            const SizedBox(height: 40),
            Row(children: [
              Expanded(
                  child: SecondaryButton(
                      text: loc.cancel,
                      onPressed: () => Navigator.pop(context))),
              const SizedBox(width: 10),
              Expanded(
                  child: PrimaryButton(
                      text: loc.updatePassword,
                      onPressed: (_isLoading || !_isCurrentPasswordValid)
                          ? null
                          : _changePassword,
                      isLoading: _isLoading)),
            ]),
          ]),
        ),
      ),
    );
  }
}
