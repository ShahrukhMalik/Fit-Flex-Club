import 'dart:math';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_exercise_tile_widget.dart';
import 'package:fit_flex_club/src/features/workout_tracking/presentation/pages/fit_flex_workout_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class AutoScrollTabsWidget extends StatefulWidget {
  final bool isClientSideView;

  final ValueNotifier<List<DayModel>> days;
  final ValueNotifier<List<WeekModel>> weeks;
  final ValueNotifier<List<ExerciseModel>> exercises;
  final ValueNotifier<DayModel?> currentDay;
  final ValueNotifier<WeekModel?> currentWeek;
  final Function(int) onDayTap;
  final Function(ExerciseModel editExercise, bool edit, bool delete) onDrag;

  final WorkoutPlanModel? workoutPlan;

  const AutoScrollTabsWidget({
    super.key,
    required this.days,
    required this.weeks,
    required this.exercises,
    required this.currentDay,
    required this.currentWeek,
    required this.onDayTap,
    required this.onDrag,
    this.workoutPlan,
    this.isClientSideView = false,
  });

  @override
  _AutoScrollTabsWidgetState createState() => _AutoScrollTabsWidgetState();
}

class _AutoScrollTabsWidgetState extends State<AutoScrollTabsWidget> {
  final ScrollController horizontalScrollController = ScrollController();
  final GlobalKey tabsRowWidthKey = GlobalKey();
  List<GlobalKey> tabKeys = [];

  @override
  void initState() {
    super.initState();
    tabKeys = List.generate(widget.days.value.length, (index) => GlobalKey());
  }

  void scrollToTab(int index) {
    final RenderBox? renderBox =
        tabsRowWidthKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final viewportWidth = renderBox.constraints.maxWidth;
    final tabWidth = tabKeys[index].currentContext?.size?.width ?? 0.0;

    double scrollOffset =
        (index * tabWidth) - (viewportWidth / 2) + (tabWidth / 2);

    scrollOffset = scrollOffset.clamp(
      0.0,
      horizontalScrollController.position.maxScrollExtent,
    );

    horizontalScrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(builder: (context) {
        return Column(
          children: [
            SizedBox(
              key: tabsRowWidthKey,
              height: 50,
              child: ListView.builder(
                controller: horizontalScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: tabKeys.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    key: tabKeys[index],
                    onTap: () {
                      scrollToTab(index);
                      widget.onDayTap(index);
                    },
                    child: ValueListenableBuilder(
                      valueListenable: widget.currentDay,
                      builder: (context, currentDay, _) {
                        return Container(
                          width: 100, // Example tab width
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: currentDay?.dayNumber == (index + 1)
                                ? globalColorScheme.tertiary
                                : globalColorScheme.surface,
                            border: Border.all(
                              width: 1,
                              color: globalColorScheme.primaryContainer,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          // color: Colors.blue,
                          child: Text(
                            'Day ${index + 1}',
                            style: TextStyle(
                              color: currentDay?.dayNumber == (index + 1)
                                  ? globalColorScheme.primary
                                  : globalColorScheme.primaryContainer,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ValueListenableBuilder(
                  valueListenable: widget.exercises,
                  builder: (context, exercises, _) {
                    if (exercises.isEmpty) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: globalColorScheme.onErrorContainer,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'No Exercises Added!',
                              style: TextStyle(
                                fontSize: 18,
                                color: globalColorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            if (!widget.isClientSideView) {
                              return Slidable(
                                key: UniqueKey(),
                                startActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      padding: EdgeInsets.zero,
                                      onPressed: (context) => widget.onDrag(
                                          exercises[index], true, false),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor:
                                          globalColorScheme.onPrimaryContainer,
                                      icon: Icons.edit_note,
                                    ),
                                    SlidableAction(
                                      padding: EdgeInsets.zero,
                                      onPressed: (context) => widget.onDrag(
                                          exercises[index], false, true),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor:
                                          globalColorScheme.onErrorContainer,
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: ExerciseTileWidget(
                                  index: index,
                                  exercise: exercises[index],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () => context.go(
                                  FitFlexWorkoutTrackerPage.route,
                                  extra: {
                                    'exercise': exercises[index],
                                    'workoutPlan': widget.workoutPlan,
                                    'week': widget.currentWeek.value,
                                    'day': widget.currentDay.value,
                                  },
                                ),
                                child: ExerciseTileWidget(
                                  index: index,
                                  exercise: exercises[index],
                                ),
                              );
                            }
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
