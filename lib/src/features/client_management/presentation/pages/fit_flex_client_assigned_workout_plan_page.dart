import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FitFlexClientAssignedWorkoutPlanPage extends StatefulWidget {
  static const String route = "/fit-flex-assigned-workout-plan";
  const FitFlexClientAssignedWorkoutPlanPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FitFlexClientAssignedWorkoutPlanPageState createState() =>
      _FitFlexClientAssignedWorkoutPlanPageState();
}

class _FitFlexClientAssignedWorkoutPlanPageState
    extends State<FitFlexClientAssignedWorkoutPlanPage>
    with SingleTickerProviderStateMixin {
  int selectedWeek = 0;
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
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
    return Container(
      color: globalColorScheme.surface,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, workoutIndex) {
          return WorkoutTile(
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of weeks
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return WeekTile(weekNumber: index + 1);
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
        width: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              globalColorScheme.inversePrimary,
              globalColorScheme.primary,
              globalColorScheme.primaryContainer,
              globalColorScheme.tertiary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week $weekNumber',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: globalColorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor:
                  AlwaysStoppedAnimation<Color>(globalColorScheme.secondary),
            ),
            const SizedBox(height: 10),
            Text(
              'Workouts: $completedWorkouts/$totalWorkouts',
              style: TextStyle(
                fontSize: 14,
                color: globalColorScheme.surface,
              ),
            ),
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

class WorkoutTile extends StatelessWidget {
  final String workoutName;
  final String difficulty;
  final int sets;
  final int progress; // Progress in percentage (0-100)
  final bool isCompleted; // Indicates workout status

  const WorkoutTile({
    super.key,
    required this.workoutName,
    required this.difficulty,
    required this.sets,
    required this.progress,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = globalColorScheme;

    return Card(
      color: colorScheme.inversePrimary,
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout Name and Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  workoutName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? globalColorScheme.surface.withOpacity(0.8)
                        : globalColorScheme.secondary.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    isCompleted ? "Completed" : "Pending",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? globalColorScheme.primaryContainer
                          : globalColorScheme.tertiaryContainer,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Difficulty and Sets Information
            Row(
              children: [
                const SizedBox(width: 8),
                Platform.isIOS
                    ? CupertinoChip(
                        label: 'Sets: $sets',
                        backgroundColor: colorScheme.secondary.withOpacity(0.5),
                        textColor: colorScheme.onPrimaryContainer,
                      )
                    : Chip(
                        label: Text(
                          'Sets: $sets',
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                        backgroundColor: colorScheme.secondary.withOpacity(0.5),
                      ),
              ],
            ),

            const SizedBox(height: 16),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 10,
                    color: isCompleted ? Colors.green : colorScheme.primary,
                    backgroundColor: colorScheme.onSurface.withOpacity(0.1),
                  ),
                ),
                if (progress < 100)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "$progress% Completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
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
