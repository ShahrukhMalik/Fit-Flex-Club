import 'dart:io';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBottomSheet {
  static void show(BuildContext context,
      {required VoidCallback onUpload, required VoidCallback onDelete}) {
    if (Platform.isIOS) {
      _showCupertinoSheet(context, onUpload, onDelete);
    } else {
      _showMaterialSheet(context, onUpload, onDelete);
    }
  }

  static void _showMaterialSheet(
      BuildContext context, VoidCallback onUpload, VoidCallback onDelete) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return _buildBottomSheetContent(onUpload, onDelete);
      },
    );
  }

  static void _showCupertinoSheet(
      BuildContext context, VoidCallback onUpload, VoidCallback onDelete) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: onUpload,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.cloud_upload, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Upload", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: onDelete,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Delete", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDefaultAction: true,
            child: const Text("Cancel"),
          ),
        );
      },
    );
  }

  static Widget _buildBottomSheetContent(
      VoidCallback onUpload, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: globalColorScheme.inversePrimary,
                  foregroundColor: globalColorScheme.tertiary,
                ),
                icon: const Icon(
                  Icons.upload,
                  size: 32,
                ),
                onPressed: onUpload,
              ),
              Text(
                "Upload",
                style: TextStyle(
                  color: globalColorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: globalColorScheme.inversePrimary,
                  foregroundColor: globalColorScheme.tertiary,
                ),
                icon: const Icon(
                  Icons.delete,
                  size: 32,
                ),
                onPressed: onDelete,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  color: globalColorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
