// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/exceptions/exceptions.dart';
import 'package:todo_app/src/utils/alert_dialogs.dart';

/// Helper [AsyncValue] extension to handle UI states.
extension AsyncUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (hasError && !isLoading) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
          context: context, title: 'Error', exception: message);
    }
  }

  String _errorMessage(Object? error) {
    if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}
