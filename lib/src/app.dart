
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_flex_club/src/core/common/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///Widget that configures the application
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

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
              getIt<AuthenticationBloc>()..add(ListenToEvents()),
        ),
        BlocProvider(create: (context) => getIt<ClientProfileBloc>()),
        // BlocProvider(
        //     create: (context) => getIt<ListenBloc>()..add(ListenToEvent())),
        BlocProvider(create: (context) => getIt<TrainerProfileBloc>()),
        BlocProvider(
          create: (context) => getIt<WorkoutManagementBloc>()
            ..add(
              GetExercisesEvent(),
            )
            ..add(
              GetWorkoutPlansForClientEvent(
                clientId: getIt<FirebaseAuth>().currentUser!.uid,
              ),
            ),
        ),
        BlocProvider(create: (context) => getIt<WorkoutHistoryBloc>()),
      ],
      child: localizations,
    );
  }
}
