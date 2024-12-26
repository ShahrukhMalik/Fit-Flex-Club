import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/clientweights/clientweights_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/getclientweights/getclientweights_cubit.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/event_listener_usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/mark_event_listened_usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/presentation/bloc/syncmanager_bloc.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/getworkoutplan/getworkoutplan_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/getexercises/getexercises_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

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

  bool isOnline = true;

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

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: globalColorScheme.secondary,
      textColor: globalColorScheme.onPrimaryContainer,
      fontSize: 18,
      gravity: ToastGravity.TOP,
    );
  }

  _syncData() async {
    _showToast("Syncing data...");
    final syncRepo = await getIt<SyncManagerRepository>().syncData();
    syncRepo.fold(
      (l) {
        _showToast(l.message ?? "Sync data failed!");
      },
      (r) {
        _showToast("Your data has been synced");
      },
    );
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

    // _syncOnlineData();
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    isOnline = result[0] != ConnectivityResult.none;
    if (!isOnline) {
      _showToast(isOnline ? "You are online!" : "You are now offline!");
    }
    if (isOnline) _syncData();
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
            create: (context) =>
                getIt<AuthenticationBloc>()..add(ListenToEvents())),
        BlocProvider(create: (context) => getIt<ClientProfileBloc>()),
        BlocProvider(
            create: (context) =>
                getIt<SyncmanagerBloc>()..add(SyncOnlineDataEvent())),
        BlocProvider(create: (context) => getIt<ClientweightsCubit>()),
        BlocProvider(create: (context) => getIt<GetclientweightsCubit>()),
        BlocProvider(create: (context) => getIt<GetworkoutplanCubit>()),
        BlocProvider(create: (context) => getIt<TrainerProfileBloc>()),
        BlocProvider(
            create: (context) => getIt<GetexercisesCubit>()..getExercises()),
        BlocProvider(create: (context) => getIt<WorkoutManagementBloc>()
            ..add(
              GetWorkoutPlansEvent(),
            ),
            ),
        BlocProvider(create: (context) => getIt<WorkoutHistoryBloc>()),
      ],
      child: localizations,
    );
  }
}
