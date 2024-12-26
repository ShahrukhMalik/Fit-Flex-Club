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
    // Find the initial index of the selected value
    final initialIndex = widget.options.indexOf(selectedValue);

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250, // Total height for dialog
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: globalColorScheme.error,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "Select Month",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: globalColorScheme.onPrimaryContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Picker
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: initialIndex >= 0 ? initialIndex : 0,
                ),
                backgroundColor: Colors.white,
                useMagnifier: true,
                magnification: 1.15,
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedValue = widget.options[index];
                    widget.onChanged(widget.options[index]);
                  });
                },
                children: widget.options
                    .map(
                      (option) => Center(
                        child: Text(
                          option.values.first,
                          style: TextStyle(
                            fontSize: 16,
                            color: option == selectedValue
                                ? globalColorScheme.tertiaryContainer
                                : globalColorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
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
