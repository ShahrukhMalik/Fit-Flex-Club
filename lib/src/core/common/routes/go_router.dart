import 'package:fit_flex_club/src/core/common/widgets/transition_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_forgot_password_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_assigned_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_measure_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_workout_history_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_client_dashboard_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_trainer_dashboard_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ... other imports remain the same

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientProfile');
final _shellNavigatorBKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientHistory');
final _shellNavigatorCKey =
    GlobalKey<NavigatorState>(debugLabel: 'clientMeasurement');
final _shellNavigatorTPKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerProfile');
final _shellNavigatorTWKey =
    GlobalKey<NavigatorState>(debugLabel: 'trainerWorkout');

GoRouter goRouter(appState) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Auth and onboarding routes
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
        path: FitFlexClientAssignedWorkoutPlanPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClientAssignedWorkoutPlanPage(),
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
      GoRoute(
        path: FitFlexAuthForgotPasswordPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexAuthForgotPasswordPage(),
        ),
      ),

      // Profile creation flow
      GoRoute(
        path: FitFlexClientProfileSelectGenderPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClientProfileSelectGenderPage(),
        ),
      ),
      GoRoute(
        path: FitFlexClientProfileSelectAgePage.route,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectAgePage(
              gender: extraData?['gender'] ?? "Unknown",
            ),
          );
        },
      ),
      GoRoute(
        path: FitFlexClientProfileSelectWeightPage.route,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectWeightPage(
              gender: extraData?['gender'] ?? "Unknown",
              age: extraData?['age'] ?? "Unknown",
            ),
          );
        },
      ),
      GoRoute(
        path: FitFlexClientProfileSelectHeightPage.route,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return TransitionPage(
            key: state.pageKey,
            child: FitFlexClientProfileSelectHeightPage(
              gender: extraData?['gender'] ?? "Unknown",
              age: extraData?['age'] ?? "Unknown",
              weight: extraData?['weight'] ?? "Unknown",
              weightUnit: extraData?['weightUnit'] ?? "Unknown",
            ),
          );
        },
      ),
      // Trainer app shell route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return FitFlexTrainerDashboardPage(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorTPKey,
            routes: [
              GoRoute(
                path: FitFlexTrainerProfilePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexTrainerProfilePage(),
                ),
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorTWKey,
            routes: [
              GoRoute(
                path: FitFlexTrainerProfilePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexTrainerProfilePage(),
                ),
              )
            ],
          ),
        ],
      ),
      // Client app shell route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return FitFlexClientDashboardPage(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: FitFlexClientProfilePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexClientProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: 'history',
                    builder: (context, state) =>
                        const FitFlexClientWorkoutHistoryPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: FitFlexClientWorkoutHistoryPage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexClientWorkoutHistoryPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: FitFlexClientMeasurePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexClientMeasurePage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // Handle loading state
      if (appState is AuthenticationLoading) {
        return FitFlexAuthLandingPage.route;
      }

      // Handle authenticated state
      if (appState is AuthenticationComplete) {
        final user = appState.entity;

        // Redirect from root
        if (state.matchedLocation == '/') {
          if (user?.isLoggedIn == true) {
            if (user?.isUserActive == true) {
              if (user?.isProfileCreated == true) {
                if (user?.isTrainer ?? false) {
                  return FitFlexClientProfilePage.route;
                } else {
                  return FitFlexTrainerProfilePage.route;
                }
              } else {
                return FitFlexClientProfileSelectGenderPage.route;
              }
            } else {
              return '/fit-flex-landing/0';
            }
          } else {
            return FitFlexAuthLandingPage.route;
          }
        }
      }

      return null; // No redirect needed
    },
  );
}
