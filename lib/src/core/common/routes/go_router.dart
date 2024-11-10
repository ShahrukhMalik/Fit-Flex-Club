import 'package:fit_flex_club/src/core/common/widgets/transition_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

GoRouter goRouter() {
  return GoRouter(
    errorPageBuilder: (context, state) => TransitionPage(
      key: state.pageKey,
      child: const Placeholder(),
    ),
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => FitFlexAuthLandingPage.route,
      ),
      GoRoute(
        path: FitFlexAuthLandingPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthLandingPage(),
        ),
      ),
      GoRoute(
        path: FitFlexAuthLogInPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthLogInPage(),
        ),
      ),
      GoRoute(
        path: FitFlexAuthSignUpPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthSignUpPage(),
        ),
      ),
      // GoRoute(
      //   path: LoadingPage.route,
      //   pageBuilder: (context, state) => TransitionPage(
      //     key: state.pageKey,
      //     child: const LoadingPage(),
      //   ),
      // ),
      // GoRoute(
      //   path: NetworkErrorPage.route,
      //   pageBuilder: (context, state) => TransitionPage(
      //     key: state.pageKey,
      //     child: const NetworkErrorPage(),
      //   ),
      // ),
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) => TransitionPage(
      //     key: state.pageKey,
      //     child: const HomePage(),
      //   ),
      //   routes: [
      //     GoRoute(
      //       name: 'UpdateAppointmentPage',
      //       path: 'updateAppointmentPage/:appointment',
      //       pageBuilder: (context, state) {
      //         final appointmentJson = state.pathParameters['appointment'];
      //         return TransitionPage(
      //           key: state.pageKey,
      //           child: UpdateAppointmentPage(
      //             appointment: appointmentJson != '' && appointmentJson != null
      //                 ? AppointmentEntityModel.fromJson(
      //                     json: json.decode(appointmentJson),
      //                   )
      //                 : null,
      //           ),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       name: 'UpdatePatientPage',
      //       path: 'updatePatientPage/:patient',
      //       pageBuilder: (context, state) {
      //         final patientJson = state.pathParameters['patient'];
      //         return TransitionPage(
      //           key: state.pageKey,
      //           child: UpdatePatientPage(
      //             patient: patientJson != '' && patientJson != null
      //                 ? PatientModel.fromJson(
      //                     json: json.decode(patientJson),
      //                   )
      //                 : null,
      //           ),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       name: 'PatientLogsPage',
      //       path: 'patientLogsPage/:patientLog',
      //       pageBuilder: (context, state) {
      //         final String? patientJson = state.pathParameters['patient'];
      //         return TransitionPage(
      //           key: state.pageKey,
      //           child: PatientLogsPage(
      //             patient: PatientModel.fromJson(
      //               json: json.decode(patientJson!),
      //             ),
      //           ),
      //         );
      //       },
      //     )
      //   ],
      // ),
      // GoRoute(
      //   name: 'UpdatePatientPage',
      //   path: UpdatePatientPage.fullPath,
      //   pageBuilder: (context, state) {
      //     final patientJson = state.params['patient'];
      //     return TransitionPage(
      //       key: state.pageKey,
      //       child: UpdatePatientPage(
      //         patient: patientJson != '' && patientJson != null
      //             ? PatientModel.fromJson(
      //                 json: json.decode(patientJson),
      //               )
      //             : null,
      //       ),
      //     );
      //   },
      // ),
      // GoRoute(
      //   name: 'PatientLogsPage',
      //   path: PatientLogsPage.fullPath,
      //   pageBuilder: (context, state) {
      //     final String? patientJson = state.params['patientForLogs'];
      //     return TransitionPage(
      //       key: state.pageKey,
      //       child: PatientLogsPage(
      //         patient: PatientModel.fromJson(
      //           json: json.decode(patientJson!),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: AuthLoginPage.route,
      //   pageBuilder: (context, state) => TransitionPage(
      //     key: state.pageKey,
      //     child: const AuthLoginPage(),
      //   ),
      //   routes: [
      //     GoRoute(
      //       name: 'forgotPassword',
      //       path: ':authForgotPassword',
      //       pageBuilder: (context, state) => TransitionPage(
      //         key: state.pageKey,
      //         child: const AuthForgotPasswordPage(),
      //       ),
      //     ),
      //   ],
      // ),
      // GoRoute(
      //   path: AuthWelcomePage.route,
      //   pageBuilder: (context, state) => TransitionPage(
      //     key: state.pageKey,
      //     child: const AuthWelcomePage(),
      //   ),
      // ),
    ],
    redirect: (context, state) {
      // if (routeLogicState is AppLaunchRouteLogicStateLoading ||
      //     routeLogicState is AppLaunchRouteLogicStateInitial) {
      //   return LoadingPage.route;
      // }
      // if (routeLogicState is AppLaunchRouteLogicStateComplete) {
      //   final routeLogicEntity = routeLogicState.docNoteLaunchEntity;
      //   if (!routeLogicEntity.isSignedIn &&
      //       (state.fullPath == '/' || state.path == AuthLoginPage.route)) {
      //     return AuthLoginPage.route;
      //   }
      //   if (routeLogicEntity.isSignedIn &&
      //           !routeLogicEntity.isPasswordSet &&
      //           state.fullPath == '/' ||
      //       state.path == AuthWelcomePage.route) {
      //     return AuthWelcomePage.route;
      //   }
      //   if (routeLogicEntity.isSignedIn &&
      //       routeLogicEntity.isPasswordSet &&
      //       state.fullPath == '/') {
      //     if (!routeLogicEntity.isUserActive) {
      //       return AuthLoginPage.route;
      //     } else {
      //       return HomePage.route;
      //     }
      //   }
      // }
      // // if (state.subloc == UpdatePatientPage.location) {
      // //   return UpdatePatientPage.fullPath;
      // // }
      // // if (state.subloc == PatientLogsPage.location) {
      // //   return PatientLogsPage.fullPath;
      // // }
      // if (routeLogicState is AppLaunchRouteLogicStateFailure) {
      //   final failure = routeLogicState.failures;
      //   if (failure is NetworkFailure) {
      //     return NetworkErrorPage.route;
      //   } else {
      //     return NetworkErrorPage.route;
      //   }
      // }
      // return null;
      // // return state.location;
    },
  );
}
