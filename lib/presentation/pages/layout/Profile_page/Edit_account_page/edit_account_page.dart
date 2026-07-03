import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nutrizham/presentation/providers/auth_provider.dart';
import 'package:nutrizham/data/datasources/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/presentation/widgets/custom_app_bar.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_buttons.dart';
import 'package:nutrizham/presentation/widgets/stat_and_menu_widgets.dart';
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
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final user = await _authService.getCurrentUser();
      if (user == null) return;

      final updatedUser = user.copyWith(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        age: int.parse(_ageController.text),
      );

      final result = await context.read<AuthProvider>().updateProfile(updatedUser);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: result['success'] ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error),
      );

      if (result['success']) context.go('/home');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Theme.of(context).colorScheme.error));
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
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(color: Color(0xFF10B981)),
          const SizedBox(height: 16),
          Text(loc.loading, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
        ])),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: loc.editAccount),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            CustomTextField(controller: _usernameController, labelText: loc.username, prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next, validator: (v) => v?.isEmpty == true ? 'Username is required' : null),
            const SizedBox(height: 16),
            CustomTextField(controller: _emailController, labelText: loc.email, prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, validator: (v) => v?.isEmpty == true ? 'Email is required' : (!v!.contains('@') ? 'Invalid email' : null)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: theme.cardColor, border: Border.all(style: BorderStyle.solid, color: theme.colorScheme.outline), borderRadius: BorderRadius.circular(14)),
              child: MenuItemTile(icon: Icons.lock_outline, title: loc.changePassword, onTap: () => context.push('/settings/change-password')),
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: _ageController, labelText: loc.age, prefixIcon: Icons.calendar_today_outlined, keyboardType: TextInputType.number, textInputAction: TextInputAction.done, validator: (v) {
              final age = int.tryParse(v ?? '');
              if (age == null) return 'Age is required';
              if (age < 13) return 'Must be at least 13 years old';
              if (age > 150) return 'Invalid age';
              return null;
            }),
            const SizedBox(height: 32),
            Row(children: [
              Expanded(child: SecondaryButton(text: loc.cancel, onPressed: () => Navigator.pop(context))),
              const SizedBox(width: 16),
              Expanded(child: PrimaryButton(text: loc.save, onPressed: _isLoading ? null : _saveChanges, isLoading: _isLoading, icon: Icons.check)),
            ]),
          ]),
        ),
      ),
    );
  }
}
