import 'package:fit_flex_club/src/core/common/routes/go_router.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
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
          listener: (context, state) {
            // if (state is AuthenticationComplete) {
            //   final entity = state.entity;

            //   if (entity?.isUserActive == null) {
            //   } else {
            //     final bool isUserActive = entity!.isUserActive ?? true;
            //     if (!isUserActive) {
            //       PlatformDialog.showAlertDialog(
            //         context: context,
            //         title: "Account Inactive",
            //         message: "Your Account is not active!",
            //       );
            //     }
            //   }
            // }
          },
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
              getIt<AuthenticationBloc>()..add(AuthenticateUserEvent()),
        ),
        BlocProvider(create: (context) => getIt<ClientProfileBloc>()
            // ..add(CheckIfUserActive())
            // ..add(CheckClientProfileExist()),
            // lazy: false,
            ),
      ],
      child: localizations,
    );
  }
}
