import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/clientweights/clientweights_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/getclientweights/getclientweights_cubit.dart';
import 'package:fit_flex_club/src/features/syncmanager/presentation/bloc/syncmanager_bloc.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Widget that configures the application
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // Fluttertoast.showToast(
    //     msg: result[0] == ConnectivityResult.none
    //         ? "You are offline"
    //         : "You are back online",
    //     gravity: ToastGravity.TOP,
    //     toastLength: Toast.LENGTH_LONG,
    //     backgroundColor: globalColorScheme.inversePrimary,
    //     textColor: globalColorScheme.onPrimaryContainer);
  }

  @override
  Widget build(BuildContext context) {
    var localizations = Localizations(
      locale: Locale('en', 'US'),
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate, // Add this line
        GlobalCupertinoLocalizations.delegate,
      ],
      child: Builder(builder: (context) {
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          buildWhen: (previous, current) => current.rebuild ?? false,
          listener: (context, state) {},
          builder: (context, state) {
            return PlatformApp(
              title: "Fit Flex Club",
              routerConfig: goRouter(state),
            );
          },
        );
      }),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>()
            // ..add(AuthenticateUserEvent())
            ..add(ListenToEvents()),
        ),
        // BlocProvider(
        //   create: (context) => getIt<AuthenticationBloc>()
        //     ..add(AuthenticateUserEvent())
        //     ..add(ListenToEvents()),
        // ),
        // BlocProvider(
        //   create: (context) =>
        //       getIt<SyncmanagerBloc>()..add(CheckConnectivityEvent()),
        // ),
        BlocProvider(create: (context) => getIt<ClientProfileBloc>()),
        BlocProvider(create: (context) => getIt<ClientweightsCubit>()),
        BlocProvider(create: (context) => getIt<GetclientweightsCubit>()),
        BlocProvider(create: (context) => getIt<TrainerProfileBloc>()),
        BlocProvider(
            create: (context) => getIt<WorkoutManagementBloc>()
              ..add(
                GetExercisesEvent(),
              )),
        BlocProvider(create: (context) => getIt<WorkoutHistoryBloc>()),
      ],
      child: localizations,
    );
  }
}
