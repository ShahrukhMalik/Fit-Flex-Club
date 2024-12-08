import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:flutter/material.dart';

class WeekTile extends StatelessWidget {
  final ValueNotifier<WeekModel?> currentWeek;
  final Function(int) onWeekTap;
  final int weekNumber;

  const WeekTile({
    super.key,
    required this.weekNumber,
    required this.currentWeek,
    required this.onWeekTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentWeek,
      builder: (context, currentWeek, _) {
        return GestureDetector(
          onTap: () => onWeekTap(weekNumber - 1),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 130,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: currentWeek?.weekNumber == weekNumber
                  ? globalColorScheme.tertiary
                  : globalColorScheme.surface,
              border: Border.all(
                width: 1,
                color: globalColorScheme.primaryContainer,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Week $weekNumber',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: globalColorScheme.primaryContainer,
                  ),
                ),
                Icon(
                  size: 50,
                  Icons.fitbit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




