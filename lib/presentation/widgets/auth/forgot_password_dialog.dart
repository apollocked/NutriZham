import 'package:flutter/material.dart';
import 'package:nutrizham/presentation/widgets/Form_Widgets/custom_text_field.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

Future<String?> showForgotPasswordDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return const _ForgotPasswordDialogContent();
    },
  );
}

class _ForgotPasswordDialogContent extends StatefulWidget {
  const _ForgotPasswordDialogContent();

  @override
  State<_ForgotPasswordDialogContent> createState() =>
      _ForgotPasswordDialogContentState();
}

class _ForgotPasswordDialogContentState
    extends State<_ForgotPasswordDialogContent> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(loc.validatingEmail),
      content: CustomTextField(
        controller: _emailController,
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
            if (_emailController.text.contains('@') &&
                _emailController.text.contains('.')) {
              Navigator.pop(context, _emailController.text.trim());
            }
          },
          child: Text(loc.send),
        ),
      ],
    );
  }
}
