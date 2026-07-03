import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_buttons.dart';
import 'package:nutrizham/l10n/app_localizations.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/secondary_button.dart';
import 'package:nutrizham/presentation/widgets/menu_item_tile.dart';

class EditAccountForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController ageController;
  final VoidCallback onChangePassword;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isLoading;

  const EditAccountForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.ageController,
    required this.onChangePassword,
    required this.onCancel,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Column(children: [
        CustomTextField(
            controller: usernameController,
            labelText: loc.username,
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: (v) =>
                v?.isEmpty == true ? 'Username is required' : null),
        const SizedBox(height: 16),
        CustomTextField(
            controller: emailController,
            labelText: loc.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (v) => v?.isEmpty == true
                ? 'Email is required'
                : (!v!.contains('@') ? 'Invalid email' : null)),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border.all(
                  style: BorderStyle.solid, color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(14)),
          child: MenuItemTile(
              icon: Icons.lock_outline,
              title: loc.changePassword,
              onTap: onChangePassword),
        ),
        const SizedBox(height: 16),
        CustomTextField(
            controller: ageController,
            labelText: loc.age,
            prefixIcon: Icons.calendar_today_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (v) {
              final age = int.tryParse(v ?? '');
              if (age == null) return 'Age is required';
              if (age < 13) return 'Must be at least 13 years old';
              if (age > 150) return 'Invalid age';
              return null;
            }),
        const SizedBox(height: 32),
        Row(children: [
          Expanded(
              child: SecondaryButton(text: loc.cancel, onPressed: onCancel)),
          const SizedBox(width: 16),
          Expanded(
              child: PrimaryButton(
                  text: loc.save,
                  onPressed: isLoading ? null : onSave,
                  isLoading: isLoading,
                  icon: Icons.check)),
        ]),
      ]),
    );
  }
}
