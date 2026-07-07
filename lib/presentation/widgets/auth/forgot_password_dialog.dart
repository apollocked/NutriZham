import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<String?> showForgotPasswordDialog(BuildContext context) async {
  final loc = AppLocalizations.of(context)!;
  final emailController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(loc.validatingEmail),
        content: CustomTextField(
          controller: emailController,
          labelText: loc.email,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty || !value.contains('@')) {
              return loc.invalidEmail;
            }
            return null;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () {
              if (emailController.text.contains('@') &&
                  emailController.text.contains('.')) {
                Navigator.pop(context, emailController.text.trim());
              }
            },
            child: Text(loc.send),
          ),
        ],
      );
    },
  );
}
