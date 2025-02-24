import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/getexercises/getexercises_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_auto_scroll_tabs_widget.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_auto_scrollweeks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid_v4/uuid_v4.dart';

class FitFlexClientAssignedWorkoutPlanPage extends StatefulWidget {
  static const String route = "assigned-workout-plan";
  final WorkoutPlanModel? workoutPlanModel;
  const FitFlexClientAssignedWorkoutPlanPage({
    super.key,
    this.workoutPlanModel,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FitFlexClientAssignedWorkoutPlanPageState createState() =>
      _FitFlexClientAssignedWorkoutPlanPageState();
}

class _FitFlexClientAssignedWorkoutPlanPageState
    extends State<FitFlexClientAssignedWorkoutPlanPage>
    with TickerProviderStateMixin {
  bool isProgramEdited = false;
  late ValueNotifier<WorkoutPlanModel?> _workoutPlanBp = ValueNotifier(
    null,
  );
  final ValueNotifier<List<DayModel>> _days = ValueNotifier([]);
  final ValueNotifier<List<WeekModel>> _weeks = ValueNotifier([]);
  final ValueNotifier<List<ExerciseModel>> _exercises = ValueNotifier([]);
  final ValueNotifier<DayModel?> _currentDay = ValueNotifier(null);
  final ValueNotifier<WeekModel?> _currentWeek = ValueNotifier(null);

  final TextEditingController workoutProgramNameController =
      TextEditingController();

  // Future _showExerciseSetSheet(
  //   BuildContext context, [
  //   ExerciseBpModel? exercise,
  //   ExerciseModel? editExercise,
  // ]) {
  //   // if (Platform.isIOS) {
  //   return PlatformDialog.showCustomDialog(
  //     barrierDismissible: false,
  //     actions: [],
  //     context: context,
  //     title: 'Workout Plan',
  //     content: AddExerciseBottomSheetWidget(
  //       editExercise: editExercise,
  //       dayId: _currentDay.value!.id,
  //       reps: exercise?.parameters?['reps'] ??
  //           editExercise?.parameters?['reps'] ??
  //           false,
  //       duration: exercise?.parameters?['duration'] ??
  //           editExercise?.parameters?['duration'] ??
  //           false,
  //       exercise: exercise,
  //       sets: exercise?.parameters?['sets'] ??
  //           editExercise?.parameters?['sets'] ??
  //           false,
  //       weight: exercise?.parameters?['weight'] ??
  //           editExercise?.parameters?['weight'] ??
  //           false,
  //     ),
  //   );
  // }

  void _updateDaysForCurrentWeek({
    required String weekId,
  }) {
    final getCurrentWeek = _weeks.value.firstWhere((week) => week.id == weekId);
    final getDaysforCurrentWeek = getCurrentWeek.days;
    _days.value = getDaysforCurrentWeek;
    _currentDay.value = _days.value.first;
  }

  void _updateExerciseListView({
    required String weekId,
    String? dayId,
  }) {
    final getCurrentWeek = _weeks.value.firstWhere((week) => week.id == weekId);
    final getCurrentDay = getCurrentWeek.days.firstWhere(
      (day) => dayId != null ? day.id == dayId : day.dayNumber == 1,
    );
    final getExercisesForCurrentDay = getCurrentDay.exercises;
    _exercises.value = getExercisesForCurrentDay
        .map(
          (e) => e,
        )
        .toList();
  }

  int selectedWeek = 0;
  late TabController _tabController;
  final int _currentTabIndex = 0;

  _createWorkOutBpObject() {
    final workoutPlanModel = widget.workoutPlanModel;
    if (workoutPlanModel == null) {
      final workoutPlanId = UUIDv4().toString();
      final weeks = List<WeekModel>.generate(
        5,
        (index) {
          final weekId = UUIDv4().toString();
          final days = List<DayModel>.generate(
            5,
            (dayIndex) {
              return DayModel(
                weekId: weekId,
                dayNumber: dayIndex + 1,
                exercises: [],
                id: UUIDv4().toString(),
              );
            },
          );
          return WeekModel(
            workoutPlanId: workoutPlanId,
            weekNumber: index + 1,
            days: days,
            id: weekId,
          );
        },
      );
      _weeks.value = weeks;
      _workoutPlanBp = ValueNotifier(
        WorkoutPlanModel(
          name: '',
          weeks: weeks,
          uid: workoutPlanId,
          dietPlanBase64: null
        ),
      );
    } else {
      _workoutPlanBp.value = workoutPlanModel;
      _weeks.value = workoutPlanModel.weeks;
    }
  }

  _initialzeWorkoutPlan() {
    _weeks.value = _workoutPlanBp.value!.weeks;
    _currentWeek.value = _weeks.value.firstWhere(
      (element) => element.weekNumber == 1,
    );
    _currentDay.value = _currentWeek.value?.days.firstWhere(
      (element) => element.dayNumber == 1,
    );
    _days.value = _currentWeek.value!.days;
    _exercises.value = _weeks.value
        .firstWhere(
          (element) => element.weekNumber == 1,
        )
        .days
        .firstWhere(
          (element) => element.dayNumber == 1,
        )
        .exercises;
    _tabController = TabController(length: 6, vsync: this);
    workoutProgramNameController.addListener(
      () {
        _workoutPlanBp.value = _workoutPlanBp.value?.copyWith(
          name: workoutProgramNameController.text,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<GetexercisesCubit>().getExercises().then(
      (value) {
        context.read<WorkoutManagementBloc>().add(
              GetWorkoutPlansForClientEvent(
                clientId: getIt<FirebaseAuth>().currentUser!.uid,
              ),
            );
      },
    );

    // context.read()
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (context.canPop()) context.pop();
      },
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: PlatformAppbar.basicAppBar(
            title: "Workout Plan",
            context: context,
            backgroundColor: colorScheme.onPrimaryContainer,
            onLeadingPressed: () => context.go(FitFlexClientProfilePage.route),
          ),
          body: BlocListener<WorkoutManagementBloc, WorkoutManagementState>(
            listener: (context, state) {
              if (state is GetWorkoutPlansForClientComplete) {
                _workoutPlanBp.value = state.workoutPlan!;
                _initialzeWorkoutPlan();
              }
              // if (state is UpdateWorkoutLoading) {
              //   PlatformDialog.showLoadingDialog(
              //     context: context,
              //     message: "Processing your request...",
              //   );
              // }
              // if (state is WorkoutManagementLoading) {
              //   PlatformDialog.showLoadingDialog(
              //     context: context,
              //     message: "Processing your request...",
              //   );
              // }

              // if (state is WorkoutManagementError) {
              //   PlatformDialog.showAlertDialog(
              //     context: context,
              //     title: "Add Workout Plan",
              //     message: state.failures.message ?? "Something Went Wrong!",
              //     onConfirm: () => Navigator.pop(context),
              //   );
              // }

              // if (state is CreateWorkoutComplete) {
              //   PlatformDialog.showAlertDialog(
              //     context: context,
              //     title: "Add Workout Plan",
              //     message: "Workout Plan Created Successfully!",
              //     onConfirm: () {
              //       context.go(FitFlexTrainerWorkoutPage.route);
              //       context
              //           .read<WorkoutManagementBloc>()
              //           .add(GetWorkoutPlansEvent());
              //     },
              //   );
              // }
              // if (state is UpdateWorkoutComplete) {
              //   PlatformDialog.showAlertDialog(
              //     context: context,
              //     title: "Add Workout Plan",
              //     message: "Workout Plan updated Successfully!",
              //     onConfirm: () {
              //       context.go(FitFlexTrainerWorkoutPage.route);
              //       context
              //           .read<WorkoutManagementBloc>()
              //           .add(GetWorkoutPlansEvent());
              //     },
              //   );
              // }

              // if (state is UpdateAssignedWorkoutComplete) {
              //   PlatformDialog.showAlertDialog(
              //     context: context,
              //     title: "Add Workout Plan",
              //     message: "Workout Plan updated Successfully!",
              //     onConfirm: () {
              //       context.go(
              //         FitFlexTrainerClientDetailsPage.route,
              //         extra: {
              //           'client': widget.clientEntity,
              //         },
              //       );
              //     },
              //   );
              // }
            },
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _workoutPlanBp,
        builder: (context, workoutPlan, _) {
          if (workoutPlan != null) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // Workout Program Header
                      ValueListenableBuilder(
                        valueListenable: _workoutPlanBp,
                        builder: (context, workoutPlan, _) {
                          return workoutPlan!.name.isEmpty
                              ? SizedBox()
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    border: Border.all(
                                      width: 2,
                                      color: globalColorScheme.primary,
                                    ),
                                  ),
                                  child: Text(
                                    workoutPlan.name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: globalColorScheme
                                              .onPrimaryContainer,
                                        ),
                                  ),
                                );
                        },
                      ),

                      // Week Selector
                      AutoScrollWeeksWidget(
                        weeks: _weeks,
                        currentWeek: _currentWeek,
                        updateDays: _updateDaysForCurrentWeek,
                        updateExercises: _updateExerciseListView,
                      ),

                      // Day Tabs
                      ValueListenableBuilder(
                        valueListenable: _days,
                        builder: (context, days, _) {
                          return AutoScrollTabsWidget(
                            onEditSets: (exercise) {
                              final existingWeeks = _weeks.value;
                              // _weeks.value = existingWeeks.map((w) {
                              //   return w.days.map((d) {
                              //     return d.exercises.map((e) {
                              //       if (e.id == exercise.id) {
                              //         return e.copyWith(
                              //           completed: exercise.completed,
                              //         );
                              //       }
                              //       return e;
                              //     }).toList();
                              //   }).toList();
                              // }).toList();

                              _weeks.value = existingWeeks.map(
                                (w) {
                                  return w.copyWith(
                                    days: w.days
                                        .map(
                                          (d) => d.copyWith(
                                            exercises: d.exercises.map((e) {
                                              if (e.id == exercise.id) {
                                                return e.copyWith(
                                                  completed: exercise.completed,
                                                );
                                              }
                                              return e;
                                            }).toList(),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ).toList();
                              final existingExercises = _exercises.value;
                              _exercises.value = existingExercises.map(
                                (e) {
                                  if (e.id == exercise.id) {
                                    return e.copyWith(
                                      completed: exercise.completed,
                                    );
                                  }
                                  return e;
                                },
                              ).toList();
                            },
                            workoutPlan: _workoutPlanBp.value,
                            isClientSideView: true,
                            onDrag: (editExercise, edit, delete) => {},
                            key: UniqueKey(),
                            currentDay: _currentDay,
                            currentWeek: _currentWeek,
                            days: _days,
                            exercises: _exercises,
                            weeks: _weeks,
                            onDayTap: (index) {
                              _updateDaysForCurrentWeek(
                                weekId: _currentWeek.value!.id,
                              );
                              _updateExerciseListView(
                                weekId: _currentWeek.value!.id,
                                dayId: _days.value[index].id,
                              );
                              _currentDay.value = _days.value[index];
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: PlatformButton().buildButton(
                //     context: context,
                //     type: ButtonType.primary,
                //     backgroundColor: globalColorScheme.primaryContainer,
                //     foregroundColor: globalColorScheme.surface,
                //     textStyle: TextStyle(
                //       color: globalColorScheme.surface,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     text: "Submit",
                //     onPressed: () => _onSubmit(ConcludeEvent.submit),
                //   )!,
                // ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  8,
                  (index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: PlatformLoader().buildLoader(
                      type: LoaderType.shimmer,
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
