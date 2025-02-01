import 'dart:convert';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/core/util/api/api_service.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class FitFlexWorkoutTrackerPage extends StatefulWidget {
  static const route = "workout-tracker";
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
  State<FitFlexWorkoutTrackerPage> createState() =>
      _FitFlexWorkoutTrackerPageState();
}

class _FitFlexWorkoutTrackerPageState extends State<FitFlexWorkoutTrackerPage>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  final ValueNotifier<String?> _gifUrl = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // fetchExerciseData();
    ApiService.fetchGifUrl(widget.exercise.code ?? '').then(
      (url) {
        _gifUrl.value = url;
      },
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // Ensure the widget is still active before updating state
    if (!mounted) return;

    // Use the updated way to access the render view
    final bottomInset = RendererBinding
        .instance.renderViews.first.flutterView.viewInsets.bottom;

    // Update state based on the keyboard visibility
    setState(() {
      isKeyboardVisible = bottomInset > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // bool isKeyboardOpen = bottomInsets != 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Workout Tracker",
            message:
                "Progress is not saved, if you continue your progress will be lost.",
            cancelText: 'Cancel',
            confirmText: 'Continue',
            onConfirm: () => context.pop(),
          );
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: PlatformAppbar.basicAppBar(
          title: "Workout Plan",
          context: context,
          backgroundColor: globalColorScheme.onPrimaryContainer,
          onLeadingPressed: () {
            PlatformDialog.showAlertDialog(
              context: context,
              title: "Workout Tracker",
              message:
                  "Progress is not saved, if you continue your progress will be lost.",
              cancelText: 'Cancel',
              confirmText: 'Continue',
              // onCancel: () => context.pop(),
              onConfirm: () => context.pop(),
            );
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isKeyboardVisible) ...[
              Container(
                color: Colors.white,
                width: double.maxFinite,
                height: 250,
                // width: double.maxFinite,
                child: Align(
                  alignment: Alignment.center,
                  child: ValueListenableBuilder(
                    valueListenable: _gifUrl,
                    builder: (context, url, _) {
                      // final data = snapshot.data;
                      if (url != null) {
                        if (url.isNotEmpty) {
                          // if (snapshot.hasData) {
                          return Gif(
                            placeholder: (context) =>
                                CupertinoActivityIndicator(),
                            alignment: Alignment.center,
                            autostart: Autostart.loop,
                            image: NetworkImage(
                              url,
                            ),
                          );
                        } else {
                          return Text('No GIF available');
                        }
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    },
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
            ],
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
                      'Day ${widget.day.dayNumber}',
                      style: TextStyle(
                        color: globalColorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.workoutPlan.name,
                      style: TextStyle(
                          color: globalColorScheme.onSurfaceVariant,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${widget.exercise.name}',
                      style: TextStyle(
                        color: globalColorScheme.tertiaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    BlocListener<WorkoutManagementBloc, WorkoutManagementState>(
                      listener: (context, state) {
                        // if (state is GetWorkoutPlansForClientComplete) {
                        //   context.pop();
                        //   context.pop(
                        //     widget.exercise.copyWith(
                        //       completed: true,
                        //     ),
                        //   );
                        // }
                      },
                      child: SizedBox(height: 10),
                    ),
                    BlocListener<WorkoutHistoryBloc, WorkoutHistoryState>(
                      listener: (context, state) {
                        if (state is LogWorkoutHistoryLoading) {
                          PlatformDialog.showLoadingDialog(
                            context: context,
                            message: "Saving your progress..",
                          );
                        }
                        if (state is LogWorkoutHistoryComplete) {
                          context.pop();
                          context.pop(
                            widget.exercise.copyWith(
                              completed: true,
                            ),
                          );
                          // context.read<WorkoutManagementBloc>().add(
                          //       GetWorkoutPlansForClientEvent(
                          //         clientId:
                          //             getIt<FirebaseAuth>().currentUser!.uid,
                          //       ),
                          //     );
                        }
                      },
                      child: Expanded(
                        child: SetTrakerWidget(
                          showSubmit: !isKeyboardVisible,
                          onConfirmExit: () {
                            context.pop(
                                widget.exercise.copyWith(completed: false));
                          },
                          onSubmit: (sets) {
                            context.read<WorkoutHistoryBloc>().add(
                                  LogWorkoutHistoryEvent(
                                    widget.exercise.copyWith(sets: sets),
                                  ),
                                );
                          },
                          sets: widget.exercise.sets,
                          showReps: widget.exercise.parameters?['reps'],
                          showTime: widget.exercise.parameters?['duration'],
                          showWeight: widget.exercise.parameters?['weight'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class SetTrakerWidget extends StatefulWidget {
  final bool showSubmit;
  final List<SetModel> sets;
  final bool showWeight;
  final bool showReps;
  final bool showTime;
  final Function(List<SetModel> sets) onSubmit;
  final VoidCallback onConfirmExit;
  const SetTrakerWidget({
    super.key,
    required this.sets,
    required this.showWeight,
    required this.showSubmit,
    required this.showReps,
    required this.showTime,
    required this.onSubmit,
    required this.onConfirmExit,
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
            actualReps: set.actualReps ?? 0,
            actualTime: set.actualTime ?? Duration(minutes: 0),
            actualWeight: set.actualWeight ?? 0,
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
                                color: globalColorScheme.tertiary,
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: AppTextFields.basicTextField(
                                          style: TextStyle(
                                              color: globalColorScheme
                                                  .onPrimaryContainer),
                                          keyboardType: TextInputType.number,
                                          onChanged: (p0) => _updateSets(
                                              sets![index].copyWith(
                                                  actualWeight:
                                                      double.tryParse(p0))),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color: globalColorScheme
                                                  .primaryContainer,
                                              width: 1,
                                            ),
                                          ),
                                        ),
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
                              SizedBox(
                                width: 10,
                              ),
                            if (widget.showReps)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Reps',
                                        style: TextStyle(fontSize: 16)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: AppTextFields.basicTextField(
                                          style: TextStyle(
                                              color: globalColorScheme
                                                  .onPrimaryContainer),
                                          onChanged: (p0) => _updateSets(
                                              sets![index].copyWith(
                                                  actualReps:
                                                      int.tryParse(p0))),
                                          keyboardType: TextInputType.number,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color: globalColorScheme
                                                  .primaryContainer,
                                              width: 1,
                                            ),
                                          ),
                                        ),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: AppTextFields.basicTextField(
                                          onChanged: (p0) => _updateSets(
                                              sets![index].copyWith(
                                                  actualTime: Duration(
                                                      minutes:
                                                          int.tryParse(p0) ??
                                                              0))),
                                          keyboardType: TextInputType.number,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color: globalColorScheme
                                                  .primaryContainer,
                                              width: 1,
                                            ),
                                          ),
                                        ),
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
        if (widget.showSubmit)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlatformButton().buildButton(
              context: context,
              type: ButtonType.primary,
              backgroundColor: globalColorScheme.primary,
              foregroundColor: globalColorScheme.surface,
              text: 'Submit',
              textStyle: TextStyle(color: globalColorScheme.surface),
              onPressed: () {
                if (widget.showWeight && widget.showReps) {
                  final isNotReady = _sets.value?.any(
                    (element) => ((element.actualReps ?? 0) <= 0),
                  );
                  final isNotComplete = _sets.value?.any(
                    (element) => ((element.actualReps ?? 0) > 0),
                  );
                  final isWeightNotReady = _sets.value?.any(
                    (element) => ((element.actualWeight ?? 0) <= 0),
                  );
                  final isWeightNotComplete = _sets.value?.any(
                    (element) => ((element.actualWeight ?? 0) > 0),
                  );
                  if (((isNotReady ?? true) && (isWeightNotReady ?? true)) &&
                      ((isNotComplete ?? false) &&
                          (isWeightNotComplete ?? true))) {
                    PlatformDialog.showAlertDialog(
                      context: context,
                      title: "Workout Tracker",
                      message:
                          "You haven't updated all your sets, continue to submit ?",
                      onConfirm: () => widget.onSubmit(_sets.value!),
                      cancelText: 'No',
                      confirmText: 'Yes',
                    );
                  } else if (((isNotReady ?? true) &&
                          (isWeightNotReady ?? true)) &&
                      !((isNotComplete ?? false) &&
                          (isWeightNotComplete ?? true))) {
                    PlatformDialog.showAlertDialog(
                      context: context,
                      title: "Workout Tracker",
                      message:
                          "You haven't updated your progress. please update atleast one set. wish to go back ?",
                      onConfirm: () => widget.onConfirmExit(),
                      cancelText: 'No',
                      confirmText: 'Yes',
                    );
                  } else {
                    widget.onSubmit(_sets.value!);
                  }
                } else if (!widget.showWeight && widget.showReps) {
                  final isNotReady = _sets.value?.any(
                    (element) => ((element.actualReps ?? 0) <= 0),
                  );
                  final isNotComplete = _sets.value?.any(
                    (element) => ((element.actualReps ?? 0) > 0),
                  );
                  if ((isNotReady ?? true) && (isNotComplete ?? false)) {
                    PlatformDialog.showAlertDialog(
                      context: context,
                      title: "Workout Tracker",
                      message:
                          "You haven't updated all your sets, continue to submit ?",
                      onConfirm: () => widget.onSubmit(_sets.value!),
                      cancelText: 'No',
                      confirmText: 'Yes',
                    );
                  } else if ((isNotReady ?? true) &&
                      !(isNotComplete ?? false)) {
                    PlatformDialog.showAlertDialog(
                      context: context,
                      title: "Workout Tracker",
                      message:
                          "You haven't updated your progress. please update atleast one set. wish to go back ?",
                      onConfirm: () => widget.onConfirmExit(),
                      cancelText: 'No',
                      confirmText: 'Yes',
                    );
                  } else {
                    widget.onSubmit(_sets.value!);
                  }
                } else if (widget.showTime) {
                  final isNotReady = _sets.value?.any(
                    (element) => ((element.actualTime?.inMinutes ??
                            Duration(minutes: 0).inMinutes) <=
                        Duration(minutes: 0).inMinutes),
                  );
                  if (isNotReady ?? true) {
                    PlatformDialog.showAlertDialog(
                      context: context,
                      title: "Workout Tracker",
                      message:
                          "You haven't updated your progress, wish to cancel ?",
                      onConfirm: () => widget.onConfirmExit(),
                      cancelText: 'No',
                      confirmText: 'Yes',
                    );
                  } else {
                    widget.onSubmit(_sets.value!);
                  }
                }
              },
            )!,
          )
        else
          SizedBox(
            height: 50,
            width: 100,
            child: PlatformButton().buildButton(
              context: context,
              type: ButtonType.outlined,
              backgroundColor: globalColorScheme.onPrimaryContainer,
              textStyle: TextStyle(
                  color: globalColorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
              text: "Done",
              onPressed: () => FocusScope.of(context).unfocus(),
            )!,
          )
      ],
    );
  }
}
