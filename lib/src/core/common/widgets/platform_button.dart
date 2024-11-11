// lib/core/theme/button_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:injectable/injectable.dart';

enum ButtonType {
  primary, // Main action button
  secondary, // Secondary action button
  text, // Text-only button
  outlined, // Outlined button
  icon, // Icon-only button
  iconText, // Icon with text button
  action, // Floating action button
  segmented, // Segmented button group
  toggle, // Toggle button
  menu, // Menu button (dropdown)
  loading, // Button with loading state
  gradient, // Gradient background button
  destructive, // Delete/Remove action button
  chip, // Chip-style button
  expandable, // Expandable button
  social // Social media style button
}

@singleton
class PlatformButton {
  Widget? buildButton({
    required BuildContext context,
    required ButtonType type,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    double? width,
    double? height,
    double? borderRadius,
    bool isLoading = false,
    bool isEnabled = true,
    List<String>? menuItems,
    Function(String)? onMenuItemSelected,
    IconAlignment? iconAlignment,
    List<Color>? gradientColors,
    EdgeInsets? padding,
    EdgeInsets? textPadding,
    TextStyle? textStyle,
    BorderSide? border,
    List<BoxShadow>? boxShadow,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    Widget? child,
  }) {
    final bool isIOS = Platform.isIOS;

    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
          textPadding: textPadding,
        );

      case ButtonType.secondary:
        return _buildSecondaryButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
        );

      case ButtonType.text:
        return _buildTextButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          textStyle: textStyle,
        );

      case ButtonType.outlined:
        return _buildOutlinedButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          borderColor: backgroundColor ?? foregroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
          border: border,
        );

      case ButtonType.icon:
        return _buildIconButton(
          icon: icon ?? Icons.add,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
        );

      case ButtonType.iconText:
        return _buildIconTextButton(
          iconAlignment: iconAlignment,
          text: text,
          icon: icon ?? Icons.add,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
          mainAxisAlignment: mainAxisAlignment,
        );

      case ButtonType.action:
        return _buildFloatingActionButton(
          icon: icon ?? Icons.add,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          borderRadius: borderRadius,
          width: width,
          height: height,
        );

      case ButtonType.segmented:
        return _buildSegmentedButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
          menuItems: menuItems ?? [],
          onMenuItemSelected: onMenuItemSelected,
        );

      case ButtonType.toggle:
        return _buildToggleButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: isLoading,
          isIOS: isIOS,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
        );

      case ButtonType.menu:
        return _buildMenuButton(
          text: text,
          items: menuItems ?? [],
          onSelected: onMenuItemSelected,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isEnabled: isEnabled,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
          context: context,
        );

      case ButtonType.loading:
        return _buildLoadingButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          isLoading: true,
          isIOS: isIOS,
          padding: padding,
          borderRadius: borderRadius,
          width: width,
          height: height,
          textStyle: textStyle,
        );

      case ButtonType.gradient:
      // return _buildGradientButton(
      //   text: text,
      //   onPressed: isEnabled ? onPressed : null,
      //   gradientColors: gradientColors ?? [Colors.blue, Colors.purple],
      //   foregroundColor: foregroundColor,
      //   isLoading: isLoading,
      //   isIOS: isIOS,
      //   padding: padding,
      //   borderRadius: borderRadius,
      //   width: width,
      //   height: height,
      //   textStyle: textStyle,
      // );

      case ButtonType.destructive:
      // return _buildDestructiveButton(
      //   text: text,
      //   onPressed: isEnabled ? onPressed : null,
      //   backgroundColor: backgroundColor ?? Colors.red,
      //   foregroundColor: foregroundColor ?? Colors.white,
      //   isLoading: isLoading,
      //   isIOS: isIOS,
      //   padding: padding,
      //   borderRadius: borderRadius,
      //   width: width,
      //   height: height,
      //   textStyle: textStyle,
      // );

      case ButtonType.chip:
      // return _buildChipButton(
      //   text: text,
      //   onPressed: isEnabled ? onPressed : null,
      //   backgroundColor: backgroundColor,
      //   foregroundColor: foregroundColor,
      //   isLoading: isLoading,
      //   isIOS: isIOS,
      //   padding: padding,
      //   borderRadius: borderRadius ?? 20,
      //   width: width,
      //   height: height,
      //   textStyle: textStyle,
      //   icon: icon,
      // );

      case ButtonType.expandable:
      // return _buildExpandableButton(
      //   text: text,
      //   onPressed: isEnabled ? onPressed : null,
      //   backgroundColor: backgroundColor,
      //   foregroundColor: foregroundColor,
      //   isLoading: isLoading,
      //   isIOS: isIOS,
      //   padding: padding,
      //   borderRadius: borderRadius,
      //   width: width,
      //   height: height,
      //   textStyle: textStyle,
      //   child: child,
      // );

      case ButtonType.social:
      // return _buildSocialButton(
      //   text: text,
      //   onPressed: isEnabled ? onPressed : null,
      //   backgroundColor: backgroundColor,
      //   foregroundColor: foregroundColor,
      //   isLoading: isLoading,
      //   isIOS: isIOS,
      //   padding: padding,
      //   borderRadius: borderRadius,
      //   width: width,
      //   height: height,
      //   textStyle: textStyle,
      //   icon: icon,
      // );
    }
    return null;
  }

  // Loading Button
  Widget _buildLoadingButton({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoButton.filled(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Text(text, style: textStyle),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: textStyle),
      ),
    );
  }

  // Menu Button
  Widget _buildMenuButton({
    required String text,
    required List<String> items,
    required ValueChanged<String>? onSelected,
    required BuildContext context,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isEnabled = true,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        color: backgroundColor,
        onPressed: isEnabled
            ? () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: Text(text, style: textStyle),
                    actions: items
                        .map((item) => CupertinoActionSheetAction(
                              onPressed: () {
                                onSelected!(item);
                                Navigator.pop(context);
                              },
                              child: Text(item, style: textStyle),
                            ))
                        .toList(),
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                );
              }
            : null,
        child: Text(text, style: textStyle?.copyWith(color: foregroundColor)),
      );
    }

    return PopupMenuButton<String>(
      enabled: isEnabled,
      onSelected: onSelected,
      itemBuilder: (context) => items
          .map((item) => PopupMenuItem<String>(
                value: item,
                child: Text(item, style: textStyle),
              ))
          .toList(),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle?.copyWith(color: foregroundColor),
          ),
        ),
      ),
    );
  }

  // Toggle Button
  Widget _buildToggleButton({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: backgroundColor,
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Text(text, style: textStyle?.copyWith(color: foregroundColor)),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                ),
              ),
              child: Text(text, style: textStyle),
            ),
    );
  }

  // Floating Action Button
  Widget _buildFloatingActionButton({
    required IconData icon,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        color: backgroundColor ?? CupertinoColors.systemBlue,
        borderRadius: BorderRadius.circular(borderRadius ?? 28),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Icon(icon, color: foregroundColor ?? Colors.white),
      );
    }

    return SizedBox(
      width: width ?? 56,
      height: height ?? 56,
      child: FloatingActionButton(
        onPressed: isLoading ? null : onPressed,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 28),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon),
      ),
    );
  }

// Icon Text Button
  Widget _buildIconTextButton({
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    IconAlignment? iconAlignment,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.all(8),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Row(
                mainAxisAlignment: mainAxisAlignment,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconAlignment == IconAlignment.start)
                    Icon(icon, color: foregroundColor),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: textStyle?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                  if (iconAlignment == null ||
                      iconAlignment == IconAlignment.end)
                    Icon(icon, color: foregroundColor),
                ],
              ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon, color: foregroundColor),
        label: isLoading
            ? const SizedBox.shrink() // Hide label when loading
            : Text(text, style: textStyle?.copyWith(color: foregroundColor)),
        iconAlignment: iconAlignment ?? IconAlignment.end,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
      ),
    );
  }

// Segmented Button
  Widget _buildSegmentedButton({
    required String text,
    required VoidCallback? onPressed,
    required List<String> menuItems,
    required ValueChanged<String>? onMenuItemSelected,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoSegmentedControl<String>(
        padding: EdgeInsets.all(8),
        groupValue: text,
        children: {
          for (var item in menuItems)
            item: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(item,
                  style: textStyle?.copyWith(color: foregroundColor)),
            ),
        },
        onValueChanged: (selectedValue) {
          onMenuItemSelected!(selectedValue);
        },
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ToggleButtons(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              fillColor: backgroundColor,
              selectedColor: foregroundColor,
              color: foregroundColor?.withOpacity(0.7),
              isSelected: menuItems.map((item) => item == text).toList(),
              onPressed: (index) {
                onMenuItemSelected!(menuItems[index]);
              },
              children: menuItems
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(item, style: textStyle),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  // Icon Button
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.all(8),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Icon(icon, color: foregroundColor),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(icon, color: foregroundColor),
      ),
    );
  }

  // Outlined Button
  Widget _buildOutlinedButton({
    required String text,
    required VoidCallback? onPressed,
    Color? borderColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
    BorderSide? border,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: isLoading
            ? const CupertinoActivityIndicator()
            : Text(text, style: textStyle),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          padding: padding,
          side: border ?? BorderSide(color: borderColor ?? Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              )
            : Text(text, style: textStyle),
      ),
    );
  }

  // Text Button
  Widget _buildTextButton({
    required String text,
    required VoidCallback? onPressed,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        child: isLoading
            ? const CupertinoActivityIndicator()
            : Text(text, style: textStyle),
      );
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding,
        textStyle: textStyle,
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(text, style: textStyle),
    );
  }

  // Primary Button
  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    EdgeInsets? textPadding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return SizedBox(
        height: height,
        width: width,
        child: CupertinoButton(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          onPressed: onPressed,
          color: backgroundColor,
          child: isLoading
              ? const CupertinoActivityIndicator()
              : Padding(
                  padding:
                      textPadding ?? const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: textStyle),
      ),
    );
  }

  // Secondary Button
  Widget _buildSecondaryButton({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    bool isIOS = false,
    EdgeInsets? padding,
    double? borderRadius,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    if (isIOS) {
      return CupertinoButton(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        onPressed: onPressed,
        color: backgroundColor?.withOpacity(0.1),
        child: isLoading
            ? const CupertinoActivityIndicator()
            : Text(text, style: textStyle),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor?.withOpacity(0.1),
          foregroundColor: foregroundColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      foregroundColor ?? Colors.black),
                ),
              )
            : Text(text, style: textStyle),
      ),
    );
  }

  // ... Add implementations for all other button types ...
  // For brevity, I've shown just two implementations, but you would implement all types following similar patterns

  // Example implementation for other button types would follow here.
  // Each would handle both Material and Cupertino variants and include
  // loading states, styling options, etc.
}
