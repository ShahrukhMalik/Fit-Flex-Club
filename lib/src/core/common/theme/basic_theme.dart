import 'package:flutter/material.dart';

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformApp extends StatelessWidget {
  final String title;
  final ThemeData? materialTheme;
  final CupertinoThemeData? cupertinoTheme;
  final Map<String, WidgetBuilder>? routes;
  final Widget Function(BuildContext, Widget?)? builder;
  final RouterConfig<Object>? routerConfig;

  const PlatformApp({
    super.key,
    required this.title,
    this.materialTheme,
    this.cupertinoTheme,
    this.routes,
    this.builder,
    this.routerConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoApp() : _buildMaterialApp();
  }

  Widget _buildMaterialApp() {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: materialTheme ?? _defaultMaterialTheme,
      routerConfig: routerConfig,
      builder: builder,
    );
  }

  Widget _buildCupertinoApp() {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: cupertinoTheme ?? _defaultCupertinoTheme,
      routerConfig: routerConfig,
      builder: builder,
    );
  }

  // Default themes if none provided
  ThemeData get _defaultMaterialTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ),
      useMaterial3: true,
      // Add your default Material styling here
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 48),
        ),
      ),
    );
  }

  CupertinoThemeData get _defaultCupertinoTheme {
    return const CupertinoThemeData(
      primaryColor: CupertinoColors.systemBlue,
      // Add your default Cupertino styling here
      barBackgroundColor: CupertinoColors.systemBackground,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
    );
  }
}

///Basic Theme for the application
ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 57.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 45.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 36.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 32.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 28.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 24.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 12.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 11.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: "Roboto",
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: "Roboto",
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: "Roboto",
        fontSize: 12.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
      ),
    );
  }

  ///base theme as light theme
  final ThemeData base = ThemeData.light();

  //return primary theme data
  return ThemeData(
    //Giving colorscheme to themeData here
    //To access all predefined colors through Theme.of(context).colorScheme
    textTheme: _basicTextTheme(base.textTheme),
    // primarySwatch: MaterialColor(1, {1: Color.fromARGB(255, 39, 150, 52)}),
    primaryColor: Colors.greenAccent,

    focusColor: Colors.greenAccent,
    secondaryHeaderColor: Colors.black,
    // scaffoldBackgroundColor: const Color(0xFF60D2B8),
    //fontFamily: "Roboto",
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: false,
      iconTheme: IconThemeData(color: Color(0xFF5CE1E6)),
      titleTextStyle: TextStyle(
          fontFamily: "Roboto",
          fontSize: 18.0,
          // color: crayola,
          fontWeight: FontWeight.bold),
      toolbarTextStyle: TextStyle(
          fontFamily: "Roboto",
          fontSize: 18.0,
          // color: crayola,
          fontWeight: FontWeight.bold),
    ),
    tabBarTheme: TabBarTheme(
      //labelPadding: EdgeInsets.all(3.0),
      // labelColor: crayola,
      labelStyle: const TextStyle(color: Colors.orangeAccent),
      unselectedLabelColor: Colors.blue.shade50,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(const Color(0xFF6BCC7D)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all<Size>(const Size(150, 36)),
        shadowColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 29, 131, 48)),
        elevation: MaterialStateProperty.all<double>(8),
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.greenAccent,
      onPrimary: Colors.black,
      onSecondary: Color(0xFF80D78A),
      secondary: Color.fromARGB(255, 39, 150, 52),
      error: Colors.redAccent,
      onError: Colors.greenAccent,
      background: Color.fromARGB(255, 242, 246, 242),
      onBackground: Color.fromARGB(255, 201, 246, 206),
      surface: Colors.white,
      onSurface: Colors.black,
    ).copyWith(background: Colors.white),
  );
}
