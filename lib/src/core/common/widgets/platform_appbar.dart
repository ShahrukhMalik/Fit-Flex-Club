import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PlatformAppbar {
  static Widget basicBottomNavBar({
    required int currentIndex,
    required List<BottomNavigationBarItem> items,
    required ValueChanged<int> onTap,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    if (Platform.isIOS) {
      return CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor ?? Colors.white,
        activeColor: activeColor ?? Color(0xFFFFCD7C),
        inactiveColor: inactiveColor ?? Colors.grey,
      );
    }

    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
      selectedItemColor: activeColor ?? Color(0xFFFFCD7C),
      unselectedItemColor: inactiveColor ?? Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }

  // Basic AppBar with title
  static PreferredSizeWidget basicAppBar({
    required dynamic title,
    Color? backgroundColor,
    Color? foregroundColor,
    bool automaticallyImplyLeading = true,
    VoidCallback? onLeadingPressed,
    required BuildContext context,
    Widget? trailing,
    EdgeInsetsDirectional? padding,
    double? width,
    double? height,
    Widget? leadingWidget,
  }) {
    if (Platform.isIOS) {
      return PreferredSize(
        preferredSize: Size(
          width ?? double.maxFinite,
          height ?? 120,
        ),
        child: CupertinoNavigationBar(
          enableBackgroundFilterBlur: true,
          padding: padding,
          middle: title.runtimeType != String
              ? title
              : Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor ?? Color(0xFFFFCD7C),
                    fontSize: 22,
                  ),
                ),
          automaticallyImplyMiddle: true,
          trailing: trailing,
          border: Border.all(width: 0),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: automaticallyImplyLeading
              ? Material(
                color: Colors.transparent,
                  child: InkWell(
                    onTap: onLeadingPressed,
                    child: SizedBox(
                      width: 60, // or 44.0 (standard iOS)
                      child: leadingWidget ??
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: onLeadingPressed ?? () => context.pop(),
                            child: Icon(
                              CupertinoIcons.back,
                              color: foregroundColor,
                            ),
                          ),
                    ),
                  ),
                )
              : null,
        ),
      );
    }

    return AppBar(
      title: title.runtimeType != String
          ? title
          : Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFCD7C),
                fontSize: 20,
              ),
            ),
      iconTheme: IconThemeData(
        color: Color(0xFFFFCD7C),
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      actions: [trailing ?? SizedBox()],
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && onLeadingPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onLeadingPressed,
              color: Color(0xFFFFCD7C),
            )
          : null,
    );
  }

  // AppBar with actions
  static PreferredSizeWidget appBarWithActions({
    required String title,
    required List<Widget> actions,
    Color? backgroundColor,
    Color? foregroundColor,
    bool automaticallyImplyLeading = true,
    VoidCallback? onLeadingPressed,
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: Text(title),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: automaticallyImplyLeading
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed:
                    onLeadingPressed ?? () => Navigator.of(context).pop(),
                child: const Icon(CupertinoIcons.back),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions
              .map((action) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: action,
                  ))
              .toList(),
        ),
      );
    }

    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && onLeadingPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onLeadingPressed,
            )
          : null,
      actions: actions,
    );
  }

  // AppBar with custom title widget
  static PreferredSizeWidget appBarWithCustomTitle({
    required Widget titleWidget,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? foregroundColor,
    bool automaticallyImplyLeading = true,
    VoidCallback? onLeadingPressed,
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: titleWidget,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: automaticallyImplyLeading
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed:
                    onLeadingPressed ?? () => Navigator.of(context).pop(),
                child: const Icon(CupertinoIcons.back),
              )
            : null,
        trailing: actions != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ))
                    .toList(),
              )
            : null,
      );
    }

    return AppBar(
      title: titleWidget,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && onLeadingPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onLeadingPressed,
            )
          : null,
      actions: actions,
    );
  }

  // Search AppBar
  static PreferredSizeWidget searchAppBar({
    required TextEditingController searchController,
    required ValueChanged<String> onChanged,
    String? hintText,
    Color? backgroundColor,
    Color? foregroundColor,
    VoidCallback? onLeadingPressed,
    List<Widget>? actions,
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        middle: CupertinoSearchTextField(
          controller: searchController,
          onChanged: onChanged,
          placeholder: hintText,
        ),
        backgroundColor: backgroundColor,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
          child: const Icon(CupertinoIcons.back),
        ),
        trailing: actions != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ))
                    .toList(),
              )
            : null,
      );
    }

    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
      ),
      title: TextField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText ?? 'Search',
          border: InputBorder.none,
          hintStyle: TextStyle(color: foregroundColor?.withOpacity(0.6)),
        ),
        style: TextStyle(color: foregroundColor),
      ),
      actions: actions,
    );
  }

  // Sliver AppBar
  static Widget sliverAppBar({
    required String title,
    String? expandedTitle,
    double expandedHeight = 200.0,
    Widget? background,
    Color? backgroundColor,
    Color? foregroundColor,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    VoidCallback? onLeadingPressed,
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      return CupertinoSliverNavigationBar(
        largeTitle: Text(expandedTitle ?? title),
        backgroundColor: backgroundColor,
        leading: automaticallyImplyLeading
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed:
                    onLeadingPressed ?? () => Navigator.of(context).pop(),
                child: const Icon(CupertinoIcons.back),
              )
            : null,
        trailing: actions != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ))
                    .toList(),
              )
            : null,
      );
    }

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading && onLeadingPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onLeadingPressed,
            )
          : null,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        background: background,
      ),
    );
  }

  // Example usage
}
