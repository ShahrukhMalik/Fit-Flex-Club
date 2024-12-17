import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_debounce_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid_v4/uuid_v4.dart';

class AddExerciseBottomSheetWidget extends StatefulWidget {
  final ExerciseBpModel? exercise;
  final ExerciseModel? editExercise;
  final bool sets;
  final bool duration;
  final bool weight;
  final bool reps;
  final String dayId;

  const AddExerciseBottomSheetWidget({
    super.key,
    required this.exercise,
    this.editExercise,
    required this.sets,
    required this.duration,
    required this.weight,
    required this.reps,
    required this.dayId,
  });

  @override
  State<AddExerciseBottomSheetWidget> createState() =>
      _AddExerciseBottomSheetWidgetState();
}

class _AddExerciseBottomSheetWidgetState
    extends State<AddExerciseBottomSheetWidget> {
  final ValueNotifier<ExerciseModel?> exerciseModel = ValueNotifier(null);
  final ValueNotifier<List<SetModel>?> sets = ValueNotifier(null);
  final TextEditingController durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exerciseModel.value = widget.editExercise ??
        ExerciseModel(
          dayId: widget.dayId,
          // [
          //   SetModel(
          //     id: UUIDv4().toString(),
          //   ),
          // ],
          [],
          code: widget.exercise!.code,
          id: UUIDv4().toString(),
          name: widget.exercise!.name,
          category: widget.exercise!.category,
          muscleGroup: widget.exercise!.muscleGroup,
          parameters: widget.exercise!.parameters,
        );
    sets.value = widget.editExercise?.sets ??
        [
          SetModel(
            exerciseId: exerciseModel.value!.id!,
            id: UUIDv4().toString(),
          ),
        ];
  }

  _deleteSet(String setId) {
    final updatedSets = sets.value?.where((set) => set.id != setId).toList();
    sets.value = updatedSets;
  }

  _editSet(SetModel editedSet) {
    // Get the current list or initialize a new one
    final currentSets = sets.value ?? [];

    // Update the list: replace the matching set or add it
    final updatedSets = currentSets.map((set) {
      if (set.id == editedSet.id) {
        return set.copyWith(
          targetReps: editedSet.targetReps,
          targetWeight: editedSet.targetWeight,
        );
      }
      return set;
    }).toList();

    // Add the new set if it doesn't exist
    if (!currentSets.any((set) => set.id == editedSet.id)) {
      updatedSets.add(editedSet);
    }
    sets.value = updatedSets;
  }

  _addSet(SetModel newSet) {
    // Get the current list or initialize a new one
    final currentSets = sets.value ?? [];

    // Update the list: replace the matching set or add it
    final updatedSets = currentSets.map((set) {
      if (set.id == newSet.id) {
        return set.copyWith(
          targetReps: newSet.targetReps,
          targetWeight: newSet.targetWeight,
        );
      }
      return set;
    }).toList();

    // Add the new set if it doesn't exist
    if (!currentSets.any((set) => set.id == newSet.id)) {
      updatedSets.add(newSet);
    }

    // Add an empty set at the end
    updatedSets.add(
      SetModel(
        clientId: newSet.clientId,
        exerciseId: newSet.exerciseId,
        id: UUIDv4().toString(),
      ),
    );

    // Replace the value with a new list
    sets.value = updatedSets;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightController = TextEditingController();
    final TextEditingController repsController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    return SafeArea(
      child: Container(
        // margin: EdgeInsets.only(top: 100),
        // padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: globalColorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        constraints: BoxConstraints(
          minWidth: double.maxFinite,
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Add Exercise',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Index Circle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.fitness_center),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Content Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Subtitle
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.exercise?.name ??
                                            widget.editExercise?.name ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.exercise?.muscleGroup ??
                                            widget.editExercise?.muscleGroup ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Tag (e.g., Hypertrophy)
                                if (widget.exercise?.category != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: globalColorScheme.secondary
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      widget.exercise?.category ?? "",
                                      style: TextStyle(
                                        color:
                                            globalColorScheme.onErrorContainer,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (widget.editExercise?.category != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: globalColorScheme.secondary
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      widget.editExercise?.category ?? "",
                                      style: TextStyle(
                                        color:
                                            globalColorScheme.onErrorContainer,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // // Metrics Row
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (widget.duration)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "Duration (in Mins)",
                          ),
                          Expanded(
                            child: AppTextFields.basicTextField(
                              controller: durationController,
                              onChanged: (p0) {
                                durationController.text = p0;
                                sets.value = [
                                  SetModel(
                                    exerciseId: exerciseModel.value!.id!,
                                    id: UUIDv4().toString(),
                                    targetTime: Duration(
                                      minutes: int.tryParse(p0) ?? 10,
                                    ),
                                  ),
                                ];
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ValueListenableBuilder(
                          valueListenable: sets,
                          builder: (context, set, _) {
                            if (!widget.duration) {
                              // if (sets.value?.isNotEmpty ?? false) {
                              return SingleChildScrollView(
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  // border: TableBorder.all(color: Colors.grey),
                                  columnWidths: widget.weight
                                      ? {
                                          0: FlexColumnWidth(1), // Set #
                                          1: FlexColumnWidth(2), // Reps
                                          2: FlexColumnWidth(2), // Weight
                                          3: FlexColumnWidth(1), // Actions
                                        }
                                      : {
                                          0: FlexColumnWidth(1), // Set #
                                          1: FlexColumnWidth(2), // Reps
                                          2: FlexColumnWidth(1), // Weight
                                        },
                                  children: [
                                    // Table Header
                                    TableRow(
                                      // decoration: BoxDecoration(color: globalColorScheme.secondary),
                                      children: [
                                        Center(
                                          child: Text(
                                            'Set #',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        if (widget.reps)
                                          Center(
                                            child: Text(
                                              'Reps',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        if (widget.weight)
                                          Center(
                                            child: Text(
                                              'Weight',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        Center(
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Dynamic Rows
                                    ...sets.value!.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final set = entry.value;

                                      final TextEditingController
                                          repsController =
                                          TextEditingController();
                                      repsController.text =
                                          set.targetReps == null
                                              ? ""
                                              : set.targetReps.toString();
                                      final TextEditingController
                                          weightController =
                                          TextEditingController();
                                      weightController.text =
                                          set.targetWeight == null
                                              ? ""
                                              : set.targetWeight.toString();
                                      return TableRow(
                                        children: [
                                          // Set #
                                          Center(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: globalColorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Reps
                                          if (widget.reps)
                                            DebouncedTextField(
                                              controller: repsController,
                                              onChanged: (value) {
                                                _editSet(
                                                  SetModel(
                                                    exerciseId: set.exerciseId,
                                                    id: set.id,
                                                    targetReps:
                                                        int.tryParse(value),
                                                    targetWeight:
                                                        set.targetWeight,
                                                  ),
                                                );
                                              },
                                            ),
                                          // Weight
                                          if (widget.weight)
                                            DebouncedTextField(
                                              controller: weightController,
                                              onChanged: (value) {
                                                _editSet(
                                                  SetModel(
                                                    exerciseId: set.id,
                                                    id: set.id,
                                                    targetReps: set.targetReps,
                                                    targetWeight:
                                                        double.tryParse(
                                                      value,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),

                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.add_box,
                                                      color: globalColorScheme
                                                          .primaryContainer,
                                                    ),
                                                    onPressed: () {
                                                      if (widget.weight) {
                                                        if (repsController
                                                                .text.isEmpty ||
                                                            weightController
                                                                .text.isEmpty) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Please input all the fields before adding new set",
                                                            backgroundColor:
                                                                globalColorScheme
                                                                    .onErrorContainer,
                                                            textColor:
                                                                globalColorScheme
                                                                    .primary,
                                                          );
                                                        } else {
                                                          _addSet(
                                                            SetModel(
                                                              clientId:
                                                                  set.clientId,
                                                              exerciseId: set
                                                                  .exerciseId,
                                                              id: set.id,
                                                              targetReps:
                                                                  int.tryParse(
                                                                repsController
                                                                    .text,
                                                              ),
                                                              targetWeight:
                                                                  double
                                                                      .tryParse(
                                                                weightController
                                                                    .text,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      } else if (widget.reps &&
                                                          !widget.weight) {
                                                        if (repsController
                                                            .text.isEmpty) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                "Please input all the fields before adding new set",
                                                            backgroundColor:
                                                                globalColorScheme
                                                                    .onErrorContainer,
                                                            textColor:
                                                                globalColorScheme
                                                                    .primary,
                                                          );
                                                        } else {
                                                          _addSet(
                                                            SetModel(
                                                              clientId:
                                                                  set.clientId,
                                                              exerciseId: set
                                                                  .exerciseId,
                                                              id: set.id,
                                                              targetReps:
                                                                  int.tryParse(
                                                                repsController
                                                                    .text,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                                if (sets.value!.length > 1)
                                                  Expanded(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: globalColorScheme
                                                            .onPrimaryContainer,
                                                      ),
                                                      onPressed: () {
                                                        _deleteSet(set.id);
                                                      },
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              );
                              // }
                              // else {

                              // }
                            } else {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Duration (in Mins)",
                                    ),
                                  ),
                                  Expanded(
                                    child: AppTextFields.basicTextField(
                                      controller: durationController,
                                      onChanged: (p0) {
                                        durationController.text = p0;
                                        sets.value = [
                                          SetModel(
                                            exerciseId:
                                                exerciseModel.value!.id!,
                                            id: UUIDv4().toString(),
                                            targetTime: Duration(
                                              minutes: int.tryParse(p0) ?? 10,
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            PlatformButton().buildButton(
              context: context,
              type: ButtonType.primary,
              text: 'Submit',
              onPressed: () {
                if (widget.duration) {
                  if (durationController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Duration is not entered",
                      backgroundColor: globalColorScheme.onErrorContainer,
                      textColor: globalColorScheme.primary,
                    );
                  } else {
                    Navigator.pop(
                      context,
                      exerciseModel.value?.copyWith(
                        sets: sets.value,
                      ),
                    );
                  }
                } else {
                  if (widget.reps && !widget.weight) {
                    if (sets.value?.first.targetReps == null) {
                      Fluttertoast.showToast(
                        msg: "Please input reps for the first set",
                        backgroundColor: globalColorScheme.onErrorContainer,
                        textColor: globalColorScheme.primary,
                      );
                    } else {
                      Navigator.pop(
                        context,
                        exerciseModel.value?.copyWith(
                          sets: sets.value,
                        ),
                      );
                    }
                  }

                  if (widget.reps && widget.weight) {
                    if (sets.value?.first.targetReps == null ||
                        sets.value?.first.targetWeight == null) {
                      Fluttertoast.showToast(
                        msg: "Please input reps and sets for the first set",
                        backgroundColor: globalColorScheme.onErrorContainer,
                        textColor: globalColorScheme.primary,
                      );
                    } else {
                      Navigator.pop(
                        context,
                        exerciseModel.value?.copyWith(
                          sets: sets.value,
                        ),
                      );
                    }
                  }
                }
              },
            )!
          ],
        ),
      ),
    );
  }
}
