import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
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
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_exercise_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:uuid_v4/uuid_v4.dart';

import 'package:flutter/material.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';

class ExerciseBottomSheet extends StatefulWidget {
  final ExerciseBpModel exercise;
  final bool sets;
  final bool duration;
  final bool weight;
  final bool reps;

  const ExerciseBottomSheet({
    super.key,
    required this.exercise,
    required this.sets,
    required this.duration,
    required this.weight,
    required this.reps,
  });

  @override
  State<ExerciseBottomSheet> createState() => _ExerciseBottomSheetState();
}

class _ExerciseBottomSheetState extends State<ExerciseBottomSheet> {
  final ValueNotifier<ExerciseModel?> exerciseModel = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    exerciseModel.value = ExerciseModel(
      [
        SetModel(
          id: UUIDv4().toString(),
        ),
      ],
      code: widget.exercise.code,
      id: UUIDv4().toString(),
      name: widget.exercise.name,
      category: widget.exercise.category,
      muscleGroup: widget.exercise.muscleGroup,
      parameters: widget.exercise.parameters,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightController = TextEditingController();
    final TextEditingController repsController = TextEditingController();
    final TextEditingController durationController = TextEditingController();

    bool populateWithInitialValue = true;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: globalColorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        constraints: BoxConstraints(
          minWidth: double.maxFinite,
          minHeight: 400,
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.exercise.name ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.exercise.muscleGroup ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tag (e.g., Hypertrophy)
                          if (widget.exercise.category != null)
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
                                widget.exercise.category ?? "",
                                style: TextStyle(
                                  color: globalColorScheme.onErrorContainer,
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
            // if (!widget.duration)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(child: Center(child: Text('Set'))),
            //       if (widget.reps) Expanded(child: Center(child: Text('Reps'))),
            //       if (widget.weight)
            //         Expanded(child: Center(child: Text('Weight (kg)'))),
            //     ],
            //   ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ValueListenableBuilder(
                  valueListenable: exerciseModel,
                  builder: (context, exercise, _) {
                    if (exercise?.sets.isNotEmpty ?? false) {
                      return Table(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (widget.reps)
                                Center(
                                  child: Text(
                                    'Reps',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              if (widget.weight)
                                Center(
                                  child: Text(
                                    'Weight',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              Center(
                                child: Text(
                                  '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          // Dynamic Rows
                          ...exercise!.sets.asMap().entries.map((entry) {
                            final index = entry.key;
                            final set = entry.value;

                            final TextEditingController repsController =
                                TextEditingController();
                            repsController.text = set.targetReps == null
                                ? ""
                                : set.targetReps.toString();
                            final TextEditingController weightController =
                                TextEditingController();
                            weightController.text = set.targetWeight == null
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
                                        borderRadius: BorderRadius.all(
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
                                        color: globalColorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                                // Reps
                                if (widget.reps)
                                  AppTextFields.basicTextField(
                                    controller: repsController,
                                    uniqueKey: UniqueKey(),
                                    // initialValue:
                                    //     populateWithInitialValue == true
                                    //         ? set.targetReps == null
                                    //             ? ""
                                    //             : set.targetReps.toString()
                                    //         : null,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      color:
                                          globalColorScheme.onPrimaryContainer,
                                    ),
                                    // initialValue: set.reps,

                                    onChanged: (value) {
                                      // exerciseModel.value = exerciseModel
                                      //     .value
                                      //     ?.deleteSet(set.id);
                                      // exerciseModel.value =
                                      //     exerciseModel.value?.addSet(
                                      //   SetModel(
                                      //     id: UUIDv4().toString(),
                                      //     targetReps: int.tryParse(
                                      //       value,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                                // Weight
                                if (widget.weight)
                                  AppTextFields.basicTextField(
                                    controller: weightController,
                                    uniqueKey: UniqueKey(),
                                    // initialValue:
                                    //     populateWithInitialValue == true
                                    //         ? set.targetWeight == null
                                    //             ? ""
                                    //             : set.targetWeight.toString()
                                    //         : null,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      color:
                                          globalColorScheme.onPrimaryContainer,
                                    ),
                                    // initialValue: set.weight,
                                    onChanged: (value) {
                                      // exerciseModel.value = exerciseModel
                                      //     .value
                                      //     ?.deleteSet(set.id);
                                      // exerciseModel.value =
                                      //     exerciseModel.value?.addSet(
                                      //   SetModel(
                                      //     id: UUIDv4().toString(),
                                      //     targetWeight: double.tryParse(
                                      //       value,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                                // Actions (Edit/Add/Delete)
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (false)
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            // Handle Edit Logic
                                            setState(() {
                                              // Example toggle editable state
                                              // exerciseModel.value =
                                              //     exerciseModel.value
                                              //         ?.toggleEdit(index);
                                            });
                                          },
                                        ),
                                      if (true)
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_box,
                                              color: globalColorScheme
                                                  .primaryContainer,
                                            ),
                                            onPressed: () {
                                              if (repsController.text.isEmpty ||
                                                  weightController
                                                      .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please input all the fields before adding new set");
                                              } else {
                                                exerciseModel.value =
                                                    exerciseModel.value?.addSet(
                                                  SetModel(
                                                    id: UUIDv4().toString(),
                                                    targetReps: int.tryParse(
                                                      repsController.text,
                                                    ),
                                                    targetWeight:
                                                        double.tryParse(
                                                      weightController.text,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      if (exercise.sets.length > 1)
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: globalColorScheme
                                                  .onPrimaryContainer,
                                            ),
                                            onPressed: () {
                                              exerciseModel.value =
                                                  exerciseModel.value
                                                      ?.deleteSet(set.id);
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
                      );
                    } else {
                      // Empty Table: Show Add Button
                      return PlatformButton().buildButton(
                        context: context,
                        type: ButtonType.icon,
                        text: 'Add Set',
                        onPressed: () {
                          exerciseModel.value = exerciseModel.value?.addSet(
                            SetModel(
                              id: UUIDv4().toString(),
                            ),
                          );
                        },
                      )!;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future _showExerciseSetSheet(BuildContext context, ExerciseBpModel exercise) {
  if (Platform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return ExerciseBottomSheet(
          reps: exercise.parameters?['reps'] ?? false,
          duration: exercise.parameters?['duration'] ?? false,
          exercise: exercise,
          sets: exercise.parameters?['sets'] ?? false,
          weight: exercise.parameters?['weight'] ?? false,
        );
      },
    );
  } else {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ExerciseBottomSheet(
          reps: exercise.parameters?['reps'] ?? false,
          duration: exercise.parameters?['duration'],
          exercise: exercise,
          sets: exercise.parameters?['sets'],
          weight: exercise.parameters?['weight'],
        );
      },
    );
  }
}

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
  int selectedWeek = 0;
  late TabController _tabController;
  int _currentTabIndex = 0;

  _createWorkOutBpObject() {
    final weeks = List<WeekModel>.generate(
      5,
      (index) {
        final days = List<DayModel>.generate(
          5,
          (dayIndex) {
            return DayModel(
              dayNumber: dayIndex + 1,
              exercises: [],
              id: UUIDv4().toString(),
            );
          },
        );
        return WeekModel(
          weekNumber: index + 1,
          days: days,
          id: UUIDv4().toString(),
        );
      },
    );
    _workoutPlanBp = ValueNotifier(
      WorkoutPlanModel(
        name: '',
        weeks: weeks,
        uid: UUIDv4().toString(),
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
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Platform-specific Tab Bar
  Widget _buildTabBar(BuildContext context) {
    final colorScheme = globalColorScheme;
    final ScrollController horizontalScrollController = ScrollController();
    final List<GlobalKey> tabKeys = List.generate(6, (_) => GlobalKey());

    return Theme.of(context).platform == TargetPlatform.iOS
        ? Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SingleChildScrollView(
              controller: horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(6, (index) {
                  bool isSelected = _currentTabIndex == index;
                  return GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                      // Dynamic scrolling logic

                      // Get the total width of the scroll view
                      final RenderBox? renderBox =
                          context.findRenderObject() as RenderBox?;
                      if (renderBox == null) return;

                      // Available viewport width
                      final viewportWidth = renderBox.constraints.maxWidth;

                      // Rough estimate of each tab's width (adjust if needed)
                      const tabWidth =
                          120.0; // Estimated tab width including margins

                      // Calculate scroll offset based on index and viewport
                      double scrollOffset = index * tabWidth -
                          (viewportWidth / 2) +
                          (tabWidth / 2);

                      // Ensure scroll offset is within bounds
                      scrollOffset = scrollOffset.clamp(0.0,
                          horizontalScrollController.position.maxScrollExtent);

                      // Animate to the calculated scroll position
                      horizontalScrollController.animateTo(
                        scrollOffset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      key: tabKeys[index],
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow,
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        color: isSelected
                            ? globalColorScheme.tertiary
                            : CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Day ${index + 1}',
                          style: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: isSelected
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                dividerColor: colorScheme.secondary,
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colorScheme.secondary,
                ),
                labelColor: colorScheme.onSecondary,
                unselectedLabelColor: colorScheme.onTertiary,
                tabs: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Tab(
                      text: 'Day ${index + 1}',
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  // Platform-specific Tab Bar View
  Widget _buildTabBarView(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoTabView(
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    child: _buildDayWorkouts(_currentTabIndex),
                  ),
                ],
              );
            },
          )
        : TabBarView(
            controller: _tabController,
            children: List.generate(
              6,
              (dayIndex) {
                return _buildDayWorkouts(dayIndex);
              },
            ),
          );
  }

  // Shared method to build workouts for a specific day
  Widget _buildDayWorkouts(int dayIndex) {
    return BlocBuilder<WorkoutManagementBloc, WorkoutManagementState>(
      builder: (context, state) {
        // if (state is SubjectFailed) {
        //   return ErrorOutput(message: state.message);
        // }
        if (state is GetExercisesComplete) {
          final exercises = state.exercises;
          return Container(
            decoration: BoxDecoration(
              color: globalColorScheme.surface,
              // borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: globalColorScheme.primary,
              //     blurRadius: 20,
              //     offset: const Offset(2, 2),
              //     blurStyle: BlurStyle.outer,
              //   ),
              // ],
            ),
            child:
                //  ListView(
                //   children: const [
                //     WorkoutListItem(
                //       index: 1,
                //       title: "Bench Press",
                //       subTitle: "Barbell",
                //       tag: "Hypertrophy",
                //       weight: 70,
                //       sets: 3,
                //       reps: 10,
                //       rir: 2,
                //     ),
                //     WorkoutListItem(
                //       index: 2,
                //       title: "Olympic Clean",
                //       subTitle: "Dumbell",
                //       tag: "Power",
                //       weight: 60,
                //       sets: 3,
                //       reps: 10,
                //       rir: 2,
                //     ),
                //     WorkoutListItem(
                //       index: 3,
                //       title: "Single Arm Row",
                //       subTitle: "Flywheel, Unilateral",
                //       tag: "Speed",
                //       weight: 50,
                //       sets: 3,
                //       reps: 5,
                //       rir: 1,
                //     ),
                //   ],
                // ),
                ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, workoutIndex) {
                return WorkoutTile(
                  index: workoutIndex,
                  exercise: exercises[workoutIndex],
                  workoutName: 'Workout ${workoutIndex + 1}',
                  difficulty: 'Intermediate',
                  sets: 3 + workoutIndex,
                  progress: workoutIndex == 2 ? 0 : (workoutIndex + 1) * 15,
                  isCompleted: workoutIndex == 2 ? true : false,
                );
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'addWorkout',
        splashColor: globalColorScheme.tertiary,
        backgroundColor: globalColorScheme.primaryContainer,
        onPressed: () async {
          final result = await _showExerciseSheet(context);
          print(result);
          if (result != null) {
            _showExerciseSetSheet(context, result);
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
          backgroundColor: colorScheme.onPrimaryContainer),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Week Selector
        SizedBox(
          // padding: const EdgeInsets.all(10),
          // margin: const EdgeInsets.all(10),
          height: 140,
          child: ValueListenableBuilder(
            valueListenable: _workoutPlanBp,
            builder: (context, workoutPlan, _) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: workoutPlan.weeks.length, // Number of weeks
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return WeekTile(
                    weekNumber: index + 1,
                  );
                },
              );
            },
          ),
        ),
        // Day Tabs
        _buildTabBar(context),

        // Workouts List
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildTabBarView(context),
          ),
        ),
      ],
    );
  }
}

class WeekTile extends StatelessWidget {
  final int weekNumber;

  const WeekTile({
    super.key,
    required this.weekNumber,
  });

  @override
  Widget build(BuildContext context) {
    const String startDate = 'Nov 15';
    const String endDate = 'Nov 21';
    final double progress = (weekNumber * 0.2); // Example progress
    const int totalWorkouts = 5;
    final int completedWorkouts =
        (weekNumber * 1); // Example number of completed workouts

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 130,
        decoration: BoxDecoration(
          color: globalColorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Week $weekNumber',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: globalColorScheme.surface,
              ),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 50,
              icon: Icon(
                Icons.fitbit,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CupertinoChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const CupertinoChip({
    Key? key,
    required this.label,
    this.backgroundColor = const Color(0xFFEFEFF4), // iOS-like gray
    this.textColor = const Color(0xFF007AFF), // iOS system blue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class WorkoutListItem extends StatelessWidget {
  final int index;
  final String title;
  final String subTitle;
  final String tag;
  final int weight;
  final int sets;
  final int reps;
  final int rir; // Reps in Reserve

  const WorkoutListItem({
    Key? key,
    required this.index,
    required this.title,
    required this.subTitle,
    required this.tag,
    required this.weight,
    required this.sets,
    required this.reps,
    required this.rir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Index Circle
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Text(
                '$index',
                style: TextStyle(color: Colors.black),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      // Tag (e.g., Hypertrophy)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Metrics Row
                  Row(
                    children: [
                      // Weight
                      _buildMetric('${weight}%', 'Weight'),
                      const SizedBox(width: 16),
                      // Sets
                      _buildMetric('$sets', 'SETS'),
                      const SizedBox(width: 16),
                      // RIR
                      _buildMetric('$rir', 'RIR'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final String workoutName;
  final String difficulty;
  final int sets;
  final int progress; // Progress in percentage (0-100)
  final bool isCompleted; // Indicates workout status
  final ExerciseEntity exercise;
  final int index;

  const WorkoutTile({
    super.key,
    required this.workoutName,
    required this.difficulty,
    required this.sets,
    required this.progress,
    required this.isCompleted,
    required this.exercise,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;
    return Padding(
      // color: globalColorScheme.secondary.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Divider(
              color: globalColorScheme.primaryContainer,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Index Circle
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.black),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  exercise.muscleGroup ?? "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tag (e.g., Hypertrophy)
                          if (exercise.category != null)
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
                                exercise.category ?? "",
                                style: TextStyle(
                                  color: globalColorScheme.onErrorContainer,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Metrics Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Center(child: Text('Set'))),
                          Expanded(child: Center(child: Text('Reps'))),
                          Expanded(child: Center(child: Text('Weight (kg)'))),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Weight
                          Expanded(
                            child: _buildMetricWidget(1),
                          ),
                          Expanded(
                            child: _buildMetricWidget(12),
                          ),
                          Expanded(
                            child: _buildMetricWidget(15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Weight
                          Expanded(
                            child: _buildMetricWidget(1),
                          ),
                          Expanded(
                            child: _buildMetricWidget(12),
                          ),
                          Expanded(
                            child: _buildMetricWidget(15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_buildMetricWidget(dynamic number) {
  return Card(
    color: globalColorScheme.inversePrimary,
    child: Center(
      child: Text(
        number.toString(),
        style: TextStyle(
            color: globalColorScheme.secondary, fontWeight: FontWeight.bold),
      ),
    ),
  );
}


// class FitFlexClubCreateWorkoutPlanPage extends StatelessWidget {
//   static const String route = "/fit-club-create-workout-plan";
//   const FitFlexClubCreateWorkoutPlanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
