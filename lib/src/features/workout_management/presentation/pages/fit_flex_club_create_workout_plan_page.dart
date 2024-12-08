import 'dart:async';
import 'dart:math';

import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_workout_page.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/day_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/set_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/datasources/local/tables/week_table.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/day_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_add_exercise_bottom_sheet.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_auto_scroll_tabs_widget.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_auto_scrollweeks_widget.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_exercise_picker_widget.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_name_bottom_sheet_android.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_name_bottom_sheet_ios_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:uuid_v4/uuid_v4.dart';

import 'package:flutter/material.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

class FitFlexClubCreateWorkoutPlanPage extends StatefulWidget {
  static const String route = "/fit-club-create-workout-plan";
  const FitFlexClubCreateWorkoutPlanPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FitFlexClubCreateWorkoutPlanPageState createState() =>
      _FitFlexClubCreateWorkoutPlanPageState();
}

class _FitFlexClubCreateWorkoutPlanPageState
    extends State<FitFlexClubCreateWorkoutPlanPage>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<WorkoutPlanModel> _workoutPlanBp;
  final ValueNotifier<List<DayModel>> _days = ValueNotifier([]);
  final ValueNotifier<List<WeekModel>> _weeks = ValueNotifier([]);
  final ValueNotifier<List<ExerciseModel>> _exercises = ValueNotifier([]);
  final ValueNotifier<DayModel?> _currentDay = ValueNotifier(null);
  final ValueNotifier<WeekModel?> _currentWeek = ValueNotifier(null);

  final TextEditingController workoutProgramNameController =
      TextEditingController();

  void _show(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CupertinoWorkoutBottomSheet(
            controller: workoutProgramNameController,
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return MaterialWorkoutBottomSheet(
            controller: workoutProgramNameController,
          );
        },
      );
    }
  }

  Future _showExerciseSetSheet(
    BuildContext context, [
    ExerciseBpModel? exercise,
    ExerciseModel? editExercise,
  ]) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return AddExerciseBottomSheetWidget(
            editExercise: editExercise,
            dayId: _currentDay.value!.id,
            reps: exercise?.parameters?['reps'] ??
                editExercise?.parameters?['reps'] ??
                false,
            duration: exercise?.parameters?['duration'] ??
                editExercise?.parameters?['duration'] ??
                false,
            exercise: exercise,
            sets: exercise?.parameters?['sets'] ??
                editExercise?.parameters?['sets'] ??
                false,
            weight: exercise?.parameters?['weight'] ??
                editExercise?.parameters?['weight'] ??
                false,
          );
        },
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddExerciseBottomSheetWidget(
            editExercise: editExercise,
            dayId: _currentDay.value!.id,
            reps: exercise?.parameters?['reps'] ??
                editExercise?.parameters?['reps'] ??
                false,
            duration: exercise?.parameters?['duration'] ??
                editExercise?.parameters?['duration'] ??
                false,
            exercise: exercise,
            sets: exercise?.parameters?['sets'] ??
                editExercise?.parameters?['sets'] ??
                false,
            weight: exercise?.parameters?['weight'] ??
                editExercise?.parameters?['weight'] ??
                false,
          );
        },
      );
    }
  }

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
  int _currentTabIndex = 0;

  Future _showExerciseSheet(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SafeArea(
            child: BlocBuilder<WorkoutManagementBloc, WorkoutManagementState>(
              builder: (context, state) {
                // if (state is SubjectFailed) {
                //   return ErrorOutput(message: state.message);
                // }
                if (state is GetExercisesComplete) {
                  return CupertinoScrollbar(
                    child: ExercisePickerBottomSheet(
                      exercises: state.exercises,
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          );
        },
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: BlocBuilder<WorkoutManagementBloc, WorkoutManagementState>(
              builder: (context, state) {
                // if (state is SubjectFailed) {
                //   return ErrorOutput(message: state.message);
                // }
                if (state is GetExercisesComplete) {
                  return ExercisePickerBottomSheet(
                    exercises: state.exercises,
                  );
                }
                return SizedBox();
              },
            ),
          );
        },
      );
    }
  }

  _createWorkOutBpObject() {
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
        totalExercises: 0,
        muscleBuildingExercises: 0,
        cardioExercises: 0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _createWorkOutBpObject();
    // _showAddNameDialog();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _show(context);
      },
    );
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
        _workoutPlanBp.value = _workoutPlanBp.value.copyWith(
          name: workoutProgramNameController.text,
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _updateExercises(
    ExerciseModel exercise, [
    bool edit = false,
    bool delete = false,
  ]) async {
    final day = _currentDay.value!;

    final week = _weeks.value.firstWhere(
      (element) => element.id == day.weekId,
    );

    final deletedExeciseList = day.exercises
        .where(
          (element) => element.id != exercise.id,
        )
        .toList();

    final newExerciseList = day.exercises.map(
      (e) {
        if (e.id == exercise.id) {
          return e.copyWith(sets: exercise.sets);
        } else {
          return e;
        }
      },
    ).toList();

    if (!edit) newExerciseList.add(exercise);

    final updatedDay = day.copyWith(
      exercises: delete ? deletedExeciseList : newExerciseList,
    );

    _currentDay.value = updatedDay;

    final updatedWeeksList = _weeks.value.map(
      (weekElement) {
        if (weekElement.id == week.id) {
          return week.copyWith(
            days: week.days.map(
              (dayElement) {
                if (dayElement.id == updatedDay.id) {
                  return updatedDay;
                }
                return dayElement;
              },
            ).toList(),
          );
        }
        return weekElement;
      },
    ).toList();
    _weeks.value = updatedWeeksList;
    await Future.delayed(Duration(seconds: 0));
    _updateExerciseListView(
      weekId: week.id,
      dayId: day.id,
    );
  }

  bool _isFirstWeekValid(List<WeekModel> weeks) {
    if (weeks.isEmpty) {
      return false; // No weeks available.
    }

    final firstWeek = weeks.first;

    for (final day in firstWeek.days) {
      if (day.exercises.isEmpty) {
        return false; // Found a day in the first week with no exercises.
      }
    }
    return true; // All days in the first week have at least one exercise.
  }

  bool _areAllDaysPopulatedWithExercises(List<WeekModel> weeks) {
    for (final week in weeks) {
      for (final day in week.days) {
        if (day.exercises.isEmpty) {
          return false; // Found a day with no exercises.
        }
      }
    }
    return true; // All days have at least one exercise.
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;

    return PopScope(
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            heroTag: 'addWorkout',
            splashColor: globalColorScheme.tertiary,
            backgroundColor: globalColorScheme.primaryContainer,
            onPressed: () async {
              final result = await _showExerciseSheet(context);
              if (result != null) {
                // ignore: use_build_context_synchronously
                if (result != null) {
                  _showExerciseSetSheet(context, result).then(
                    (value) async {
                      await _updateExercises(
                        value,
                      );
                    },
                  );
                }
              }
            },
            child: Icon(
              Icons.add,
              color: globalColorScheme.surface,
            ),
          ),
          appBar: PlatformAppbar.basicAppBar(
            title: "Workout Plan",
            context: context,
            backgroundColor: colorScheme.onPrimaryContainer,
            onLeadingPressed: () {
              final bool isFirstWeekIsComplete =
                  _isFirstWeekValid(_weeks.value);

              if (isFirstWeekIsComplete) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Add Workout Plan",
                  message:
                      "You haven't added exercises for all the weeks, would you like to continue with 1st week program for all other weeks. If you cancel your progress will be lost",
                  cancelText: 'Cancel',
                  confirmText: 'Continue',
                );
              } else {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Add Workout Plan",
                  message:
                      "You haven't completed setting up your workout program, if you continue your progress will be lost.",
                  cancelText: 'Cancel',
                  confirmText: 'Continue',
                  onConfirm: () => context.go(FitFlexTrainerWorkoutPage.route),
                );
              }
            },
          ),
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              // Workout Program Header
              ValueListenableBuilder(
                valueListenable: _workoutPlanBp,
                builder: (context, workoutPlan, _) {
                  return workoutPlan.name.isEmpty
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
                                  color: globalColorScheme.onPrimaryContainer,
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
                    onDrag: (editExercise, edit, delete) => {
                      if (delete)
                        _updateExercises(editExercise, edit, delete)
                      else
                        _showExerciseSetSheet(context, null, editExercise).then(
                          (value) {
                            if (value != null) {
                              _updateExercises(value, edit, delete);
                            }
                          },
                        )
                    },
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
        Padding(
          padding: const EdgeInsets.all(10),
          child: PlatformButton().buildButton(
            context: context,
            type: ButtonType.primary,
            backgroundColor: globalColorScheme.primaryContainer,
            foregroundColor: globalColorScheme.surface,
            textStyle: TextStyle(
              color: globalColorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
            text: "Submit",
            onPressed: () {
              final bool isFirstWeekIsComplete =
                  _isFirstWeekValid(_weeks.value);

              if (isFirstWeekIsComplete) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Add Workout Plan",
                  message:
                      "You haven't added exercises for all the weeks, would you like to continue with 1st week program for all other weeks. If you cancel your progress will be lost",
                  cancelText: 'Cancel',
                  confirmText: 'Continue',
                );
              } else {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Add Workout Plan",
                  message:
                      "You haven't completed setting up your workout program, would you like to continue with the same ?",
                  cancelText: 'No',
                  confirmText: 'Yes',
                  onCancel: () => context.go(FitFlexTrainerWorkoutPage.route),
                
                );
              }
            },
          )!,
        ),
      ],
    );
  }
}
