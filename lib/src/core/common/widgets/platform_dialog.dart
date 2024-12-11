import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformDialog {
  // Basic Alert Dialog
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (cancelText != null)
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onCancel?.call();
                  },
                  child: Text(cancelText),
                ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                child: Text(confirmText ?? 'OK'),
              ),
            ],
          );
        },
      );
    }

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: Text(title),
          content: Text(message),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(confirmText ?? 'OK'),
            ),
          ],
        );
      },
    );
  }

  // Custom Content Dialog
  static Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: actions ??
                [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
          );
        },
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
        );
      },
    );
  }

  // Loading Dialog
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? message,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(message),
                  ),
              ],
            ),
          );
        },
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(message),
                ),
            ],
          ),
        );
      },
    );
  }

  // Bottom Sheet Dialog
  static Future<T?> showBottomSheetDialog<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(title),
            message: content,
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: content,
            ),
            if (actions != null) ...actions,
            SafeArea(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
          ],
        );
      },
    );
  }

  // Action Sheet Dialog
  static Future<T?> showActionSheet<T>({
    required BuildContext context,
    required String title,
    required List<SheetAction> actions,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(title),
            actions: actions.map((action) {
              return CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop(action.value);
                  action.onPressed?.call();
                },
                isDestructiveAction: action.isDestructive,
                child: Text(action.title),
              );
            }).toList(),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          );
        },
      );
    }

    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: actions.map((action) {
                return ListTile(
                  title: Text(
                    action.title,
                    style: TextStyle(
                      color: action.isDestructive ? Colors.red : null,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(action.value);
                    action.onPressed?.call();
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Date Picker Dialog
  static Future<DateTime?> showDatePickerDialog({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    if (Platform.isIOS) {
      DateTime? selectedDate = initialDate;
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: firstDate,
                maximumDate: lastDate,
                onDateTimeChanged: (DateTime newDate) {
                  selectedDate = newDate;
                },
              ),
            ),
          );
        },
      );
      return selectedDate;
    }

    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}

// Helper class for action sheet items
class SheetAction<T> {
  final String title;
  final T? value;
  final VoidCallback? onPressed;
  final bool isDestructive;

  SheetAction({
    required this.title,
    this.value,
    this.onPressed,
    this.isDestructive = false,
  });
}
