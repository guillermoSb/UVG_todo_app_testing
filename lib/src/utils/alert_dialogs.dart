// coverage:ignore-file
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Shows a dialog with the given [title] and [exception].
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content:
          exception.toString().isNotEmpty ? Text(exception.toString()) : null,
      actions: <Widget>[
        CupertinoButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
