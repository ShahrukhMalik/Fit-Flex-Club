import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/features/workout_history/data/models/workout_history_model.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(null);

  List<WorkoutHistoryModel?>? originalWorkoutHistoryModels;

  final ValueNotifier<List<ExerciseModel?>?> _workoutHistoryModelsDateWise =
      ValueNotifier([]);

  final List<DateTime> _dates = List.generate(
    30,
    (index) => DateTime.now().subtract(Duration(days: index)),
  );

  void _updateWorkoutHistory(DateTime? selectedDay) {
    if (selectedDay == null) {
      // If no date is selected, reset the workout history
      // _workoutHistoryModelsDateWise.value = originalWorkoutHistoryModels;
      return;
    }

    final existingList = originalWorkoutHistoryModels;

    // Filter the list to find exercises for the selected date
    final filteredExercises = existingList?.where((element) {
      final workoutDate = element?.workoutLogDate;
      final selectedDate = _selectedDate.value;

      if (workoutDate == null || selectedDate == null) {
        return false;
      }

      // Compare year, month, and day for equality
      return workoutDate.year == selectedDate.year &&
          workoutDate.month == selectedDate.month &&
          workoutDate.day == selectedDate.day;
    }).toList(); // Convert the iterable to a list

    // Assign the exercises for the selected date, or an empty list if none found
    _workoutHistoryModelsDateWise.value = filteredExercises?.isNotEmpty == true
        ? filteredExercises?.first?.exerciseModels
        : [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDate.value = DateTime.now();
    _dateController = PageController(
      initialPage: 0,
      viewportFraction: 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size(
          width,
          height * 0.2,
        ),
        child: _buildDateSelector(),
      ),
      body: Column(
        children: [
          // ,
          Expanded(
            child: _buildWorkoutList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 10, left: 20, right: 20),
      // margin: EdgeInsets.only(top: 0, bottom: 10, left: 0, right: 0),
      decoration: BoxDecoration(
        color: globalColorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: ValueListenableBuilder(
          valueListenable: _selectedDate,
          builder: (context, selectedDate, _) {
            return TableCalendar(
              calendarBuilders: CalendarBuilders(),
              onDaySelected: (selectedDay, focusedDay) {
                // print(selectedDay);
                _selectedDate.value = selectedDay;
                _updateWorkoutHistory(selectedDay);
              },
              headerVisible: true,
              weekNumbersVisible: true,
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
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
                  color: globalColorScheme.onSurface,
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
            );
          }),
    );
  }

  Widget _buildWorkoutList() {
    return BlocListener<WorkoutHistoryBloc, WorkoutHistoryState>(
      listener: (context, state) {
        if (state is GetWorkoutHistoryLoading) {
          // return SingleChildScrollView(
          //   child: Column(
          //     children: List.generate(
          //       6,
          //       (index) => Padding(
          //         padding: const EdgeInsets.all(10),
          //         child: PlatformLoader().buildLoader(
          //           type: LoaderType.shimmer,
          //           height: 100,
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        }
        if (state is GetWorkoutHistoryComplete) {
          originalWorkoutHistoryModels = state.workoutHistory;
          _updateWorkoutHistory(_selectedDate.value);
          // _workoutHistoryModelsDateWise.value = originalWorkoutHistoryModels;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: _workoutHistoryModelsDateWise,
        builder: (context, histories, child) {
          if (histories == null) {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: PlatformLoader().buildLoader(
                      type: LoaderType.shimmer,
                      height: 100,
                    ),
                  ),
                ),
              ),
            );
          } else if (histories.isEmpty) {
            return Center(
              child: Text(
                'No workouts found for this date.',
                style: TextStyle(color: Colors.black87),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: histories.length,
                itemBuilder: (context, index) {
                  final exercise = histories[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: globalColorScheme.primary,
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
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Index Circle
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor:
                                      globalColorScheme.onPrimaryContainer,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title and Subtitle
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  exercise?.name ?? "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: globalColorScheme
                                                        .tertiaryContainer,
                                                  ),
                                                ),
                                                Text(
                                                  exercise?.muscleGroup ?? "",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: globalColorScheme
                                                        .tertiary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Tag (e.g., Hypertrophy)
                                          if (exercise?.category != null)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 4.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: globalColorScheme
                                                    .onPrimaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                exercise?.category ?? "",
                                                style: TextStyle(
                                                  color:
                                                      globalColorScheme.primary,
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
                        Divider(),
                        ...exercise!.sets.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final set = entry.value;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Table(
                                border: TableBorder.all(
                                    borderRadius: BorderRadius.circular(10),
                                    width: 1,
                                    color: globalColorScheme.surface),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                // border: TableBorder.all(color: Colors.grey),
                                columnWidths: exercise.parameters?['weight'] ||
                                        exercise.parameters?['duration']
                                    ? {
                                        0: FlexColumnWidth(2), // Set #
                                        1: FlexColumnWidth(1), // Reps
                                        2: FlexColumnWidth(1), // Weight
                                        3: FlexColumnWidth(2), // Actions
                                      }
                                    : {
                                        0: FlexColumnWidth(1), // Set #
                                        1: FlexColumnWidth(2), // Reps
                                        2: FlexColumnWidth(2), // Weight
                                        3: FlexColumnWidth(2),
                                      },
                                children: [
                                  // Table Header
                                  TableRow(
                                    // decoration: BoxDecoration(color: globalColorScheme.secondary),
                                    children: [
                                      Center(
                                        child: Text(
                                          'Set ${index + 1}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Target',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Actual',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Completion',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (exercise.parameters?['reps'] ?? false)
                                    TableRow(
                                      // decoration: BoxDecoration(color: globalColorScheme.secondary),
                                      children: [
                                        Center(
                                          child: Text(
                                            'Reps',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            set.targetReps.toString(),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            set.actualReps != null
                                                ? set.actualReps.toString()
                                                : "0",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: globalColorScheme
                                                    .secondaryContainer),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${(((set.actualReps ?? 0) / (set.targetReps ?? 0)) * 100).toStringAsFixed(2)} %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    globalColorScheme.tertiary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (exercise.parameters?['weight'] ?? false)
                                    TableRow(
                                      // decoration: BoxDecoration(color: globalColorScheme.secondary),
                                      children: [
                                        Center(
                                          child: Text(
                                            'Weights(in kgs)',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            set.targetWeight.toString(),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            set.actualWeight != null
                                                ? set.actualWeight.toString()
                                                : "0",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: globalColorScheme
                                                  .secondaryContainer,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${(((set.actualWeight ?? 0) / (set.targetWeight ?? 0)) * 100).toStringAsFixed(2)} %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    globalColorScheme.tertiary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (exercise.parameters?['duration'] ?? false)
                                    TableRow(
                                      // decoration: BoxDecoration(color: globalColorScheme.secondary),
                                      children: [
                                        Center(
                                          child: Text(
                                            'Duration(in mins)',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            (set.targetTime?.inMinutes ?? 0)
                                                .toString(),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            (set.actualTime?.inMinutes ?? 0)
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: globalColorScheme
                                                  .secondaryContainer,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${(((set.actualTime!.inMinutes) / set.targetTime!.inMinutes) * 100).toStringAsFixed(2)} %',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    globalColorScheme.tertiary),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                        // Column(
                        //   children: List<Widget>.from(
                        //     exercise!.sets.map(
                        //       (e) => Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text('Set ${exercise.sets.indexOf(e)}'),
                        //           if (exercise.parameters?['weight'] ?? false)
                        //             _buildProgressRow(
                        //               'Weight',
                        //               e.targetWeight,
                        //               e.actualWeight,
                        //               e.weightProgress,
                        //             ),
                        //           if (exercise.parameters?['reps'] ?? false)
                        //             _buildProgressRow(
                        //               'Reps',
                        //               e.targetReps,
                        //               e.actualReps,
                        //               e.weightProgress,
                        //             ),
                        //           if (exercise.parameters?['duration'] ?? false)
                        //             _buildProgressRow(
                        //               'Duration',
                        //               e.targetTime?.inMinutes,
                        //               e.actualTime?.inMinutes,
                        //               e.weightProgress,
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProgressRow(
      String label, num? target, num? actual, double? progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: ${actual ?? '-'} / ${target ?? '-'}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            progress != null ? '${progress.toStringAsFixed(1)}%' : 'N/A',
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
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
                child: Icon(icon,
                    color: globalColorScheme.tertiaryContainer, size: 24),
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
  final completionPercentage =
      set.completionPercentage.clamp(0, 100).toStringAsFixed(1);

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

class WorkoutSet {
  final int reps; // Actual reps done
  final int targetReps; // Target reps to be performed
  final double? weight;
  WorkoutSet({
    required this.reps,
    required this.targetReps,
    this.weight,
  });
  double get completionPercentage => (reps / targetReps) * 100;
}
