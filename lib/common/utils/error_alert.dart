import 'package:flutter/material.dart';

class ErrorAlert {
  static showError(BuildContext context, {required String error, VoidCallback? onPressedCancel}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Oops'),
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () {
                onPressedCancel?.call();
                Navigator.pop(context);
              },
              child: const Text('OK')),
        ],
      ),
    );
  }
}
