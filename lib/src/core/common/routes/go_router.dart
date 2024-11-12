import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/widgets/transition_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_dashboard_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter(ClientProfileState appState) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => FitFlexAuthLandingPage.route,
      ),
      GoRoute(
        path: FitFlexClientProfileSelectGenderPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClientProfileSelectGenderPage(),
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
          final String gender =
              (state.extra! as Map<String, dynamic>)['gender'] ?? "Unknown";
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
          final String gender =
              (state.extra! as Map<String, dynamic>)['gender'] ?? "Unknown";
          final String age =
              (state.extra! as Map<String, dynamic>)['age'] ?? "Unknown";
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
          final String gender =
              (state.extra! as Map<String, dynamic>)['gender'] ?? "Unknown";
          final String age =
              (state.extra! as Map<String, dynamic>)['age'] ?? "Unknown";
          final String weight =
              (state.extra! as Map<String, dynamic>)['weight'] ?? "Unknown";
          final String weightUnit =
              (state.extra! as Map<String, dynamic>)['weightUnit'] ?? "Unknown";
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
    ],
    redirect: (context, state) {
      if (appState is ClientProfileComplete) {
        if (state.matchedLocation == '/') {
          if (!appState.isUserActive!) {
            if (getIt<FirebaseAuth>().currentUser != null) {
              context.read<AuthenticationBloc>().add(
                    LogOutAuthenticationEvent(),
                  );
            }
            return FitFlexAuthLandingPage.route;
          }
          if (appState.isUserActive!) {
            return FitFlexDashboardPage.route;
          }

          if (!appState.clientProfileExist!) {
            return FitFlexClientProfileSelectGenderPage.route;
          }
        }
      }
      return FitFlexAuthLandingPage.route;
    },
  );
}
