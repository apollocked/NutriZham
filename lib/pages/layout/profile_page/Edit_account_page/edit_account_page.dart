import 'package:flutter/material.dart';
import 'package:nutrizham/pages/layout/main_navigation.dart';
import 'package:nutrizham/pages/layout/Profile_page/Edit_account_page/Change_Password_Page/change_password_page.dart';
import 'package:nutrizham/services/Auth_Services/firebase_auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';
import 'package:nutrizham/widgets/Form_Wedgits/empty_state_widget.dart';
import 'package:nutrizham/widgets/custom_app_bar.dart';
import 'package:nutrizham/widgets/Form_Wedgits/custom_text_field.dart';
import 'package:nutrizham/widgets/Form_Wedgits/custom_buttons.dart';
import 'package:nutrizham/widgets/stat_and_menu_widgets.dart';

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

  // Update user profile information
  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await _authService.getCurrentUser();
      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final updatedUser = user.copyWith(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        age: int.parse(_ageController.text),
      );

      final result = await _authService.updateUserProfile(updatedUser);

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
              // Username Field
              CustomTextField(
                controller: _usernameController,
                labelText: loc.username,
                prefixIcon: Icons.person_outline,
                isDarkMode: widget.isDarkMode,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.isEmpty == true ? 'Username is required' : null,
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
                  if (value?.isEmpty == true) {
                    return 'Email is required';
                  }
                  if (value?.contains('@') == false) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Change Password Tile
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: widget.isDarkMode
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MenuItemTile(
                  icon: Icons.lock_outline,
                  title: loc.changePassword,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangePasswordPage(
                          isDarkMode: widget.isDarkMode,
                          languageCode: widget.languageCode,
                        ),
                      ),
                    );
                  },
                  isDarkMode: widget.isDarkMode,
                ),
              ),
              const SizedBox(height: 16),

              // Age Field
              CustomTextField(
                controller: _ageController,
                labelText: loc.age,
                prefixIcon: Icons.calendar_today_outlined,
                isDarkMode: widget.isDarkMode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  if (age == null) {
                    return 'Age is required';
                  }
                  if (age < 13) {
                    return 'Must be at least 13 years old';
                  }
                  if (age > 150) {
                    return 'Invalid age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: loc.cancel,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: loc.save,
                      onPressed: _isLoading ? null : _saveChanges,
                      isLoading: _isLoading,
                      icon: Icons.check,
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
