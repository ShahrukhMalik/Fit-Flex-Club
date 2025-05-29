import 'package:fit_flex_club/src/core/common/widgets/fit_flex_loader_page.dart';
import 'package:fit_flex_club/src/core/common/widgets/transition_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_forgot_password_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_landing_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_log_in_page.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_sign_up_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_announcements_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_personalized_notification_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_post_announcments_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_reactions_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_select_clients_page.dart';
import 'package:fit_flex_club/src/features/broadcast/presentation/pages/fit_flex_trainer_hub_page.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_chat_window_page.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_client_chat_window_page.dart';
import 'package:fit_flex_club/src/features/chat/presentation/pages/fit_flex_one_to_one_chat_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_assigned_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_workout_history_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_age_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_gender_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_height_page.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/pages/fit_flex_client_profile_select_weight_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_client_dashboard_page.dart';
import 'package:fit_flex_club/src/features/dashboard/presentation/pages/fit_flex_trainer_dashboard_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_client_details_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_history_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_profile_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_workout_page.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_diet_plan_page.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_add_exercise_bottom_sheet.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_exercise_picker_widget.dart';
import 'package:fit_flex_club/src/features/workout_tracking/presentation/pages/fit_flex_workout_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: '/',
    routes: [
      // Auth and onboarding routes
      GoRoute(
        path: '/',
        redirect: (context, state) => FitFlexAuthLandingPage.route,
      ),
      GoRoute(
        path: FitFlexAuthLandingPage.route,
        pageBuilder: (context, state) {
          final String flag = state.pathParameters['flag']!;
          return TransitionPage(
            key: state.pageKey,
            child: FitFlexAuthLandingPage(
              isUserActive: flag == '0' ? false : null,
            ),
          );
        },
        routes: [
          GoRoute(
            path: FitFlexAuthLogInPage.route,
            pageBuilder: (context, state) => TransitionPage(
              key: state.pageKey,
              child: const FitFlexAuthLogInPage(),
            ),
            routes: [
              GoRoute(
                path: FitFlexAuthForgotPasswordPage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: const FitFlexAuthForgotPasswordPage(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: FitFlexAuthSignUpPage.route,
            pageBuilder: (context, state) => TransitionPage(
              key: state.pageKey,
              child: const FitFlexAuthSignUpPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: FitFlexLoaderPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexLoaderPage(),
        ),
      ),

      // Profile creation flow
      GoRoute(
        path: FitFlexClientProfileSelectGenderPage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClientProfileSelectGenderPage(),
        ),
        routes: [
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
            routes: [
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
                routes: [
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
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: FitFlexClubSelectExercisePage.route,
        pageBuilder: (context, state) => TransitionPage(
          key: state.pageKey,
          child: const FitFlexClubSelectExercisePage(),
        ),
      ),

      // Trainer app shell route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final route = state.fullPath;
          final showBottomNavBar = (route == FitFlexTrainerProfilePage.route) ||
              (route == FitFlexTrainerWorkoutPage.route) ||
              (route == FitFlexTrainerHubPage.route);
          return FitFlexTrainerDashboardPage(
            navigationShell: navigationShell,
            showBottomNavBar: showBottomNavBar,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey:
                GlobalKey<NavigatorState>(debugLabel: 'trainerProfile'),
            routes: [
              GoRoute(
                path: FitFlexTrainerProfilePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexTrainerProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: FitFlexTrainerClientDetailsPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexTrainerClientDetailsPage(
                          client: extraData?['client'],
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: FitFlexClubCreateWorkoutPlanPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexClubCreateWorkoutPlanPage(
                              showDietPlan: true,
                              update: extraData?['updateData'] ?? false,
                              workoutPlanModel: extraData?['workoutPlan'],
                              clientEntity: extraData?['clientEntity'],
                              exercises: extraData?['exercises'],
                            ),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: FitFlexAddExercisePage.route,
                            pageBuilder: (context, state) {
                              final extraData =
                                  state.extra as Map<String, dynamic>?;
                              return TransitionPage(
                                key: state.pageKey,
                                child: FitFlexAddExercisePage(
                                  editExercise: extraData?['editExercise'],
                                  dayId: extraData?['dayId'],
                                  reps: extraData?['reps'],
                                  duration: extraData?['duration'],
                                  exercise: extraData?['exercise'],
                                  weight: extraData?['weight'],
                                  sets: extraData?['sets'],
                                ),
                              );
                            },
                          ),
                          GoRoute(
                            path: FitFlexDietPlanPage.route,
                            pageBuilder: (context, state) {
                              final extraData =
                                  state.extra as Map<String, dynamic>?;
                              return TransitionPage(
                                key: state.pageKey,
                                child: FitFlexDietPlanPage(
                                  dietPlan: extraData?['dietPlan'],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      GoRoute(
                        path: FitFlexTrainerHistoryPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexTrainerHistoryPage(
                              histories: extraData?['histories'] ?? [],
                              client: extraData?['client'],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey:
                GlobalKey<NavigatorState>(debugLabel: 'trainerWorkout'),
            routes: [
              GoRoute(
                path: FitFlexTrainerWorkoutPage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexTrainerWorkoutPage(),
                ),
                routes: [
                  GoRoute(
                    path: FitFlexClubCreateWorkoutPlanPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexClubCreateWorkoutPlanPage(
                          update: extraData?['updateData'] ?? false,
                          workoutPlanModel: extraData?['workoutPlan'],
                          clientEntity: extraData?['clientEntity'],
                          exercises: extraData?['exercises'],
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: FitFlexDietPlanPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexDietPlanPage(
                              dietPlan: extraData?['dietPlan'],
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: FitFlexAddExercisePage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexAddExercisePage(
                              editExercise: extraData?['editExercise'],
                              dayId: extraData?['dayId'],
                              reps: extraData?['reps'],
                              duration: extraData?['duration'],
                              exercise: extraData?['exercise'],
                              weight: extraData?['weight'],
                              sets: extraData?['sets'],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'trainerHub'),
            routes: [
              GoRoute(
                path: FitFlexTrainerHubPage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexTrainerHubPage(),
                ),
                routes: [
                  GoRoute(
                    path: FitFlexPersonalizedNotificationPage.route,
                    pageBuilder: (context, state) => TransitionPage(
                      key: state.pageKey,
                      child: FitFlexPersonalizedNotificationPage(),
                    ),
                    routes: [
                      GoRoute(
                        path: FitFlexSelectClientsPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexSelectClientsPage(
                              selectedClients: extraData?['selectedClients'],
                              // currentChats: extraData?['currentChats'],
                            ),
                          );
                        },
                        routes: [],
                      )
                    ],
                  ),
                  GoRoute(
                    path: FitFlexAnnouncementsPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexAnnouncementsPage(
                          isTrainer: true,
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        routes: [],
                        path: FitFlexPostAnnouncmentsPage.route,
                        pageBuilder: (context, state) => TransitionPage(
                          key: state.pageKey,
                          child: FitFlexPostAnnouncmentsPage(),
                        ),
                      ),
                      GoRoute(
                        routes: [],
                        path: FitFlexReactionsPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexReactionsPage(
                              key: UniqueKey(),
                              announcementId: extraData?['announcementId'],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  GoRoute(
                    path: FitFlexOneToOneChatPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexOneToOneChatPage(),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: FitFlexChatWindowPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexChatWindowPage(
                              key: UniqueKey(),
                              chat: extraData?['chat'],
                            ),
                          );
                        },
                        routes: [],
                      ),
                      GoRoute(
                        path: FitFlexSelectClientsPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexSelectClientsPage(
                              selectedClients: extraData?['selectedClients'],
                              forChat: extraData?['forChat'],
                              currentChats: extraData?['currentChats'],
                            ),
                          );
                        },
                        routes: [],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      // Client app shell route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final route = state.fullPath;
          final showBottomNavBar = (route == FitFlexClientProfilePage.route) ||
              (route == FitFlexClientWorkoutHistoryPage.route ||
                  (route == FitFlexAnnouncementsPage.clientRoute)) ||
              route!.contains(FitFlexClientChatWindowPage.route);
          return FitFlexClientDashboardPage(
            navigationShell: navigationShell,
            showBottomNavBar: showBottomNavBar,
            showBlurEffectBottomNavbar:
                !(route == FitFlexClientProfilePage.route),
            showFloatingAction: (route == FitFlexClientProfilePage.route ||
                (route == FitFlexAnnouncementsPage.clientRoute) ||
                route == FitFlexClientWorkoutHistoryPage.route),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey:
                GlobalKey<NavigatorState>(debugLabel: 'clientProfile'),
            routes: [
              GoRoute(
                path: FitFlexClientProfilePage.route,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexClientProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: FitFlexClientChatWindowPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexClientChatWindowPage(
                          key: UniqueKey(),
                          chat: extraData?['chat'],
                        ),
                      );
                    },
                    routes: [],
                  ),
                  GoRoute(
                    path: FitFlexClientAssignedWorkoutPlanPage.route,
                    routes: [
                      GoRoute(
                        path: FitFlexDietPlanPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexDietPlanPage(
                              dietPlan: extraData?['dietPlan'],
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: FitFlexWorkoutTrackerPage.route,
                        pageBuilder: (context, state) {
                          final extraData =
                              state.extra as Map<String, dynamic>?;
                          return TransitionPage(
                            key: state.pageKey,
                            child: FitFlexWorkoutTrackerPage(
                              exercise: extraData?['exercise'],
                              workoutPlan: extraData?['workoutPlan'],
                              week: extraData?['week'],
                              day: extraData?['day'],
                            ),
                          );
                        },
                      ),
                    ],
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexClientAssignedWorkoutPlanPage(
                          workoutPlanModel: extraData?['workoutPlan'],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey:
                GlobalKey<NavigatorState>(debugLabel: 'clientHistory'),
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
            navigatorKey:
                GlobalKey<NavigatorState>(debugLabel: 'clientAnnounceMents'),
            routes: [
              GoRoute(
                routes: [
                  GoRoute(
                    routes: [],
                    path: FitFlexReactionsPage.route,
                    pageBuilder: (context, state) {
                      final extraData = state.extra as Map<String, dynamic>?;
                      return TransitionPage(
                        key: state.pageKey,
                        child: FitFlexReactionsPage(
                          announcementId: extraData?['announcementId'],
                        ),
                      );
                    },
                  ),
                ],
                path: FitFlexAnnouncementsPage.clientRoute,
                pageBuilder: (context, state) => TransitionPage(
                  key: state.pageKey,
                  child: FitFlexAnnouncementsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // Handle loading state
      if (appState is AuthenticationLoading ||
          appState is AuthenticationInitial) {
        // if (Platform.isAndroid)
        return FitFlexLoaderPage.route;
      }
      if (appState is AuthenticationError) {
        Fluttertoast.showToast(
          msg: appState.failures.message ?? "Something went wrong",
        );
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
                  // if (false) {
                  return FitFlexTrainerProfilePage.route;
                } else {
                  return FitFlexClientProfilePage.route;
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
