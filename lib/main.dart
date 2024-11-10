import 'package:firebase_core/firebase_core.dart';
import 'package:fit_flex_club/firebase_options.dart';
import 'package:fit_flex_club/src/app.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();
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

  Future.delayed(Durations.medium4, () => FlutterNativeSplash.remove());
  runApp(
    MyApp(
      settingsController: settingsController,
    ),
  );
}
