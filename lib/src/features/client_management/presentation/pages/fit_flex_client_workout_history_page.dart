import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class FitFlexClientWorkoutHistoryPage extends StatefulWidget {
  static const String route = '/fit-flex-client-history';

  const FitFlexClientWorkoutHistoryPage({super.key});
  @override
  _FitFlexClientWorkoutHistoryPageState createState() =>
      _FitFlexClientWorkoutHistoryPageState();
}

class _FitFlexClientWorkoutHistoryPageState
    extends State<FitFlexClientWorkoutHistoryPage> {
  late PageController _dateController;
  late DateTime _selectedDate;
  final List<DateTime> _dates = List.generate(
    30,
    (index) => DateTime.now().subtract(Duration(days: index)),
  );

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateController = PageController(
      initialPage: 0,
      viewportFraction: 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        // padding: EdgeInsetsDirectional.only(bottom: 100),
        title: "History",
        context: context,
        backgroundColor: globalColorScheme.onPrimary,
        foregroundColor: globalColorScheme.primary,
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 40,
          // ),
          _buildDateSelector(),
          Expanded(
            child: _buildWorkoutList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      decoration: BoxDecoration(
        color: globalColorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: TableCalendar(
        headerVisible: true,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          tablePadding: EdgeInsets.all(10),
          todayDecoration: BoxDecoration(
            color: globalColorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: globalColorScheme.onPrimaryContainer,
          ),
          selectedDecoration: BoxDecoration(
            color: globalColorScheme.secondary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: globalColorScheme.onSecondary,
          ),
          weekendTextStyle: TextStyle(
            color: globalColorScheme.tertiary,
          ),
          defaultTextStyle: TextStyle(
            color: globalColorScheme.surface,
          ),
          defaultDecoration: BoxDecoration(
              // color: globalColorScheme.surface,
              ),
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronIcon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: globalColorScheme.onPrimaryContainer,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: globalColorScheme.onPrimaryContainer,
          ),
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: globalColorScheme.onBackground,
            fontSize: 20,
          ),
          decoration: BoxDecoration(
            color: globalColorScheme.inversePrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
        ),
        calendarFormat: CalendarFormat.week,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      ),
    );
  }

  Widget _buildWorkoutList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildExerciseCard(
          'Diamond Push-Ups',
          [
            WorkoutSet(reps: 6, weight: 12.5,targetReps: 12),
            WorkoutSet(reps: 4, weight: 17.5,targetReps: 10),
            WorkoutSet(reps: 5, weight: 20,targetReps: 8),
          ],
          Icons.fitness_center,
        ),
        _buildCardioCard(
          'Running',
          duration: '30 min',
          distance: '5.2 km',
          icon: Icons.directions_run,
        ),
      ],
    );
  }

  Widget _buildExerciseCard(
    String name,
    List<WorkoutSet> sets,
    IconData icon,
  ) {
    return Card(
      color: globalColorScheme.primary,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: globalColorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: globalColorScheme.tertiaryContainer, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...sets.map((set) => _buildSetRow(set)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardioCard(
    String name, {
    required String duration,
    required String distance,
    required IconData icon,
  }) {
    return Card(
      color: globalColorScheme.primary,
      elevation: 4,
      shadowColor: globalColorScheme.tertiary,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.red[700], size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: globalColorScheme.surface, thickness: 1),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildCardioMetric('Duration', duration),
                ),
                Expanded(
                  child: _buildCardioMetric('Distance', distance),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(WorkoutSet set) {
  final completionPercentage = set.completionPercentage.clamp(0, 100).toStringAsFixed(1);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        // Icon for completion
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: completionPercentage == '100.0'
                ? Colors.green[100]
                : globalColorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(
              completionPercentage == '100.0' ? Icons.check : Icons.timelapse,
              size: 18,
              color: completionPercentage == '100.0'
                  ? Colors.green[700]
                  : globalColorScheme.onPrimaryContainer,
            ),
          ),
        ),
        SizedBox(width: 12),

        // Reps completed
        Text(
          '${set.reps}/${set.targetReps} Reps',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
        ),

        Spacer(),

        // Percentage of completion
        Text(
          '$completionPercentage%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: completionPercentage == '100.0'
                ? Colors.green[700]
                : globalColorScheme.tertiaryContainer,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildCardioMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}

class WorkoutSet {
  final int reps; // Actual reps done
  final int targetReps; // Target reps to be performed
  final double? weight;

  WorkoutSet({required this.reps, required this.targetReps, this.weight});

  double get completionPercentage => (reps / targetReps) * 100;
}
