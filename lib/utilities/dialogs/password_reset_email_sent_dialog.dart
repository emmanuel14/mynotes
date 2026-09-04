import 'package:flutter/widgets.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context, 
    title: 'Password Reset', 
    content: 'We have sent you an email with a link to reset your password.', 
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
w