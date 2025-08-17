import 'package:fit_flex_club/src/core/common/services/fcm_service.dart';
import 'package:fit_flex_club/src/core/common/services/local_notification_service.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/util/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class FitFlexTrainerDashboardPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final bool showBottomNavBar;

  static const String route = "/fit-flex-trainer-dashboard";
  const FitFlexTrainerDashboardPage({
    super.key,
    required this.navigationShell,
    this.showBottomNavBar = false,
  });

  @override
  State<FitFlexTrainerDashboardPage> createState() =>
      _FitFlexTrainerDashboardPageState();
}

class _FitFlexTrainerDashboardPageState
    extends State<FitFlexTrainerDashboardPage> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  // Track icon positions/sizes
  final List<GlobalKey> _iconKeys = List.generate(3, (_) => GlobalKey());
  double _indicatorX = 0;
  double _indicatorSize = 20; // default size

  final GlobalKey _parentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getIt<NetworkInfo>().isConnected?.then(
      (isConnected) async {
        if (isConnected) {
          LocalNotificationService.initialize(context).then(
            (value) async {
              await FCMService.initializeFCM();
            },
          );
        }
      },
    );
    selectedIndex.value = widget.navigationShell.currentIndex;

    // calculate initial position after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveIndicatorTo(selectedIndex.value);
    });
  }

  void _moveIndicatorTo(int index) {
    final key = _iconKeys[index];
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final parentBox =
        _parentKey.currentContext?.findRenderObject() as RenderBox?;

    if (box != null && parentBox != null) {
      // Get the icon position relative to the parent container
      final position = box.localToGlobal(Offset.zero, ancestor: parentBox);

      setState(() {
        // icon center relative to parent
        final iconCenterX = position.dx + box.size.width / 2;

        // indicator should align its center with icon center
        _indicatorSize = box.size.width; // OR clamp if you want
        _indicatorX = iconCenterX - _indicatorSize / 2;
      });
    }
  }

  Widget _buildBottomNavOverlay(BuildContext context, double width) {
    return Positioned(
      bottom: 0,
      left: width * 0.21,
      right: width * 0.21,
      child: Container(
        margin: EdgeInsets.symmetric(
          // horizontal: width * 0.3,
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
          key: _parentKey,
          children: [
            // moving indicator
            ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, currentIndex, _) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: _indicatorX,
                  child: Container(
                    width: 30,
                    height: 30,
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
                _buildIcon(
                  2,
                  Icons.campaign_rounded,
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
          // context.read<WorkoutManagementBloc>().add(GetWorkoutPlansEvent());
          // context.read<WorkoutManagementBloc>().add(GetWorkoutPlansEvent());
          // context.read<GetexercisesCubit>().getExercises();
        }
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
        _moveIndicatorTo(index);
      },
      child: ValueListenableBuilder<int>(
        valueListenable: valueNotifier,
        builder: (context, currentIndex, _) {
          bool isSelected = currentIndex == index;
          return Material(
            key: _iconKeys[index],
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (selectedIndex.value == 0) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Fit Blitz",
            message: 'Want to exit ?',
            cancelText: 'No',
            confirmText: 'Yes',
            onConfirm: () {
              // SystemChannels;
              SystemNavigator.pop();
            },
          );
        } else {
          selectedIndex.value = 0;
          widget.navigationShell.goBranch(
            0,
            initialLocation: true,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Main content
            widget.navigationShell,
            // Bottom navigation overlay
            if (widget.showBottomNavBar) _buildBottomNavOverlay(context, width),
          ],
        ),
      ),
    );
  }
}
