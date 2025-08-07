import 'dart:io';
import 'dart:ui';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/frosted_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlatformSpecificDropdown extends StatefulWidget {
  final List<Map<String, String>> options;
  final Map<String, String> initialValue;
  final ValueChanged<Map<String, String>> onChanged;
  final ValueChanged<String> onTap;
  final String pickerTitle;
  final Color borderColor;
  final Color downArrowColor;
  final Color selectedOptionColor;

  const PlatformSpecificDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
    required this.onTap,
    required this.pickerTitle,
    required this.borderColor,
    required this.downArrowColor,
    required this.selectedOptionColor,
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
    int currentIndex = 0;

    setState(() {
      selectedValue = widget.options[0];
      widget.onChanged(widget.options[0]);
    });

    showBottomSheet(
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
            Material(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton.filled(
                    //   style: ButtonStyle(
                    //     backgroundColor: WidgetStateProperty.all(
                    //       globalColorScheme.error,
                    //     ),
                    //   ),
                    //   // focusColor: globalColorScheme.error,
                    //   highlightColor: globalColorScheme.error,
                    //   color: Colors.white,
                    //   onPressed: () {
                    //     selectedValue = widget.options[currentIndex];
                    //     Navigator.pop(context);
                    //   },
                    //   icon: Icon(Icons.close),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     selectedValue = widget.options[currentIndex];
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text(
                    //     "Cancel",
                    //     style: TextStyle(
                    //       color: globalColorScheme.error,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "Select ${widget.pickerTitle}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // IconButton.filled(
                    //   onPressed: () {
                    //     selectedValue = widget.options[currentIndex];
                    //     Navigator.pop(context);
                    //   },
                    //   icon: Icon(Icons.check),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     selectedValue = widget.options[currentIndex];
                    //     Navigator.pop(context);
                    //   },
                    //   child: Text(
                    //     "Done",
                    //     style: TextStyle(
                    //       color: globalColorScheme.onPrimaryContainer,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w800,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // Simple Scrollable List
            Expanded(
              child: ListView.builder(
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final option = widget.options[index];
                  final isSelected = option == selectedValue;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = option;
                        widget.onChanged(option);
                      });
                      context.pop(); // Close the modal or picker sheet
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      color: isSelected
                          ? globalColorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                      child: Text(
                        option.values.first,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? globalColorScheme.tertiaryContainer
                              : globalColorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (true) {
      // iOS Dropdown
      return GestureDetector(
        onTap: () => _showIosPicker(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            // borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(
                color: widget.borderColor,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue.values.first,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.selectedOptionColor.withOpacity(0.7),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_down,
                color: widget.downArrowColor,
              ),
            ],
          ),
        ),
      );
    } else {
      // Android Dropdown
      return FrostedDropdown(
        options: widget.options,
        selectedValue: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.onChanged(selectedValue);
          });
        },
        selectedOptionColor: widget.selectedOptionColor,
      );
      // return BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //   child: Container(
      //     margin: EdgeInsets.all(12),
      //     decoration: BoxDecoration(
      //       color: Colors.white.withOpacity(0.1), // Semi-transparent
      //       borderRadius: BorderRadius.circular(20),
      //       border: Border.all(
      //         color: Colors.white.withOpacity(0.2),
      //       ),
      //     ),
      //     child: DropdownButtonHideUnderline(
      //       child: DropdownButton<Map<String, String>>(
      //         style: TextStyle(color: widget.selectedOptionColor),
      //         isDense: true,
      //         iconEnabledColor: widget.selectedOptionColor,
      //         value: selectedValue,
      //         items: widget.options
      //             .map(
      //               (option) => DropdownMenuItem(
      //                 value: option,
      //                 child: Text(
      //                   option.values.first,
      //                   style: TextStyle(
      //                     fontSize: 16,
      //                     color: globalColorScheme.primaryContainer,
      //                   ),
      //                 ),
      //               ),
      //             )
      //             .toList(),
      //         onChanged: (value) {
      //           setState(() {
      //             selectedValue = value!;
      //             widget.onChanged(selectedValue);
      //           });
      //         },
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}
