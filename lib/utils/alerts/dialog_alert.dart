import 'package:flutter/material.dart';

Widget dialogAlert({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required VoidCallback onConfirm,
  VoidCallback? onCancel, 
}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      if (onCancel != null)  
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
      TextButton(
        onPressed: onConfirm,
        child: Text(confirmButtonText),
      ),
    ],
  );
}
