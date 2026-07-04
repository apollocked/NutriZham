// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/auth_cubit.dart';
import 'package:nutrizham/data/datasources/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/presentation/widgets/common/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/profile/edit_account_form.dart';
import 'package:nutrizham/core/utils/connectivity_helper.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _authService = FirebaseAuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _ageController.text = user.age.toString();
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveChanges() async {
    if (!context.guardOnline()) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final authCubit = context.read<AuthCubit>();
      final user = await _authService.getCurrentUser();
      if (user == null) return;

      final updatedUser = user.copyWith(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        age: int.parse(_ageController.text),
      );

      final result = await authCubit.updateProfile(updatedUser);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(result['message']),
            backgroundColor: result['success']
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error),
      );

      if (result['success']) context.go('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(title: loc.editAccount),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(loc.loading,
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
        ])),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: loc.editAccount),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: EditAccountForm(
          formKey: _formKey,
          usernameController: _usernameController,
          emailController: _emailController,
          ageController: _ageController,
          onChangePassword: () => context.push('/settings/change-password'),
          onCancel: () => Navigator.pop(context),
          onSave: _saveChanges,
          isLoading: _isLoading,
        ),
      ),
    );
  }
}
