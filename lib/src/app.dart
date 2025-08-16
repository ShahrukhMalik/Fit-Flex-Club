import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/deleteaccount/deleteaccount_cubit.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/getgyms/getgyms_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/addcomment/addcomment_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/addreaction/addreaction_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/getemojis/getemojis_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/postannouncement/postannouncement_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/sendnotification/sendnotification_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchannouncement/watchannouncement_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchcommentsbyannouncmentid/watchcommentsbyannouncmentid_cubit.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/cubit/watchreactionsbyannouncmentid/watchreactionsbyannouncmentid_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/getchat/getchat_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/sendmessage/sendmessage_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/startchat/startchat_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/updatemessage/updatemessage_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchchatstream/watchchatstream_cubit.dart';
import 'package:fit_flex_club/src/features/chat/presentation/cubit/watchmessagesbychatid/watchmessagesbychatid_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/clientweights/clientweights_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/getclientweights/getclientweights_cubit.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/presentation/bloc/syncmanager_bloc.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/getgifurl/getgifurl_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/getworkoutplan/getworkoutplan_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/getexercises/getexercises_cubit.dart';
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
  final List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
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

  _isLoggedIn() {
    final uid = getIt<FirebaseAuth>().currentUser?.uid;
    return uid != null;
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
    } on PlatformException {
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
    if (!_isLoggedIn()) return;
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
              title: "Fit Blitz",
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
        BlocProvider(create: (context) => getIt<GetexercisesCubit>()),
        BlocProvider(create: (context) => getIt<GetgifurlCubit>()),
        BlocProvider(create: (context) => getIt<WorkoutManagementBloc>()),
        BlocProvider(create: (context) => getIt<WorkoutHistoryBloc>()),
        BlocProvider(create: (context) => getIt<SendNotificationCubit>()),
        BlocProvider(create: (context) => getIt<StartChatCubit>()),
        BlocProvider(create: (context) => getIt<GetChatCubit>()),
        BlocProvider(create: (context) => getIt<GetGymsCubit>()),
        BlocProvider(create: (context) => getIt<SendMessageCubit>()),
        BlocProvider(create: (context) => getIt<PostAnnouncementCubit>()),
        BlocProvider(create: (context) => getIt<WatchAnnouncementCubit>()),
        BlocProvider(create: (context) => getIt<UpdateMessageCubit>()),
        BlocProvider(create: (context) => getIt<WatchChatStreamCubit>()),
        BlocProvider(create: (context) => getIt<WatchMessagesbyChatIdCubit>()),
        BlocProvider(create: (context) => getIt<WatchReactionsbyAnnouncmentIdCubit>()),
        BlocProvider(create: (context) => getIt<WatchCommentsByAnnouncmentIdCubit>()),
        BlocProvider(create: (context) => getIt<AddcommentCubit>()),
        BlocProvider(create: (context) => getIt<GetEmojisCubit>()),
        BlocProvider(create: (context) => getIt<AddReactionCubit>()),
        BlocProvider(create: (context) => getIt<DeleteAccountCubit>()),
      ],
      child: localizations,
    );
  }
}
