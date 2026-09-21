import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// shows a dialog to confirm an action
///
/// -[onConfirm]: called if the user confirms the action
/// -[onCancel]: called if the user cancels the action
/// -[onDismissed]: called if the user dismisses the dialog (eg when clicking outside the dialog)
///
void showConfirmationDialog({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onCancel,
  void Function()? onDismissed,
  Widget? icon,
  Widget? title,
  Widget? content,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: icon ?? Icon(Icons.dangerous),
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(currentLanguage.confirm),
          ),
          OutlinedButton(
            onPressed: () {
              onCancel;

              Navigator.pop(context);
            },
            child: Text(currentLanguage.cancel),
          ),
        ],
      );
    },
  );
}
