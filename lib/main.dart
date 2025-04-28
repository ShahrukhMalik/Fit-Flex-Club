import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flex_club/firebase_options.dart';
import 'package:fit_flex_club/src/app.dart';
import 'package:fit_flex_club/src/core/common/services/fcm_service.dart';
import 'package:fit_flex_club/src/core/common/services/local_notification_service.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_service.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: Lock to both portrait up & down
  ]);
  // Show the system status bar
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  // Optional: Set the style (dark icons or light icons)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make it blend with your app
      statusBarIconBrightness:
          Brightness.dark, // Use Brightness.light for white icons
    ),
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: globalColorScheme.tertiary
          .withOpacity(0.4), // Background color of the status bar
      statusBarIconBrightness:
          Brightness.light, // Light icons (for dark background)
    ),
  );
  await configureDependencies();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  //configure the resource locator
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView

  await getIt.allReady().whenComplete(
    () {
      if (getIt.isRegistered<AuthenticationBloc>()) {
        FlutterNativeSplash.remove();
      }
    },
  );

  runApp(
    MyApp(
      settingsController: settingsController,
    ),
  );
}
