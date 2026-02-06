import 'package:flutter/material.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/custom_text_field.dart';
import 'package:nutrizham/widgets/custom_buttons.dart';
import 'package:nutrizham/widgets/empty_state_widget.dart';

class EditAccountPage extends StatefulWidget {
  final bool isDarkMode;
  final String languageCode;
  const EditAccountPage(
      {super.key, required this.isDarkMode, required this.languageCode});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUserData();
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

    final user = await _authService.getCurrentUser();
    if (user == null) return;

    final updatedUser = user.copyWith(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      age: int.parse(_ageController.text),
    );

    await _authService.updateUser(updatedUser);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(widget.languageCode).accountUpdated),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MainNavigation(
              isDarkMode: widget.isDarkMode,
              languageCode: widget.languageCode)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          title: loc.editAccount,
          isDarkMode: widget.isDarkMode,
        ),
        body: LoadingWidget(
          message: loc.loading,
          isDarkMode: widget.isDarkMode,
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: loc.editAccount,
        isDarkMode: widget.isDarkMode,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _usernameController,
                labelText: loc.username,
                prefixIcon: Icons.person_outline,
                isDarkMode: widget.isDarkMode,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: loc.email,
                prefixIcon: Icons.email_outlined,
                isDarkMode: widget.isDarkMode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.contains('@') == false ? 'Invalid email' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _ageController,
                labelText: loc.age,
                prefixIcon: Icons.calendar_today_outlined,
                isDarkMode: widget.isDarkMode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  return age == null || age < 13 ? 'Invalid age' : null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: PrimaryButton(
                  text: loc.save,
                  onPressed: _saveChanges,
                  icon: Icons.check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
