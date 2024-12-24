import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flex_club/src/core/common/services/service_locator.dart';
import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dropdown.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_assigned_workout_plan_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/bloc/client_profile_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/clientweights/clientweights_cubit.dart';
import 'package:fit_flex_club/src/features/client_profile/presentation/getclientweights/getclientweights_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

// class FitFlexClientProfilePage extends StatefulWidget {
//   static const String route = "/fit-flex-client-profile";
//   const FitFlexClientProfilePage({super.key});

//   @override
//   State<FitFlexClientProfilePage> createState() =>
//       _FitFlexClientProfilePageState();
// }

// class _FitFlexClientProfilePageState extends State<FitFlexClientProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Placeholder(),
//     );
//   }
// }

class WorkoutPlanWidget extends StatefulWidget {
  final WorkoutPlanModel? workoutPlan;
  const WorkoutPlanWidget({super.key, this.workoutPlan});

  @override
  _WorkoutPlanWidgetState createState() => _WorkoutPlanWidgetState();
}

class _WorkoutPlanWidgetState extends State<WorkoutPlanWidget> {
  final bool _isDetailsVisible = false; // To toggle dropdown visibility

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<ClientProfileBloc, ClientProfileState>(
        // bloc: context.read<ClientProfileBloc>().add(event),
        builder: (context, state) {
          if (state is ClientProfileLoading) {
            return PlatformLoader().buildLoader(
              type: LoaderType.shimmer,
              highlightColor: globalColorScheme.primary,
              containerRadius: 30,
              height: 100,
            );
          }
          if (state is GetProfileComplete) {
            final client = state.entity;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: globalColorScheme.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: globalColorScheme.secondary.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Current Workout Program",
                    style: TextStyle(
                      fontSize: 14,
                      color: globalColorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          client.currentWorkoutPlanName ??
                              "No Program Assigned",
                          style: TextStyle(
                            fontSize:
                                client.currentWorkoutPlanName != null ? 22 : 18,
                            fontWeight: FontWeight.bold,
                            color: globalColorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      if (client.currentWorkoutPlanName != null)
                        PlatformButton().buildButton(
                          context: context,
                          type: ButtonType.iconText,
                          icon: Icons.arrow_forward_ios,
                          text: "Get Started",
                          foregroundColor: globalColorScheme.tertiary,
                          textStyle: TextStyle(
                            color: globalColorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            // if (widget.workoutPlan != null) {
                            print(
                                'Navigating to: ${FitFlexClientProfilePage.route}/${FitFlexClientAssignedWorkoutPlanPage.route}');
                            context.push(
                              '${FitFlexClientProfilePage.route}/${FitFlexClientAssignedWorkoutPlanPage.route}',
                              extra: {'workoutPlan': widget.workoutPlan},
                            );

                            // } else {}
                          },
                        )!
                    ],
                  ),
                ],
              ),
            );
          }
          return PlatformLoader().buildLoader(
            type: LoaderType.shimmer,
            containerRadius: 30,
            height: 100,
          );
        },
      ),
    );
  }

  // Helper method to build workout details
  Widget _buildWorkoutDetail({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: globalColorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: globalColorScheme.onPrimaryContainer.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// const Color primaryColor = Color(0xFFFFCD7C); // Light Amber
// const Color coolTeal = Color(0xFF00B3B8); // Secondary
// const Color softBlue = Color(0xFF8BB7D9); // Tertiary
// const Color warmBeige = Color(0xFFF1E6D4); // Background
// const Color offWhite = Color(0xFFF4F4F4); // Surface
// const Color vibrantCoral = Color(0xFFFF6F61); // Error
// const Color goldenYellow = Color(0xFFFFBC00); // Outline
// const Color deepNavyBlue = Color(0xFF1A2A3D);

class WeightGraphPainter extends CustomPainter {
  final Color lineColor;
  final Color pointColor;
  final List<ClientWeightEntity> entries;

  WeightGraphPainter({
    required this.lineColor,
    required this.pointColor,
    required this.entries,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (entries.isEmpty) return;

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final dotPaint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;

    // Text painter for weight labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final path = Path();

    // Find min and max weights for scaling
    double minWeight =
        entries.map((e) => e.weightInKg).reduce((a, b) => math.min(a, b));
    double maxWeight =
        entries.map((e) => e.weightInKg).reduce((a, b) => math.max(a, b));

    // Ensure there's a valid range
    if (maxWeight == minWeight) {
      minWeight -= 1.0;
      maxWeight += 1.0;
    }

    // Add padding for better visualization
    final padding = (maxWeight - minWeight) * 0.1;
    minWeight -= padding;
    maxWeight += padding;

    void drawWeightLabel(double x, double y, double weight, bool isAbove) {
      if (x.isNaN || y.isNaN) return; // Ensure valid coordinates
      textPainter.text = TextSpan(
        text: '${weight.toStringAsFixed(1)} Kg',
        style: TextStyle(
            color: globalColorScheme.secondaryContainer, fontSize: 12),
      );
      textPainter.layout();

      // Position the text above or below the point
      final yOffset = isAbove ? -30.0 : 20.0;
      final xOffset = textPainter.width / 2;

      textPainter.paint(
        canvas,
        Offset(x - xOffset, y + yOffset),
      );
    }

    void addPoint(double x, double y, Path path, int index) {
      if (x.isNaN || y.isNaN) return; // Ensure valid coordinates
      if (index == 0) {
        path.moveTo(x, y);
      } else {
        final double previousX =
            (index - 1) * size.width / (entries.length - 1);
        final double previousY = size.height -
            ((entries[index - 1].weightInKg - minWeight) /
                    (maxWeight - minWeight)) *
                size.height;

        // Calculate control points for smooth curves
        final double controlX1 = previousX + (x - previousX) / 2;
        final double controlX2 = x - (x - previousX) / 2;

        path.cubicTo(controlX1, previousY, controlX2, y, x, y);
      }

      // Draw the point
      canvas.drawCircle(Offset(x, y), 4, dotPaint);

      // Draw weight label (alternating above/below)
      bool isAbove = index % 2 == 0;
      drawWeightLabel(x, y, entries[index].weightInKg, isAbove);
    }

    for (int i = 0; i < entries.length; i++) {
      final double x = i * size.width / (entries.length - 1);
      final double scaleFactor = (maxWeight - minWeight) > 0
          ? (entries[i].weightInKg - minWeight) / (maxWeight - minWeight)
          : 0.0;
      final double y = size.height - scaleFactor * size.height;

      if (!x.isNaN && !y.isNaN) {
        addPoint(x, y, path, i);
      }
    }

    canvas.drawPath(path, paint);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final gradient = ui.Gradient.linear(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      [
        lineColor.withOpacity(0.2),
        lineColor.withOpacity(0.05),
      ],
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = gradient;

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Don't forget to add the ClientWeightEntity class if you haven't already:

class WeightTrackerScreen extends StatefulWidget {
  final String initialClientWeight;
  const WeightTrackerScreen({
    super.key,
    required this.initialClientWeight,
  });

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<Map<String, dynamic>> weightDifferenceInfo =
      ValueNotifier({});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: globalColorScheme.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: globalColorScheme.secondary.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Weight',
                      style: textTheme.titleMedium,
                    ),
                    ValueListenableBuilder(
                        valueListenable: weightDifferenceInfo,
                        builder: (context, weight, _) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                weight['currentWeight'] ??
                                    widget.initialClientWeight,
                                style: TextStyle(
                                  color: globalColorScheme.tertiary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'kg',
                                style: TextStyle(
                                  color: globalColorScheme.secondary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Row(
                                children: [
                                  if (weight['icon'] != null)
                                    Icon(
                                      weight['icon'] ?? Icons.add,
                                      color: globalColorScheme.onErrorContainer,
                                      size: 16,
                                    ),
                                  Text(
                                    weight['difference'] != null
                                        ? '${weight['difference'] ?? ''} (${weight['percentage'] ?? ''} %)'
                                        : '',
                                    style: TextStyle(
                                      color: globalColorScheme.onErrorContainer,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 4),
                  // const SizedBox(height: 4),
                  Column(
                    children: [
                      PlatformButton().buildButton(
                        context: context,
                        type: ButtonType.icon,
                        foregroundColor: globalColorScheme.onPrimaryContainer,
                        icon: Icons.add_circle_rounded,
                        height: 40,
                        text: '',
                        onPressed: () => PlatformDialog.showCustomDialog(
                          context: context,
                          title: "Add Weight",
                          actions: [
                            BlocProvider(
                              create: (context) => getIt<ClientweightsCubit>(),
                              child: BlocConsumer<ClientweightsCubit,
                                  ClientweightsState>(
                                builder: (context, state) {
                                  if (state is ClientweightsLoading) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: PlatformLoader().buildLoader(
                                            type: LoaderType.circular,
                                            size: 30),
                                      ),
                                    );
                                  }
                                  return PlatformButton().buildButton(
                                    context: context,
                                    type: ButtonType.primary,
                                    textStyle: TextStyle(
                                      color:
                                          globalColorScheme.onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: 'Submit',
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        if (weightController.text.isNotEmpty) {
                                          context
                                              .read<ClientweightsCubit>()
                                              .addClientWeight(
                                                ClientWeightEntity(
                                                  clientId:
                                                      getIt<FirebaseAuth>()
                                                          .currentUser!
                                                          .uid,
                                                  timeStamp: DateTime.now()
                                                      .millisecondsSinceEpoch,
                                                  weightInKg: double.tryParse(
                                                          weightController
                                                              .text) ??
                                                      0,
                                                  weightInLb:
                                                      convertLbToKgDouble(
                                                    double.tryParse(
                                                          weightController.text,
                                                        ) ??
                                                        0,
                                                  ),
                                                ),
                                              );
                                        }
                                      }
                                    },
                                  )!;
                                },
                                listener: (context, state) {
                                  if (state is ClientweightsComplete) {
                                    context
                                        .read<GetclientweightsCubit>()
                                        .getClientWeights();
                                    context.pop();
                                    weightController.clear();
                                  }
                                },
                              ),
                            ),
                          ],
                          content: SizedBox(
                            height: 75,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  AppTextFields.prefixSuffixTextField(
                                    controller: weightController,
                                    labelText: 'Weight in (kgs)',
                                    // suffix: Container(
                                    //   decoration: BoxDecoration(
                                    //     color: globalColorScheme.surface,
                                    //     borderRadius: BorderRadius.circular(
                                    //       15,
                                    //     ),
                                    //   ),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 25, vertical: 5),
                                    //     child: Text(
                                    //       'kg',
                                    //       style: TextStyle(
                                    //         fontSize: 17,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color:
                                          globalColorScheme.onPrimaryContainer,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )!
                    ],
                  ),
                ],
              ),
            ],
          ),
          WeightTrackerGraph(
            weightDifferenceInfo: weightDifferenceInfo,
          )
        ],
      ),
    );
  }
}

// ClientWeightEntity class
Widget _buildStatItem(String label, String value, String unit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          color: globalColorScheme.onPrimaryContainer,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 4),
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            value,
            style: TextStyle(
              color: globalColorScheme.tertiary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            unit,
            style: TextStyle(
              color: globalColorScheme.secondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ],
  );
}

// WeightTrackerGraph Widget
class WeightTrackerGraph extends StatefulWidget {
  final ValueNotifier<Map<String, dynamic>> weightDifferenceInfo;

  const WeightTrackerGraph({
    super.key,
    required this.weightDifferenceInfo,
  });

  @override
  State<WeightTrackerGraph> createState() => _WeightTrackerGraphState();
}

class _WeightTrackerGraphState extends State<WeightTrackerGraph> {
  final ValueNotifier<List<ClientWeightEntity>?> currentWeights =
      ValueNotifier(null);
  List<ClientWeightEntity>? _originalWeights;
  late final List<Map<String, String>> _lastFourMonths;
  late Map<String, String> _selectedMonth;

  // Map<String, dynamic> weightDifferenceInfo = {};

  void calculateWeightDifference() {
    if (currentWeights.value != null &&
        ((currentWeights.value?.length ?? 0) >= 2)) {
      // Get the last two weights
      final lastWeight = currentWeights.value!.last.weightInKg;
      final secondLastWeight =
          currentWeights.value![currentWeights.value!.length - 2].weightInKg;

      // Calculate the difference
      final difference = lastWeight - secondLastWeight;

      // Calculate percentage change
      final percentageChange = (difference / secondLastWeight) * 100;

      // Determine the icon
      final icon = difference >= 0 ? Icons.arrow_upward : Icons.arrow_downward;

      // Update the map
      widget.weightDifferenceInfo.value = {
        'currentWeight': lastWeight.toStringAsFixed(2),
        'icon': icon,
        'difference': difference
            .abs()
            .toStringAsFixed(2), // Show absolute value for difference
        'percentage': percentageChange
            .abs()
            .toStringAsFixed(2), // Show absolute value for percentage
      };
    } else {
      // If there are not enough weights, reset the map
      widget.weightDifferenceInfo.value = {};
    }
  }

  @override
  void initState() {
    super.initState();

// Example: Adding a listener to recalculate when weights change
    currentWeights.addListener(() {
      calculateWeightDifference();
    });

    final now = DateTime.now();

    final List<Map<String, String>> lastFourMonths = List.generate(
      4,
      (index) {
        final date = DateTime(now.year, now.month - index, 1);
        final key = "${date.month.toString().padLeft(2, '0')}-${date.year}";
        final value =
            "${_monthAbbreviation(date.month)}-${date.year.toString().substring(2)}";
        return {key: value};
      },
    );

    // Set default selection and filter weights
    _lastFourMonths = lastFourMonths;
    _selectedMonth = lastFourMonths.first;
    _filterWeights(_selectedMonth);
  }

  String _monthAbbreviation(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  void _filterWeights(Map<String, String> monthYear) {
    final monthYearParts = monthYear.keys.first.split('-');
    final selectedMonth = int.parse(monthYearParts[0]);
    final selectedYear = int.parse(monthYearParts[1]);

    final filteredWeights = _originalWeights?.where((entry) {
      final entryDate = DateTime.fromMillisecondsSinceEpoch(entry.timeStamp);
      return entryDate.month == selectedMonth && entryDate.year == selectedYear;
    }).toList();

    currentWeights.value = filteredWeights;
  }

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetclientweightsCubit, GetclientweightsState>(
      listener: (context, state) {
        if (state is GetclientweightsLoading) {
          isLoading.value = true;
        }
        if (state is GetclientweightsComplete) {
          currentWeights.value = state.weights;
          _originalWeights = state.weights;
          isLoading.value = false;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: currentWeights,
        builder: (context, value, child) {
          if (value == null) {
            return ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, ifLoading, child) {
                if (ifLoading) {
                  return SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: globalColorScheme.tertiaryContainer,
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text('Your weight tracker for the last 4 months.'),
                const SizedBox(height: 5),
                PlatformSpecificDropdown(
                  onTap: (value) {
                    context.pop();
                  },
                  initialValue: _selectedMonth,
                  options: _lastFourMonths,
                  onChanged: (selected) {
                    setState(() {
                      _selectedMonth = selected;
                      _filterWeights(_selectedMonth);
                    });
                  },
                ),
                if (value.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'No weight tracking available for this month.',
                      ),
                    ),
                  )
                else if ((value.length == 1))
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Update your weight weekly to track the progress.',
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 200,
                      child: CustomPaint(
                        painter: WeightGraphPainter(
                          entries: value,
                          lineColor: globalColorScheme.onPrimaryContainer,
                          pointColor: globalColorScheme.tertiaryContainer,
                        ),
                        size: Size.infinite,
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}

class WorkoutActionButton extends StatefulWidget {
  final VoidCallback onTap;

  const WorkoutActionButton({
    super.key,
    required this.onTap,
  });

  @override
  State<WorkoutActionButton> createState() => _WorkoutActionButtonState();
}

class _WorkoutActionButtonState extends State<WorkoutActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Animated background effect
              Transform.scale(
                  scale: _glowAnimation.value,
                  child: Transform.rotate(
                    angle: 35,
                    child: Icon(
                      Icons.bolt,
                      color: globalColorScheme.secondary.withOpacity(0.3),
                      size: 150,
                    ),
                  )),
              // Icon
              Transform.rotate(
                angle: 60,
                child: Icon(
                  Icons.bolt,
                  color: globalColorScheme.primary,
                  size: 100,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FitFlexClientProfilePage extends StatefulWidget {
  static const String route = "/fit-flex-client-profile";

  const FitFlexClientProfilePage({super.key});

  @override
  State<FitFlexClientProfilePage> createState() =>
      _FitFlexClientProfilePageState();
}

class _FitFlexClientProfilePageState extends State<FitFlexClientProfilePage> {
  ValueNotifier<WorkoutPlanModel?> workoutPlanModel = ValueNotifier(null);
  ValueNotifier<ClientEntity?> clientValue = ValueNotifier(null);
  @override
  void initState() {
    super.initState();

    context.read<WorkoutManagementBloc>().add(GetExercisesEvent());
    context.read<ClientProfileBloc>().add(GetClientByIdEvent(clientId: null));
    // context.read<GetclientweightsCubit>().getClientWeights();
  }

// On Surface
  final Color darkerTeal = const Color(0xFF006F6F);
  // Darker Secondary (For contrast)
  final ColorScheme customColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFFCD7C),
    onPrimary: Colors.white,
    secondary: Color(0xFF00B3B8),
    onSecondary: Colors.white,
    surface: Color(0xFFF4F4F4),
    onSurface: Color(0xFF1A2A3D),
    error: Color(0xFFFF6F61),
    onError: Colors.white,
    outline: Color(0xFFFFBC00),
    shadow: Colors.black54,
    tertiary: Color(0xFF8BB7D9),
    onTertiary: Color(0xFF1A2A3D),
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: globalColorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Stack(
              children: [
                SizedBox(
                  height: height * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      // bottomRight: Radius.circular(50),
                    ),
                    child: Image.asset(
                      'assets/images/fit_flex_app_bar_image.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                    color: globalColorScheme.onPrimaryContainer,
                    gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      begin: Alignment.centerRight,
                      end: Alignment.topLeft,
                      colors: [
                        globalColorScheme.onErrorContainer,
                        globalColorScheme.onPrimaryContainer,
                        globalColorScheme.onPrimaryContainer
                            .withOpacity(0.7), // More transparent
                        Colors.transparent, // Fully transparent
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(
                        50,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * .05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PlatformButton().buildButton(
                                context: context,
                                type: ButtonType.icon,
                                icon: Icons.logout,
                                foregroundColor:
                                    globalColorScheme.inversePrimary,
                                text: "",
                                onPressed: () => context
                                    .read<AuthenticationBloc>()
                                    .add(LogOutAuthenticationEvent()),
                              )!,
                            ],
                          ),
                          SizedBox(height: height * .1),
                          Text(
                            intl.DateFormat.MMMEd().format(DateTime.now()),
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          BlocConsumer<ClientProfileBloc, ClientProfileState>(
                            listener: (context, state) {
                              if (state is GetProfileComplete) {
                                clientValue.value = state.entity;
                                context
                                    .read<GetclientweightsCubit>()
                                    .getClientWeights();
                              }
                            },
                            builder: (context, state) {
                              if (state is GetProfileComplete) {
                                final client = state.entity;
                                return Text(
                                  client.username ?? "User",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Text('');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: WorkoutActionButton(
                    onTap: () {},
                  ),
                )
              ],
            ),
            // Workout Plan Tile

            BlocListener<WorkoutManagementBloc, WorkoutManagementState>(
              listener: (context, state) {
                if (state is GetWorkoutPlansForClientLoading) {
                  // PlatformDialog.showLoadingDialog(
                  //   context: context,
                  //   message: "Fetching workout plan details for you...",
                  // );
                }

                if (state is GetWorkoutPlansForClientComplete) {
                  // workoutPlanModel.value = state.workoutPlan;
                  // context.pop();
                }
              },
              child: ValueListenableBuilder(
                valueListenable: workoutPlanModel,
                builder: (context, workoutPlan, _) {
                  return WorkoutPlanWidget(
                    workoutPlan: workoutPlan,
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: clientValue,
              builder: (context, client, _) {
                if (client != null) {
                  return WeightTrackerScreen(
                    initialClientWeight: client.weightInKg.toString(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: PlatformLoader().buildLoader(
                      type: LoaderType.shimmer,
                      containerRadius: 30,
                      height: 100,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Graph
// class WeightGraphPainter extends CustomPainter {
//   final List<double> points;
//   final Color lineColor;
//   final Color pointColor;

//   WeightGraphPainter({
//     required this.points,
//     required this.lineColor,
//     required this.pointColor,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = lineColor
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke;

//     final pointPaint = Paint()..color = pointColor;

//     final path = Path();
//     final step = size.width / (points.length - 1);

//     for (int i = 0; i < points.length; i++) {
//       final x = i * step;
//       final y = size.height - (points[i] / 100 * size.height);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//       canvas.drawCircle(Offset(x, y), 6, pointPaint);
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
