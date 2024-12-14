import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_assigned_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_profile_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_workout_page.dart';
import 'package:fit_flex_club/src/features/workout_history/data/datasources/local/daos/workout_history_dao.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexWorkoutTrackerPage extends StatelessWidget {
  static const route = "/fit-flex-workout-tracker";
  final ExerciseModel exercise;
  final WeekModel week;
  final DayModel day;
  final WorkoutPlanModel workoutPlan;
  const FitFlexWorkoutTrackerPage({
    super.key,
    required this.exercise,
    required this.workoutPlan,
    required this.week,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Workout Plan",
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        // onLeadingPressed: () => context.go(FitFlexClientProfilePage.route),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'Video Assist Comming Soon..',
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 40,
              child: Divider(
                // indent: 10,
                thickness: 3,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: double.maxFinite,
              height: double.maxFinite,
              color: globalColorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day ${day.dayNumber}',
                    style: TextStyle(
                      color: globalColorScheme.outline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    workoutPlan.name,
                    style: TextStyle(
                        color: globalColorScheme.onSurfaceVariant,
                        // fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${exercise.name}',
                    style: TextStyle(
                      color: globalColorScheme.tertiaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  BlocListener<WorkoutManagementBloc, WorkoutManagementState>(
                    listener: (context, state) {
                      if (state is GetWorkoutPlansForClientComplete) {
                        context.go(FitFlexClientAssignedWorkoutPlanPage.route,
                            extra: {'workoutPlan': state.workoutPlan});
                      }
                      // if (state is SubjectLoading) {
                      //   showLoadingDialog(context);
                      //   return;
                      // }
                      // Navigator.of(context, rootNavigator: true).pop();
                      // if (state is SubjectFailed) {
                      //   showErrorDialog(context);
                      // }
                      // if (state is SubjectSuccess) {
                      //   showSuccessDialog(context);
                      // }
                    },
                    child: SizedBox(height: 10),
                  ),
                  BlocListener<WorkoutHistoryBloc, WorkoutHistoryState>(
                    listener: (context, state) {
                      // if (state is SubjectLoading) {
                      //   showLoadingDialog(context);
                      //   return;
                      // }
                      // Navigator.of(context, rootNavigator: true).pop();
                      // if (state is SubjectFailed) {
                      //   showErrorDialog(context);
                      // }
                      // if (state is SubjectSuccess) {
                      //   showSuccessDialog(context);
                      // }

                      if (state is LogWorkoutHistoryLoading) {
                        PlatformDialog.showLoadingDialog(
                          context: context,
                          message: "Saving your progress..",
                        );
                      }
                      if (state is LogWorkoutHistoryComplete) {
                        context.read<WorkoutManagementBloc>().add(
                              GetWorkoutPlansForClientEvent(
                                clientId:
                                    getIt<FirebaseAuth>().currentUser!.uid,
                              ),
                            );
                      }
                    },
                    child: Expanded(
                      child: SetTrakerWidget(
                        
                        onSubmit: (sets) {
                          print(sets);
                          context.read<WorkoutHistoryBloc>().add(
                                LogWorkoutHistoryEvent(
                                  sets: sets,
                                  exerciseId: exercise.id!,
                                  dayId: day.id,
                                  weekId: week.id,
                                  workoutPlanId: workoutPlan.uid,
                                ),
                              );
                        },
                        sets: exercise.sets,
                        showReps: exercise.parameters?['reps'],
                        showTime: exercise.parameters?['duration'],
                        showWeight: exercise.parameters?['weight'],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class SetTrakerWidget extends StatefulWidget {
  final List<SetModel> sets;
  final bool showWeight;
  final bool showReps;
  final bool showTime;
  final Function(List<SetModel> sets) onSubmit;
  const SetTrakerWidget({
    super.key,
    required this.sets,
    required this.showWeight,
    required this.showReps,
    required this.showTime,
    required this.onSubmit,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SetTrakerWidgetState createState() => _SetTrakerWidgetState();
}

class _SetTrakerWidgetState extends State<SetTrakerWidget> {
  final ValueNotifier<List<SetModel>?> _sets = ValueNotifier(null);

  _updateSets(SetModel set) {
    final existingSets = _sets.value;
    _sets.value = existingSets?.map(
      (e) {
        if (set.id == e.id) {
          return e.copyWith(
            actualReps: set.actualReps,
            actualTime: set.actualTime,
            actualWeight: set.actualWeight,
          );
        } else {
          return e;
        }
      },
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    _sets.value = widget.sets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _sets,
            builder: (context, sets, _) {
              return ListView.builder(
                itemCount: sets?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Set ${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: globalColorScheme.outlineVariant,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.showWeight)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Weight (in kgs)',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: globalColorScheme.surface,
                                        border: Border.all(
                                          color: globalColorScheme
                                              .primaryContainer,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                if (sets?[index]!
                                                            .actualWeight !=
                                                        null &&
                                                    sets![index]!
                                                            .actualWeight! >
                                                        0) {
                                                  _updateSets(
                                                    sets[index]!.copyWith(
                                                      actualWeight: sets[index]!
                                                              .actualWeight ??
                                                          0 - 1,
                                                    ),
                                                  );
                                                }
                                              },
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${sets?[index]?.actualWeight ?? 0}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                // if (sets?[index]!
                                                //             .actualWeight !=
                                                //         null &&
                                                //     sets![index]!
                                                //             .actualWeight! >
                                                //         0) {
                                                _updateSets(
                                                  sets![index]!.copyWith(
                                                    actualWeight: (sets[index]!
                                                                .actualWeight ??
                                                            0) +
                                                        1,
                                                  ),
                                                );
                                                // }
                                              },
                                              icon: Icon(
                                                Icons.add_circle_outline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Target: ${widget.sets[index].targetWeight} kgs',
                                      style: TextStyle(
                                        color: globalColorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.showReps)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Reps',
                                        style: TextStyle(fontSize: 16)),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: globalColorScheme.surface,
                                        border: Border.all(
                                          color: globalColorScheme
                                              .primaryContainer,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                if (sets?[index]!.actualReps !=
                                                        null &&
                                                    sets![index]!.actualReps! >
                                                        0) {
                                                  _updateSets(
                                                    sets[index]!.copyWith(
                                                      actualReps: sets[index]!
                                                              .actualReps! -
                                                          1,
                                                    ),
                                                  );
                                                }
                                              },
                                              // _updateSets(
                                              //   sets![index]!.copyWith(
                                              //     actualReps:
                                              //         sets[index]!.actualReps ??
                                              //             0 - 1,
                                              //   ),
                                              // ),
                                              icon: Icon(
                                                  Icons.remove_circle_outline),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${sets?[index]?.actualReps ?? 0}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                // if (sets?[index]!.actualReps !=
                                                //         null &&
                                                //     sets![index]!.actualReps! >
                                                //         0) {
                                                _updateSets(
                                                  sets![index].copyWith(
                                                    actualReps: (sets[index]
                                                                .actualReps ??
                                                            0) +
                                                        1,
                                                  ),
                                                );
                                                // }
                                              },
                                              icon: Icon(
                                                Icons.add_circle_outline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Target: ${widget.sets[index].targetReps} reps',
                                      style: TextStyle(
                                        color: globalColorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.showTime)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Duration (in mins)',
                                        style: TextStyle(fontSize: 16)),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: globalColorScheme.surface,
                                        border: Border.all(
                                          color: globalColorScheme
                                              .primaryContainer,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                if (sets?[index]!.actualTime !=
                                                        null &&
                                                    sets![index]!
                                                            .actualTime!
                                                            .inMinutes >
                                                        0) {
                                                  _updateSets(
                                                    sets[index]!.copyWith(
                                                      actualTime: Duration(
                                                        minutes: (sets[index]
                                                                        .actualTime ??
                                                                    Duration(
                                                                      minutes:
                                                                          0,
                                                                    ))
                                                                .inMinutes -
                                                            1,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              // _updateSets(
                                              //   sets![index]!.copyWith(
                                              //     actualReps:
                                              //         sets[index]!.actualReps ??
                                              //             0 - 1,
                                              //   ),
                                              // ),
                                              icon: Icon(
                                                  Icons.remove_circle_outline),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                '${sets?[index].actualTime?.inMinutes ?? 0}',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () {
                                                _updateSets(
                                                  sets![index]!.copyWith(
                                                    actualTime: Duration(
                                                      minutes: (sets[index]
                                                                      .actualTime ??
                                                                  Duration(
                                                                    minutes: 0,
                                                                  ))
                                                              .inMinutes +
                                                          1,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add_circle_outline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Target: ${widget.sets[index].targetTime!.inMinutes} mins',
                                      style: TextStyle(
                                        color: globalColorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PlatformButton().buildButton(
            context: context,
            type: ButtonType.primary,
            backgroundColor: globalColorScheme.primary,
            foregroundColor: globalColorScheme.surface,
            text: 'Submit',
            onPressed: () => widget.onSubmit(_sets.value!),
          )!,
        ),
      ],
    );
  }
}
