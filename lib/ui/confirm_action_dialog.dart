import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/language/language.dart';

void showConfirmationDialog({
  required BuildContext context,
  required void Function() onConfirm,
  required void Function() onCancel,
  Widget? icon,
  Widget? title,
  Widget? content,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        icon: icon ?? Icon(Icons.dangerous),
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: Text(currentLanguage.confirm),
          ),
          OutlinedButton(
            onPressed: onCancel,
            child: Text(currentLanguage.cancel),
          ),
        ],
      );
    },
  );
}
