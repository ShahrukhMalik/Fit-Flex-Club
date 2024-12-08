
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_week_tile_widget.dart';

import 'package:flutter/material.dart';

class AutoScrollWeeksWidget extends StatefulWidget {
  final ValueNotifier<List<WeekModel>> weeks;
  final ValueNotifier<WeekModel?> currentWeek;
  final void Function({required String weekId}) updateDays;
  final void Function({required String weekId}) updateExercises;
  const AutoScrollWeeksWidget({
    super.key,
    required this.weeks,
    required this.currentWeek,
    required this.updateDays,
    required this.updateExercises,
  });

  @override
  State<AutoScrollWeeksWidget> createState() => _AutoScrollWeeksWidgetState();
}

class _AutoScrollWeeksWidgetState extends State<AutoScrollWeeksWidget> {
  final ScrollController horizontalScrollController = ScrollController();
  final GlobalKey weeksListKey = GlobalKey();
  List<GlobalKey> weeksKeys = [];

  @override
  void initState() {
    super.initState();
    weeksKeys =
        List.generate(widget.weeks.value.length, (index) => GlobalKey());
  }

  void scrollToTab(int index) {
    final RenderBox? renderBox =
        weeksListKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final viewportWidth = renderBox.constraints.maxWidth;
    final tabWidth = weeksKeys[index].currentContext?.size?.width ?? 0.0;

    double scrollOffset =
        (index * tabWidth) - (viewportWidth / 2) + (tabWidth / 2);

    scrollOffset = scrollOffset.clamp(
      0.0,
      horizontalScrollController.position.maxScrollExtent,
    );

    horizontalScrollController.animateTo(
      scrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ValueListenableBuilder(
        valueListenable: widget.weeks,
        builder: (context, weeks, _) {
          return ListView.builder(
            key: weeksListKey,
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: weeks.length, // Number of weeks
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return SizedBox(
                key: weeksKeys[index],
                child: WeekTile(
                  weekNumber: index + 1,
                  currentWeek: widget.currentWeek,
                  onWeekTap: (indexFromWeek) {
                    scrollToTab(index);
                    widget.currentWeek.value = weeks[indexFromWeek];
                    widget.updateDays(
                      weekId: weeks[indexFromWeek].id,
                    );
                    widget.updateExercises(
                      weekId: weeks[indexFromWeek].id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}