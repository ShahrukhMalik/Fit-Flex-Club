import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTextFields {
  static Widget basicTextField({
    String? labelText,
    String? hintText,
    TextEditingController? controller,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: labelText ?? hintText,
        onChanged: onChanged,
        padding: const EdgeInsets.all(12),
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  static Widget passwordTextField({
    String? labelText,
    TextEditingController? controller,
    void Function(String)? onChanged,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: labelText,
        onChanged: onChanged,
        padding: const EdgeInsets.all(12),
        obscureText: obscureText,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        suffix: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: onToggleVisibility,
            child: Icon(
              obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              size: 20,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  static Widget searchTextField({
    String? hintText,
    TextEditingController? controller,
    void Function(String)? onChanged,
    VoidCallback? onClear,
  }) {
    if (Platform.isIOS) {
      return CupertinoSearchTextField(
        controller: controller,
        placeholder: hintText,
        onChanged: onChanged,
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        ),
      ),
    );
  }

  static Widget multilineTextField({
    String? labelText,
    String? hintText,
    TextEditingController? controller,
    void Function(String)? onChanged,
    int maxLines = 3,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: labelText ?? hintText,
        onChanged: onChanged,
        padding: const EdgeInsets.all(12),
        maxLines: maxLines,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }

  static Widget errorTextField({
    String? labelText,
    String? errorText,
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    if (Platform.isIOS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoTextField(
            controller: controller,
            placeholder: labelText,
            onChanged: onChanged,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemRed),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 12),
              child: Text(
                errorText,
                style: const TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  static Widget prefixSuffixTextField({
    String? labelText,
    Widget? prefix,
    Widget? suffix,
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: labelText,
        onChanged: onChanged,
        padding: const EdgeInsets.all(12),
        prefix: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: prefix,
              )
            : null,
        suffix: suffix != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: suffix,
              )
            : null,
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}