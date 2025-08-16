import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

final Color primaryColor = Color(0xFFFFCD7C);
final Color primaryContrastingColor =
    Color(0xFF333333); // Primary color for the app.

///WIth Worm COlors
// final ColorScheme globalColorScheme = ColorScheme(
//   brightness: Brightness.light,

//   // Primary Colors
//   primary: Color(0xFFFFCD7C), // Main peachy-orange
//   onPrimary: Color(0xFF2D3142), // Dark text for contrast on primary
//   primaryContainer: Color(0xFFFFB84D), // Darker variant of primary
//   onPrimaryContainer: Color(0xFF2D3142), // Text on primary container

//   // Secondary Colors
//   secondary: Color(0xFF7C9EFF), // Complementary blue
//   onSecondary: Colors.white, // White text on secondary
//   secondaryContainer: Color(0xFF5C7AE6), // Darker blue for emphasis
//   onSecondaryContainer: Colors.white, // Text on secondary container

//   // Tertiary Colors
//   tertiary: Color(0xFF65D6AD), // Teal accent
//   onTertiary: Colors.white, // Text on tertiary
//   tertiaryContainer: Color(0xFF53C69B), // Darker teal
//   onTertiaryContainer: Colors.white, // Text on tertiary container

//   // Error Colors
//   error: Color(0xFFE53935), // Error red
//   onError: Colors.white, // Text on error
//   errorContainer: Color(0xFFFFCDD2), // Light error background
//   onErrorContainer: Color(0xFFB71C1C), // Dark error text

//   // Neutral Colors
//   surface: Colors.white, // Surface color
//   onSurface: Color(0xFF2D3142), // Text on surface
//   surfaceContainerHighest: Color(0xFFF8F8F8), // Alternative surface
//   onSurfaceVariant: Color(0xFF6C6F80), // Secondary text

//   // Additional Colors
//   outline: Color(0xFFE1E1E1), // Borders and dividers
//   outlineVariant: Color(0xFFBDBDBD), // Secondary borders
//   shadow: Colors.black.withOpacity(0.1), // Elevation shadows
//   scrim: Colors.black.withOpacity(0.3), // Modal overlays

//   // Inverse Colors
//   inverseSurface: Color(0xFF2D3142), // Dark surface
//   onInverseSurface: Colors.white, // Text on dark surface
//   inversePrimary: Color(0xFFFFE2B0), // Light primary for dark themes
// );
final ColorScheme globalColorScheme = ColorScheme(
  brightness: Brightness.light,
  // Primary Colors
  primary: Color(0xFFFFCD7C), // Main peachy-orange
  onPrimary: Color(0xFF2D3142), // Dark text for contrast on primary
  primaryContainer: Color(0xFFFFB84D), // Darker variant of primary
  onPrimaryContainer: Color(0xFF2D3142), // Text on primary container

  // Secondary Colors (Red Shades)
  secondary: Color(0xFFFF7C7C), // Coral red
  onSecondary: Colors.white, // White text on secondary
  secondaryContainer: Color(0xFFFF5252), // Deeper red for emphasis
  onSecondaryContainer: Colors.white, // Text on secondary container

  // Tertiary Colors (Darker Reds)
  tertiary: Color(0xFFE64A4A), // Dark red accent
  onTertiary: Colors.white, // Text on tertiary
  tertiaryContainer: Color(0xFFD32F2F), // Even darker red
  onTertiaryContainer: Colors.white, // Text on tertiary container

  // Error Colors
  error: Color(0xFFB71C1C), // Deep red for errors
  onError: Colors.white, // Text on error
  errorContainer: Color(0xFFFFEBEE), // Light error background
  onErrorContainer: Color(0xFF932121), // Text on background
  surface: Color(0xFFFFF4E6), // Surface color
  onSurface: Color(0xFF2D3142), // Text on surface
  surfaceContainerHighest: Color(0xFFFFF4E6), // Slightly peachy surface
  onSurfaceVariant: Color(0xFF6C6F80), // Secondary text

  // Additional Colors
  outline: Color(0xFFE8D5C4), // Warm borders and dividers
  outlineVariant: Color(0xFFDBC4B1), // Secondary borders
  shadow: Colors.black.withOpacity(0.1), // Elevation shadows
  scrim: Colors.black.withOpacity(0.3), // Modal overlays

  // Inverse Colors
  inverseSurface: Color(0xFF2D3142), // Dark surface
  onInverseSurface: Colors.white, // Text on dark surface
  inversePrimary: Color(0xFFFFE2B0), // Light primary for dark themes
);
final TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: globalColorScheme.onSurface,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: globalColorScheme.primary,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: globalColorScheme.onSurface,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: globalColorScheme.onSurface,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: globalColorScheme.onSurface,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: globalColorScheme.onSurface,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: globalColorScheme.onSurface,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: globalColorScheme.primary,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: globalColorScheme.primary,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: globalColorScheme.onSurface,
  ),
);

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
    return
        // Platform.isIOS ? _buildCupertinoApp() :
        _buildMaterialApp();
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
      colorScheme: globalColorScheme,
      primaryColor: globalColorScheme.primary,
      scaffoldBackgroundColor: globalColorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: globalColorScheme.primary,
        foregroundColor: globalColorScheme.onPrimary,
        titleTextStyle: TextStyle(
          color: globalColorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: globalColorScheme.surface,
        selectedItemColor: globalColorScheme.primary,
        unselectedItemColor: globalColorScheme.tertiary,
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: globalColorScheme.primary,
          foregroundColor: globalColorScheme.onPrimary,
        ),
      ),
    );
  }

  CupertinoThemeData get _defaultCupertinoTheme {
    return CupertinoThemeData(
      brightness: Brightness.light, // Light theme
      primaryColor: Color(0xFFFFCD7C), // Main peachy-orange
      primaryContrastingColor: Color(0xFF2D3142), // Contrasting dark text color
      barBackgroundColor: Color(0xFFFFFBF7), // Warm white for navigation bars
      scaffoldBackgroundColor:
          Color(0xFFFFFBF7), // Warm white for scaffold background

      // Text Styles
      textTheme: CupertinoTextThemeData(
        primaryColor: Color(0xFF2D3142), // Default text color
        textStyle: TextStyle(
          color: Color(0xFF2D3142),
          fontSize: 16,
        ),
        actionTextStyle: TextStyle(
          color: Color(0xFFFF7C7C), // Coral red for actionable text
        ),
        navTitleTextStyle: TextStyle(
          color: Color(0xFF2D3142),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        navActionTextStyle: TextStyle(
          color: Color(0xFFFF5252), // Deeper red for navigation actions
        ),
        tabLabelTextStyle: TextStyle(
          color: Color(0xFFD32F2F), // Dark red for tab labels
        ),
      ),
      applyThemeToAll: true,
      // Custom Cupertino components
      // barBackgroundColor: Color(0xFFFFF4E6), // Peachy tone for headers
      // dividerColor: Color(0xFFE8D5C4), // Warm border and divider color
    );
  }
}

///Basic Theme for the application
ThemeData basicTheme() {
  TextTheme basicTextTheme(TextTheme base) {
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
    textTheme: basicTextTheme(base.textTheme),
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
    tabBarTheme: TabBarThemeData(
      //labelPadding: EdgeInsets.all(3.0),
      // labelColor: crayola,
      labelStyle: const TextStyle(color: Colors.orangeAccent),
      unselectedLabelColor: Colors.blue.shade50,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(const Color(0xFF6BCC7D)),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all<Size>(const Size(150, 36)),
        shadowColor:
            WidgetStateProperty.all(const Color.fromARGB(255, 29, 131, 48)),
        elevation: WidgetStateProperty.all<double>(8),
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
      surface: Colors.white,
      onSurface: Colors.black,
    ).copyWith(surface: Colors.white),
  );
}
