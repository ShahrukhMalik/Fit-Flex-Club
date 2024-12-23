import 'dart:io';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlatformSpecificDropdown extends StatefulWidget {
  final List<Map<String, String>> options;
  final Map<String, String> initialValue;
  final ValueChanged<Map<String, String>> onChanged;
  final ValueChanged<String> onTap;

  const PlatformSpecificDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
    required this.onTap,
  });

  @override
  _PlatformSpecificDropdownState createState() =>
      _PlatformSpecificDropdownState();
}

class _PlatformSpecificDropdownState extends State<PlatformSpecificDropdown> {
  late Map<String, String> selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  void _showIosPicker(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: Colors.white,
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (index) {
            if (widget.options[index] != selectedValue) {
              setState(() {
                selectedValue = widget.options[index];
                widget.onChanged(widget.options[index]);
              });
              if (Platform.isIOS && context.canPop()) context.pop();
            } else {
              // Pop the dialog manually if the same item is tapped
              if (Platform.isIOS && context.canPop()) context.pop();
            }
          },
          children: widget.options
              .map(
                (option) => GestureDetector(
                  onTap: () {
                    if (option == selectedValue) {
                      context.pop();
                    } else {
                      selectedValue = option;
                      widget.onChanged(option);
                      setState(() {});
                      context.pop();
                    }
                  },
                  child: Center(
                    child: Text(
                      option.values.first,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // iOS Dropdown
      return GestureDetector(
        onTap: () => _showIosPicker(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: globalColorScheme.primary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: globalColorScheme.tertiary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedValue.values.first, style: TextStyle(fontSize: 16)),
              Icon(
                CupertinoIcons.chevron_down,
                color: globalColorScheme.tertiary,
              ),
            ],
          ),
        ),
      );
    } else {
      // Android Dropdown
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: globalColorScheme.tertiary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Map<String, String>>(
            isDense: true,
            value: selectedValue,
            items: widget.options
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option.values.first),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
                widget.onChanged(selectedValue);
              });
            },
          ),
        ),
      );
    }
  }
}
