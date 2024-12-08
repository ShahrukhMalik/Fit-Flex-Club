import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/pages/fit_flex_auth_forgot_password_page.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WorkoutProgramsOverview extends StatefulWidget {
  final List<WorkoutPlanModel> programs;
  final ColorScheme colorScheme;

  const WorkoutProgramsOverview({
    super.key,
    required this.programs,
    required this.colorScheme,
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
                  Text(
                    program.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: globalColorScheme.onPrimaryContainer, // Text color
                    ),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // Handle long names gracefully
                  ),
                  // const SizedBox(height: 8),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Edit Button
                      TextButton.icon(
                        onPressed: () {
                          // Handle edit action
                          context.go(
                            FitFlexClubCreateWorkoutPlanPage.route,
                            extra: {
                              'updateData': true,
                              "workoutPlan": program,
                            },
                          );
                        },
                        icon: Icon(
                          Icons.edit,
                          color: globalColorScheme
                              .secondaryContainer, // Primary color for edit
                          size: 20,
                        ),
                        label: Text(
                          "Edit",
                          style: TextStyle(
                            color: globalColorScheme
                                .secondaryContainer, // Match button text color
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Spacer(), // Push the delete button to the right
                      // Delete Button
                      TextButton.icon(
                        onPressed: () {
                          // Handle delete action
                        },
                        icon: Icon(
                          Icons.delete,
                          color:
                              globalColorScheme.error, // Error color for delete
                          size: 20,
                        ),
                        label: Text(
                          "Delete",
                          style: TextStyle(
                            color: globalColorScheme
                                .error, // Match button text color
                            fontSize: 14,
                          ),
                        ),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'createWorkout',
        splashColor: globalColorScheme.tertiary,
        backgroundColor: globalColorScheme.primaryContainer,
        onPressed: () {
          context.read<WorkoutManagementBloc>().add(GetExercisesEvent());
          context.go(FitFlexClubCreateWorkoutPlanPage.route);
        },
        child: Icon(
          Icons.add,
          color: globalColorScheme.surface,
        ),
      ),
      backgroundColor: globalColorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Workouts",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<WorkoutManagementBloc, WorkoutManagementState>(
          listener: (context, state) {
            if (state is WorkoutManagementError) {
              PlatformDialog.showAlertDialog(
                context: context,
                title: "Workout Plans",
                message: state.failures.message ?? "Something Went Wrong!",
                onConfirm: () => Navigator.pop(context),
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
                );
              } else {
                return Center(
                  child: Text(
                    'No workout plans found.',
                  ),
                );
              }
            }

            if (state is WorkoutManagementLoading) {
              return Center(
                child: CircularProgressIndicator(),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
