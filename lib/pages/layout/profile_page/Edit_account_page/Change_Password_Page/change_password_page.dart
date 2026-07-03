import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrizham/services/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/Form_Widgets/custom_buttons.dart';
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
    _currentPasswordController.addListener(() {
      setState(() => _showValidateButton = _currentPasswordController.text.isNotEmpty && !_isCurrentPasswordValid);
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
    if (password.isEmpty) { setState(() { _isCurrentPasswordValid = false; _currentPasswordError = null; }); return; }
    setState(() => _isLoading = true);

    try {
      final result = await _authService.validateCurrentPassword(password);
      if (!mounted) return;
      setState(() { _isCurrentPasswordValid = result['success']; _currentPasswordError = result['success'] ? null : result['message']; _isLoading = false; _showValidateButton = !result['success']; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _isCurrentPasswordValid = false; _currentPasswordError = AppLocalizations.of(context)!.wrongPassword; _isLoading = false; _showValidateButton = true; });
    }
  }

  Future<void> _changePassword() async {
    final loc = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.pleaseFillAllFields), backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }
    if (!_isCurrentPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.pleaseVerifyCurrentPassword), backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.passwordsDoNotMatch), backgroundColor: Theme.of(context).colorScheme.error));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await _authService.changePassword(currentPassword: _currentPasswordController.text.trim(), newPassword: _newPasswordController.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message']), backgroundColor: result['success'] ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error));
      if (result['success']) context.go('/home');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.errorUpdatingPassword), backgroundColor: Theme.of(context).colorScheme.error));
    } finally { if (mounted) setState(() => _isLoading = false); }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: loc.changePassword),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFD1FAE5).withOpacity(0.2), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3))),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.info_outline_rounded, color: Color(0xFF10B981), size: 18)),
                const SizedBox(width: 12),
                Expanded(child: Text(loc.passwordInfoMessage, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface, height: 1.5))),
              ]),
            ),
            const SizedBox(height: 32),
            Row(children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Text(loc.currentPassword, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
            ]),
            const SizedBox(height: 8),
            CustomTextField(controller: _currentPasswordController, labelText: loc.enterCurrentPassword, prefixIcon: Icons.lock_outline, obscureText: !_showCurrentPassword, textInputAction: TextInputAction.next,
              suffixIcon: GestureDetector(onTap: () => setState(() => _showCurrentPassword = !_showCurrentPassword), child: Icon(_showCurrentPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: theme.colorScheme.primary)),
              validator: (v) => v?.isEmpty == true ? loc.currentPasswordRequired : null),
            const SizedBox(height: 8),
            if (_currentPasswordController.text.isNotEmpty)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(children: [
                    if (_isLoading) const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981))))
                    else if (_isCurrentPasswordValid) const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 16)
                    else if (_currentPasswordError != null) const Icon(Icons.error, color: Color(0xFFEF4444), size: 16),
                    const SizedBox(width: 8),
                    Text(_isLoading ? loc.validating : (_isCurrentPasswordValid ? loc.passwordVerified : (_currentPasswordError ?? '')),
                      style: TextStyle(fontSize: 12, color: _isLoading ? const Color(0xFF6B7280) : (_isCurrentPasswordValid ? const Color(0xFF10B981) : const Color(0xFFEF4444)), fontWeight: FontWeight.w500)),
                  ]),
                ),
                if (_showValidateButton)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SizedBox(width: double.infinity, child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _validateCurrentPassword,
                      icon: _isLoading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                          : const Icon(Icons.check),
                      label: Text(_isLoading ? loc.validating : loc.verifyPassword),
                      style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    )),
                  ),
              ]),
            const SizedBox(height: 24),
            Row(children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Text(loc.newPassword, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
            ]),
            const SizedBox(height: 8),
            CustomTextField(controller: _newPasswordController, labelText: loc.enterNewPassword, prefixIcon: Icons.lock_outline, obscureText: !_showNewPassword, textInputAction: TextInputAction.next,
              suffixIcon: GestureDetector(onTap: () => setState(() => _showNewPassword = !_showNewPassword), child: Icon(_showNewPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: theme.colorScheme.primary)),
              validator: (v) { if (v?.isEmpty == true) return loc.newPasswordRequired; if (v!.length < 6) return loc.passwordTooShort; return null; }),
            const SizedBox(height: 24),
            Row(children: [
              Container(width: 4, height: 16, decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Text(loc.confirmPassword, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
            ]),
            const SizedBox(height: 8),
            CustomTextField(controller: _confirmPasswordController, labelText: loc.confirmNewPassword, prefixIcon: Icons.lock_outline, obscureText: !_showConfirmPassword, textInputAction: TextInputAction.done,
              suffixIcon: GestureDetector(onTap: () => setState(() => _showConfirmPassword = !_showConfirmPassword), child: Icon(_showConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: theme.colorScheme.primary)),
              validator: (v) { if (v?.isEmpty == true) return loc.confirmPasswordRequired; if (v != _newPasswordController.text) return loc.passwordsDoNotMatch; return null; }),
            const SizedBox(height: 40),
            Row(children: [
              Expanded(child: SecondaryButton(text: loc.cancel, onPressed: () => Navigator.pop(context))),
              const SizedBox(width: 10),
              Expanded(child: PrimaryButton(text: loc.updatePassword, onPressed: (_isLoading || !_isCurrentPasswordValid) ? null : _changePassword, isLoading: _isLoading)),
            ]),
          ]),
        ),
      ),
    );
  }
}
