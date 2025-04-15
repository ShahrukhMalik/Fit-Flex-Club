import 'package:flutter/material.dart';

void invokeSnackBar({
  required BuildContext context,
  String? message,
  String? actionLabel,
  VoidCallback? onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: (actionLabel != null && onPressed != null)
          ? SnackBarAction(label: actionLabel, onPressed: onPressed)
          : null,
      content: Text(
        message ?? "Something Went Wrong!",
      ),
    ),
  );
}
