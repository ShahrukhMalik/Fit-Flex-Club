import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/widgets/transition_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_forgot_password_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_dashboard_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter(appState) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => FitFlexAuthLandingPage.route,
      ),
      // GoRoute(
      //   path: '/reset_password_email_sent',
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: Scaffold(
      //         body: Stack(
      //           children: [
      //             Positioned.fill(
      //               child: Image.asset(
      //                 'assets/images/fit_flex_image.png',
      //                 fit: BoxFit.cover,
      //                 alignment: Alignment.center,
      //               ),
      //             ),
      //             CupertinoAlertDialog(
      //               title: const Text('Forgot Password'),
      //               content: const Text('Kindly check your email inbox'),
      //               actions: [
      //                 TextButton(
      //                   onPressed: () => context.go('/'),
      //                   child: const Text('Close'),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       barrierDismissible: true,
      //       barrierColor: Colors.black54,
      //       opaque: false,
      //       transitionDuration: const Duration(milliseconds: 200),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //         return FadeTransition(
      //           opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
      //           child: child,
      //         );
      //       },
      //     );
      //   },
      // ),
      GoRoute(
        path: FitFlexClientProfileSelectGenderPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClientProfileSelectGenderPage(),
        ),
      ),
      GoRoute(
        path: FitFlexAuthForgotPasswordPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthForgotPasswordPage(),
        ),
      ),
      GoRoute(
        path: FitFlexDashboardPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexDashboardPage(),
        ),
      ),
      GoRoute(
        path: FitFlexClientProfileSelectAgePage.route,
        pageBuilder: (context, state) {
          String gender = "";
          if (state.extra != null) {
            gender =
                (state.extra as Map<String, dynamic>)['gender'] ?? "Unknown";
          }

          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectAgePage(
              gender: gender,
            ),
          );
        },
      ),
      GoRoute(
        path: FitFlexClientProfileSelectWeightPage.route,
        pageBuilder: (context, state) {
          String gender = "";
          String age = "";
          if (state.extra != null && state.extra is Map<String, dynamic>) {
            final Map<String, dynamic> extraData =
                state.extra! as Map<String, dynamic>;
            gender = extraData['gender'] ?? "Unknown";
            age = extraData['age'] ?? "Unknown";
          }

          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectWeightPage(
              gender: gender,
              age: age,
            ),
          );
        },
      ),
      GoRoute(
        path: FitFlexClientProfileSelectHeightPage.route,
        pageBuilder: (context, state) {
          String gender = "";
          String age = "";
          String weight = "";
          String weightUnit = "";
          if (state.extra != null && state.extra is Map<String, dynamic>) {
            final Map<String, dynamic> extraData =
                state.extra! as Map<String, dynamic>;
            gender = extraData['gender'] ?? "Unknown";
            age = extraData['age'] ?? "Unknown";
            weight = extraData['weight'] ?? "Unknown";
            weightUnit = extraData['weightUnit'] ?? "Unknown";
          }

          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectHeightPage(
              gender: gender,
              age: age,
              weight: weight,
              weightUnit: weightUnit,
            ),
          );
        },
      ),
      // GoRoute(
      //   path: FitFlexAuthLandingPage.route,
      //   pageBuilder: (context, state) {
      //     final isUserInActive = state.pathParameters["flag"] == "0";
      //     return TransitionPage(
      //       key: state.pageKey,
      //       child: FitFlexAuthLandingPage(
      //         isUserActive: !isUserInActive,
      //       ),
      //     );
      //   },
      // ),
      GoRoute(
        path: FitFlexAuthLogInPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthLogInPage(),
        ),
      ),
      GoRoute(
        path: FitFlexAuthLandingPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthLandingPage(),
        ),
      ),
      GoRoute(
        path: FitFlexAuthSignUpPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthSignUpPage(),
        ),
      ),
    ],
    redirect: (context, state) {
      if (appState is AuthenticationLoading) {
        return FitFlexAuthLandingPage.route;
      }
      if (appState is AuthenticationComplete) {
        if (state.matchedLocation == '/') {
          if (appState.entity?.isLoggedIn ?? false) {
            if (appState.entity?.isUserActive ?? false) {
              if (appState.entity?.isProfileCreated ?? false) {
                return FitFlexDashboardPage.route;
              } else {
                return FitFlexClientProfileSelectGenderPage.route;
              }
            } else {
              if (appState.entity?.isUserActive != null) {
                return '/fit-flex-landing/0';
              } else {
                return null;
              }
            }
          } else {
            return FitFlexAuthLandingPage.route;
          }
        }
      }
      return state.matchedLocation;
    },
  );
}
