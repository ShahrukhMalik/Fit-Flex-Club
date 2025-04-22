import 'dart:async';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:flutter/material.dart';

class DebouncedTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const DebouncedTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  _DebouncedTextFieldState createState() => _DebouncedTextFieldState();
}

class _DebouncedTextFieldState extends State<DebouncedTextField> {
  Timer? _debounce;

  // Duration for debounce
  final Duration _debounceDuration = Duration(milliseconds: 500);

  void _onTextChanged(String value) {
    // Cancel the existing debounce timer
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // Create a new debounce timer
    _debounce = Timer(_debounceDuration, () {
      // Trigger the callback after the debounce duration
      widget.onChanged(value);
    });
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFields.basicTextField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      onChanged: _onTextChanged,
      // uniqueKey: UniqueKey(),
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: globalColorScheme.onPrimaryContainer,
      ),
    );
  }
}