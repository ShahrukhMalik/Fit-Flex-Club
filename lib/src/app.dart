import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:flutter/material.dart';

///Widget that configures the application
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    //
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MultiBlocProvider(
      providers: [],
      child: AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          // return BlocBuilder<AppLaunchRouteLogicStateCubit,
          //     AppLaunchRouteLogicStateState>(
          //   builder: (context, state) {
          // final routeLogicState = state;
          return MaterialApp.router(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'fit-flex-club',
            debugShowCheckedModeBanner: false,
            //TODO: Use AppLocalizations to configure the correct application title
            theme: basicTheme(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            // Define a function to handle named routes in order to support
            onGenerateTitle: (context) => '',
            // routerDelegate: goRouter(routeLogicState).routerDelegate,
            // routeInformationParser: goRouter(routeLogicState).routeInformationParser,
            // routeInformationProvider: goRouter(routeLogicState).routeInformationProvider,
            // routerConfig: goRouter(routeLogicState),
          );
          // },
          // );
        },
      ),
    );
  }
}
