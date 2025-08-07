import 'dart:ui';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter/material.dart';

class FrostedDropdown extends StatefulWidget {
  final List<Map<String, String>> options;
  final Map<String, String> selectedValue;
  final Function(Map<String, String>) onChanged;
  final Color selectedOptionColor;

  const FrostedDropdown({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.selectedOptionColor,
    Key? key,
  }) : super(key: key);

  @override
  State<FrostedDropdown> createState() => _FrostedDropdownState();
}

class _FrostedDropdownState extends State<FrostedDropdown> {
  late Map<String, String> selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  void showCustomDropdownMenu() {
    final overlay = Overlay.of(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final size = box.size;

    late OverlayEntry entry; // ✅ Declare before using

    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + size.height,
        width: size.width,
        child: Material(
          color: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (_, index) {
                  final option = widget.options[index];
                  final isSelected = option == selectedValue;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = option;
                      });
                      widget.onChanged(option);
                      entry.remove(); // ✅ No error now
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? widget.selectedOptionColor.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Text(
                        option.values.first,
                        style: TextStyle(
                          color: globalColorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showCustomDropdownMenu,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedValue.values.first,
              style: TextStyle(
                color: widget.selectedOptionColor,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: widget.selectedOptionColor),
          ],
        ),
      ),
    );
  }
}
