import 'package:flutter/material.dart';
import 'package:nutrizham/services/auth_service.dart';
import 'package:nutrizham/utils/app_colors.dart';
import 'package:nutrizham/utils/app_localizations.dart';

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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(widget.languageCode);
    final bgColor = widget.isDarkMode
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor =
        widget.isDarkMode ? AppColors.darkText : AppColors.lightText;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGreen)),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(loc.editAccount),
        backgroundColor:
            widget.isDarkMode ? AppColors.darkCard : AppColors.primaryGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: loc.username,
                  prefixIcon:
                      const Icon(Icons.person, color: AppColors.primaryGreen),
                  filled: true,
                  fillColor:
                      widget.isDarkMode ? AppColors.darkCard : Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) =>
                    value?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: loc.email,
                  prefixIcon:
                      const Icon(Icons.email, color: AppColors.primaryGreen),
                  filled: true,
                  fillColor:
                      widget.isDarkMode ? AppColors.darkCard : Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) =>
                    value?.contains('@') == false ? 'Invalid email' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: loc.age,
                  prefixIcon: const Icon(Icons.calendar_today,
                      color: AppColors.primaryGreen),
                  filled: true,
                  fillColor:
                      widget.isDarkMode ? AppColors.darkCard : Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  return age == null || age < 13 ? 'Invalid age' : null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(loc.save,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
