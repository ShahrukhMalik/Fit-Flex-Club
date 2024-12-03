import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:flutter/material.dart';

// abstract class WorkoutPlan {
//   final String name;
//   final int weeks;

//   const WorkoutPlan({
//     required this.name,
//     required this.weeks,
//   });
// }

// class WorkoutPlanModel extends WorkoutPlan {
//   final int totalExercises;
//   final int muscleBuildingExercises;
//   final int cardioExercises;

//   const WorkoutPlanModel({
//     required super.name,
//     required super.weeks,
//     required this.totalExercises,
//     required this.muscleBuildingExercises,
//     required this.cardioExercises,
//   });

//   factory WorkoutPlanModel.fromMap(Map<String, dynamic> data) {
//     return WorkoutPlanModel(
//       name: data['name'],
//       weeks: data['weeks'],
//       totalExercises: data['totalExercises'] ?? 0,
//       muscleBuildingExercises: data['muscleBuildingExercises'] ?? 0,
//       cardioExercises: data['cardioExercises'] ?? 0,
//     );
//   }
// }

class WorkoutProgramsOverview extends StatelessWidget {
  final List<WorkoutPlanModel> programs;
  final ColorScheme colorScheme;

  const WorkoutProgramsOverview({
    super.key,
    required this.programs,
    required this.colorScheme,
  });

  // Helper method to build individual program item
  Widget _buildProgramItem(WorkoutPlanModel program) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      color: globalColorScheme.inversePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: globalColorScheme.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Program Name
            Text(
              program.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),

            // Exercise Overview in one row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCompactDetailItem(
                  icon: Icons.calendar_today,
                  label: '${program.weeks} Weeks',
                  color: colorScheme.primary,
                ),
                _buildCompactDetailItem(
                  icon: Icons.fitness_center,
                  label: '${program.muscleBuildingExercises} Muscle',
                  color: colorScheme.tertiary,
                ),
                _buildCompactDetailItem(
                  icon: Icons.run_circle,
                  label: '${program.cardioExercises} Cardio',
                  color: colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Compact detail item with icon and label
  Widget _buildCompactDetailItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        return _buildProgramItem(programs[index]);
      },
    );
  }
}

// Example Usage
class FitFlexTrainerWorkoutPage extends StatelessWidget {
  static const String route = "/fit-flex-workout-page";
  const FitFlexTrainerWorkoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final samplePrograms = [
      WorkoutPlanModel(
        uid: '',
        name: 'Strength Builder',
        weeks: [],
        totalExercises: 48,
        muscleBuildingExercises: 36,
        cardioExercises: 12,
      ),
      WorkoutPlanModel(
        uid: '',
        name: 'Fat Loss Accelerator',
        weeks: [],
        totalExercises: 40,
        muscleBuildingExercises: 20,
        cardioExercises: 20,
      ),
    ];

    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Workouts",
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: WorkoutProgramsOverview(
          programs: samplePrograms,
          colorScheme: colorScheme,
        ),
      ),
    );
  }
}
