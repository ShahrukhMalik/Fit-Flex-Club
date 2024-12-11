import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FitFlexTrainerDashboardPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  static const String route = "/fit-flex-trainer-dashboard";
  const FitFlexTrainerDashboardPage({
    super.key,
    required this.navigationShell,
  });

  @override
  State<FitFlexTrainerDashboardPage> createState() =>
      _FitFlexTrainerDashboardPageState();
}

class _FitFlexTrainerDashboardPageState
    extends State<FitFlexTrainerDashboardPage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    selectedIndex.value = widget.navigationShell.currentIndex;
  }

  Widget _buildBottomNavOverlay(BuildContext context, double width) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.3,
          vertical: 30,
        ),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: globalColorScheme.onPrimaryContainer,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, currentIndex, _) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: currentIndex * (width * 0.24),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          globalColorScheme.surfaceContainer.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildIcon(
                  0,
                  Icons.person,
                  selectedIndex,
                  widget.navigationShell,
                ),
                _buildIcon(
                  1,
                  Icons.fitness_center,
                  selectedIndex,
                  widget.navigationShell,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    int index,
    IconData icon,
    ValueNotifier<int> valueNotifier,
    StatefulNavigationShell navigationShell,
  ) {
    return GestureDetector(
      onTap: () {
        valueNotifier.value = index;
        if (index == 1) {
          // context.read<WorkoutManagementBloc>().add(GetExercisesEvent());
          context.read<WorkoutManagementBloc>().add(GetWorkoutPlansEvent());
        }
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      child: ValueListenableBuilder<int>(
        valueListenable: valueNotifier,
        builder: (context, currentIndex, _) {
          bool isSelected = currentIndex == index;
          return Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              splashColor: globalColorScheme.tertiaryContainer.withOpacity(0.4),
              highlightColor:
                  globalColorScheme.surfaceContainer.withOpacity(0.2),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: isSelected
                    ? BoxDecoration(
                        color: globalColorScheme.surfaceContainer,
                        shape: BoxShape.circle,
                      )
                    : null,
                padding: EdgeInsets.all(15),
                child: Icon(
                  icon,
                  color: isSelected
                      ? globalColorScheme.tertiaryContainer
                      : globalColorScheme.surfaceContainer,
                  size: isSelected ? 28 : 24,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          widget.navigationShell,
          // Bottom navigation overlay
          _buildBottomNavOverlay(context, width),
        ],
      ),
    );
  }
}