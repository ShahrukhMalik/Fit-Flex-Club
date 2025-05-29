import 'dart:io';
import 'package:fit_flex_club/src/core/common/validators/textform_field_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum TextFieldType { name, email, password }

class AppTextFields {
  static Widget basicTextField({
    // required GlobalKey<FormState> formStateKey,
    TextFieldType? fieldType,
    List<TextInputFormatter>? textInputFormatter,
    String? labelText,
    String? hintText,
    TextStyle? style,
    TextEditingController? controller,
    void Function(String)? onChanged,
    TextInputType? keyboardType,
    BoxDecoration? boxDecoration,
    bool enabled = true,
    InputBorder? border,
    String? initialValue,
    UniqueKey? uniqueKey,
    TextAlign? textAlign,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextFormFieldRow(
        textInputAction: TextInputAction.done,
        key: uniqueKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: initialValue,
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        // key: formStateKey,
        inputFormatters: textInputFormatter,
        validator: (value) {
          if (fieldType == TextFieldType.name) {
            return nameValidator(value);
          }
          if (fieldType == TextFieldType.email) {
            return emailValidator(value);
          }

          return null;
        },
        style: style ??
            TextStyle(
              color: Color(0xFFFFCD7C),
            ),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        placeholderStyle: style ??
            TextStyle(
              color: Color.fromARGB(152, 255, 205, 124),
            ),
        placeholder: labelText ?? hintText,
        // padding: const EdgeInsets.all(12),
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: boxDecoration ??
            BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey),
              borderRadius: BorderRadius.circular(8),
            ),
      );
    }

    return TextFormField(
      textInputAction: TextInputAction.done,
      key: uniqueKey,
      initialValue: initialValue,
      textAlign: TextAlign.center,
      inputFormatters: textInputFormatter,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // key: formStateKey,
      style: style ??
          TextStyle(
            color: Color(0xFFFFCD7C),
          ),
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: (value) {
        if (fieldType == TextFieldType.name) {
          return nameValidator(value);
        }
        if (fieldType == TextFieldType.email) {
          return emailValidator(value);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xFFFFCD7C),
              ),
            ),
      ),
    );
  }

  static Widget passwordTextField({
    String? labelText,
    BoxDecoration? boxDecoration,
    TextEditingController? controller,
    void Function(String)? onChanged,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    InputBorder? border,
    TextStyle? style,
  }) {
    if (Platform.isIOS) {
      return CupertinoTextFormFieldRow(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: style ??
            TextStyle(
              color: Color(0xFFFFCD7C),
            ),
        controller: controller,
        decoration: boxDecoration,
        prefix: GestureDetector(
          onTap: onToggleVisibility,
          child: Icon(
            obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            size: 20,
            color: Color(0xFFFFCD7C),
          ),
        ),
        placeholder: 'Enter your password',
        obscureText: obscureText,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        validator: (value) => passwordValidator(value),
      );
    }

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: style ??
          TextStyle(
            color: Color(0xFFFFCD7C),
          ),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => passwordValidator(value),
      decoration: InputDecoration(
        labelText: labelText,
        border: border ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xFFFFCD7C),
              ),
            ),
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
    TextInputType? keyboardType,
    TextStyle? style,
    Color? filledColor,
    bool usePadding = false,
    TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String)? onFieldSubmitted,
  }) {
    if (Platform.isIOS) {
      if (usePadding) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          decoration: BoxDecoration(
            color: filledColor ?? CupertinoColors.systemGrey4,
            borderRadius: BorderRadius.circular(100),
            border:
                Border.all(color: filledColor ?? CupertinoColors.systemGrey4),
          ),
          child: CupertinoTextFormFieldRow(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: onFieldSubmitted,
            validator: (value) {
              // if (value == null || value.isEmpty) {
              //   return 'Please enter weight';
              // }
              return null;
            },
            style: style ?? const TextStyle(fontSize: 16),
            keyboardType: keyboardType,
            controller: controller,
            placeholderStyle: TextStyle(color: style?.color?.withOpacity(0.7)),
            placeholder: labelText ?? "Type a message",
            onChanged: onChanged,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            prefix: prefix != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: prefix,
                  )
                : null,
            decoration: BoxDecoration(
              color: filledColor ?? CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        );
      } else {
        return CupertinoTextFormFieldRow(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return 'Please enter weight';
            // }
            return null;
          },
          style: style ?? const TextStyle(fontSize: 16),
          keyboardType: keyboardType,
          controller: controller,
          placeholderStyle: TextStyle(color: style?.color?.withOpacity(0.7)),
          placeholder: labelText ?? "Type a message",
          onChanged: onChanged,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          prefix: prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: prefix,
                )
              : null,
          decoration: BoxDecoration(
            color: filledColor ?? CupertinoColors.systemGrey5,
            borderRadius: BorderRadius.circular(25),
          ),
        );
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: filledColor ?? CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          if (prefix != null) prefix,
          Expanded(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: onFieldSubmitted,
              validator: (value) => null,
              style: style,
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: labelText ?? 'Type a message',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          if (suffix != null) suffix,
        ],
      ),
    );
  }
}
