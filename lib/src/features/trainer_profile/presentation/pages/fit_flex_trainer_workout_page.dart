import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/getexercises/getexercises_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutProgramsOverview extends StatefulWidget {
  final List<WorkoutPlanModel> programs;
  final ColorScheme colorScheme;
  final ValueNotifier<List<ExerciseEntity>?> exercises;

  const WorkoutProgramsOverview({
    super.key,
    required this.programs,
    required this.colorScheme,
    required this.exercises,
  });

  @override
  State<WorkoutProgramsOverview> createState() =>
      _WorkoutProgramsOverviewState();
}

class _WorkoutProgramsOverviewState extends State<WorkoutProgramsOverview> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildProgramItem(WorkoutPlanModel program) {
    return Card(
      elevation: 1, // Subtle shadow for a cleaner look
      margin: const EdgeInsets.only(bottom: 12),
      color: globalColorScheme
          .inversePrimary, // Surface color for a professional look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Slightly rounded corners
        side: BorderSide(
          color: globalColorScheme.outline,
        ), // Soft border
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center align elements
          children: [
            // Leading Icon
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  globalColorScheme.primaryContainer, // Subtle background
              child: Icon(
                Icons.fitness_center,
                color: globalColorScheme
                    .onPrimaryContainer, // Contrasting icon color
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Program name and actions
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Program Name

                  // Program Status
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: widget.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            program.name,
                            style: TextStyle(
                              color: widget.colorScheme.onPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // Edit Button
                      Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: widget.exercises,
                            builder: (context, exercises, _) {
                              return IconButton(
                                onPressed: () {
                                  // Handle edit action
                                  context.push(
                                    '${FitFlexTrainerWorkoutPage.route}/${FitFlexClubCreateWorkoutPlanPage.route}',
                                    extra: {
                                      'updateData': true,
                                      "workoutPlan": program,
                                      "exercises": exercises
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: globalColorScheme
                                      .secondaryContainer, // Primary color for edit
                                  size: 20,
                                ),
                              );
                            },
                          ),
                          // Delete Button
                          IconButton(
                            onPressed: () {
                              context.read<WorkoutManagementBloc>().add(
                                    DeleteWorkoutPlanEvent(
                                      workoutPlan: program,
                                    ),
                                  );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: globalColorScheme
                                  .error, // Error color for delete
                              size: 20,
                            ),
                          ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.programs.length,
      itemBuilder: (context, index) {
        return _buildProgramItem(widget.programs[index]);
      },
    );
  }
}

// Example Usage
class FitFlexTrainerWorkoutPage extends StatefulWidget {
  static const String route = "/fit-flex-workout-page";
  const FitFlexTrainerWorkoutPage({super.key});

  @override
  State<FitFlexTrainerWorkoutPage> createState() =>
      _FitFlexTrainerWorkoutPageState();
}

class _FitFlexTrainerWorkoutPageState extends State<FitFlexTrainerWorkoutPage> {
  final ValueNotifier<bool> showFAB = ValueNotifier(false);
  final ValueNotifier<List<ExerciseEntity>?> exercises = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        print('Trainer WK Page');
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ValueListenableBuilder(
          valueListenable: showFAB,
          builder: (context, showButton, _) {
            if (showButton) {
              return ValueListenableBuilder(
                valueListenable: exercises,
                builder: (context, exercisesValue, _) {
                  return FloatingActionButton(
                    heroTag: 'createWorkout',
                    splashColor: globalColorScheme.tertiary,
                    backgroundColor: globalColorScheme.primaryContainer,
                    onPressed: () {
                      context.push(
                        '${FitFlexTrainerWorkoutPage.route}/${FitFlexClubCreateWorkoutPlanPage.route}',
                        extra: {
                          'exercises': exercisesValue,
                        },
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: globalColorScheme.surface,
                    ),
                  );
                },
              );
            } else {
              return SizedBox();
            }
          },
        ),
        backgroundColor: globalColorScheme.surface,
        appBar: PlatformAppbar.basicAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: globalColorScheme.onPrimaryContainer,
          title: "Workout Programs",
          context: context,
          trailing: PlatformButton().buildButton(
            foregroundColor: globalColorScheme.primary,
            context: context,
            type: ButtonType.icon,
            icon: Icons.logout,
            text: "",
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(LogOutAuthenticationEvent()),
          )!,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<GetexercisesCubit, GetexercisesState>(
            listener: (context, state) {
              if (state is GetexercisesLoading) {
                PlatformDialog.showLoadingDialog(
                  context: context,
                  message: "Fetching Exercises...",
                );
              }

              if (state is GetExercisesComplete) {
                exercises.value = state.exercises;
                if (context.canPop()) context.pop();
              }

              if (state is GetexercisesError) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Get Exercises",
                  message: state.failures.message ??
                      "Something went wrong! Let's try again!",
                  onConfirm: () {
                    context.read<GetexercisesCubit>().getExercises();
                  },
                );
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
            child: BlocConsumer<WorkoutManagementBloc, WorkoutManagementState>(
              listener: (context, state) {
                if (state is GetWorkoutPlansComplete) {
                  showFAB.value = true;
                }
                if (state is WorkoutManagementError) {
                  PlatformDialog.showAlertDialog(
                    context: context,
                    title: "Workout Plans",
                    message: state.failures.message ?? "Something Went Wrong!",
                    onConfirm: () {
                      if (context.canPop()) context.pop();
                    },
                  );
                }

                if (state is DeleteWorkoutComplete) {
                  PlatformDialog.showAlertDialog(
                    context: context,
                    title: "Workout Plans",
                    message: "Workout Deleted Successfully!",
                    onConfirm: () {
                      context
                          .read<WorkoutManagementBloc>()
                          .add(GetWorkoutPlansEvent());
                      if (context.canPop()) context.pop();
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is GetWorkoutPlansComplete) {
                  final workoutPlans = state.workoutPlans;
                  if (workoutPlans.isNotEmpty) {
                    return WorkoutProgramsOverview(
                      programs: workoutPlans,
                      colorScheme: colorScheme,
                      exercises: exercises,
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No workout plans found.',
                      ),
                    );
                  }
                }

                if (state is GetWorkoutPlansLoading) {
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

                if (state is WorkoutManagementError) {
                  final error = state.failures;
                  return Center(
                    child: Text(
                      error.message ?? 'No workout plans found.',
                    ),
                  );
                }
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
