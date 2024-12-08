import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseTileWidget extends StatelessWidget {
  final ExerciseModel exercise;
  final int index;

  const ExerciseTileWidget({
    super.key,
    required this.exercise,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: globalColorScheme.surface,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        border: Border.all(
          color: globalColorScheme.primary,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Index Circle
              CircleAvatar(
                radius: 16,
                backgroundColor: globalColorScheme.onPrimaryContainer,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: globalColorScheme.primaryContainer,
                  ),
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
                                  color: globalColorScheme.tertiaryContainer,
                                ),
                              ),
                              Text(
                                exercise.muscleGroup ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: globalColorScheme.tertiary,
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
                              color: globalColorScheme.onPrimaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              exercise.category ?? "",
                              style: TextStyle(
                                color: globalColorScheme.primary,
                                fontSize: 12,
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
        ],
      ),
    );
  }
}