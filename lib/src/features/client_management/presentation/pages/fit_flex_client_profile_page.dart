import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';

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
  const WorkoutPlanWidget({super.key});

  @override
  _WorkoutPlanWidgetState createState() => _WorkoutPlanWidgetState();
}

class _WorkoutPlanWidgetState extends State<WorkoutPlanWidget> {
  bool _isDetailsVisible = false; // To toggle dropdown visibility

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    Text(
                      "Fat Loss",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: globalColorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: globalColorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      '60%',
                      style: TextStyle(
                        color: globalColorScheme.surface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dropdown Toggle Button
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _isDetailsVisible = !_isDetailsVisible; // Toggle visibility
            //     });
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Workout Details",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: deepNavyBlue,
            //         ),
            //       ),
            //       Icon(
            //         _isDetailsVisible
            //             ? Icons.keyboard_arrow_up
            //             : Icons.keyboard_arrow_down,
            //         color: deepNavyBlue,
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),

            // // Conditional Visibility of Details
            // if (_isDetailsVisible)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       _buildWorkoutDetail(
            //         icon: Icons.timer,
            //         title: "Duration",
            //         value: "45 mins",
            //         color: coolTeal,
            //       ),
            //       _buildWorkoutDetail(
            //         icon: Icons.fireplace,
            //         title: "Calories",
            //         value: "350 kcal",
            //         color: vibrantCoral,
            //       ),
            //       _buildWorkoutDetail(
            //         icon: Icons.fitness_center,
            //         title: "Exercises",
            //         value: "8",
            //         color: goldenYellow,
            //       ),
            //     ],
            //   ),
            // const SizedBox(height: 20),

            // Progress Bar Section
            Text(
              "Today's Progress",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: globalColorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: globalColorScheme.secondary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  height: 10,
                  width:
                      MediaQuery.of(context).size.width * 0.6, // 60% progress
                  decoration: BoxDecoration(
                    color: globalColorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      ..color = globalColorScheme.onPrimaryContainer
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
        entries.map((e) => e.weight).reduce((a, b) => math.min(a, b));
    double maxWeight =
        entries.map((e) => e.weight).reduce((a, b) => math.max(a, b));

    // Add some padding to min/max for better visualization
    final padding = (maxWeight - minWeight) * 0.1;
    minWeight -= padding;
    maxWeight += padding;

    // Store previous Y coordinate
    double? previousY;

    void drawWeightLabel(double x, double y, double weight, bool isAbove) {
      textPainter.text = TextSpan(
        text: '${weight.toStringAsFixed(1)} Kg',
        style:
            textTheme.labelLarge?.copyWith(color: globalColorScheme.tertiary),
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
      if (index == 0) {
        path.moveTo(x, y);
        previousY = y;
      } else {
        final double previousX =
            (index - 1) * size.width / (entries.length - 1);

        final double controlX1 = previousX + (x - previousX) / 2;
        final double controlX2 = x - (x - previousX) / 2;

        path.cubicTo(controlX1, previousY!, controlX2, y, x, y);
      }

      // Draw the point
      canvas.drawCircle(Offset(x, y), 4, dotPaint);

      // Draw weight label (alternating above/below)
      bool isAbove = index % 2 == 0;
      drawWeightLabel(x, y, entries[index].weight, isAbove);

      // Draw weight difference if not first point
      // if (index > 0) {
      //   double weightDiff = entries[index].weight - entries[index - 1].weight;
      //   String diffText =
      //       '${weightDiff >= 0 ? '+' : ''}${weightDiff.toStringAsFixed(1)}';

      //   textPainter.text = TextSpan(
      //     text: diffText,
      //     style: TextStyle(
      //       color: weightDiff >= 0 ? Colors.red[400] : Colors.green[400],
      //       fontSize: 12,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   );
      //   textPainter.layout();

      //   // Position the difference text in the middle between points
      //   double midX = (x + (index - 1) * size.width / (entries.length - 1)) / 2;
      //   double midY = (y + previousY!) / 2;

      //   textPainter.paint(
      //     canvas,
      //     Offset(midX - textPainter.width / 2, midY - textPainter.height / 2),
      //   );
      // }

      previousY = y;
    }

    for (int i = 0; i < entries.length; i++) {
      final double x = i * size.width / (entries.length - 1);
      final double y = size.height -
          ((entries[i].weight - minWeight) / (maxWeight - minWeight)) *
              size.height;

      addPoint(x, y, path, i);
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
        globalColorScheme.onPrimaryContainer.withOpacity(0.2),
        globalColorScheme.secondary.withOpacity(0.05),
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


class WeightTrackerScreen extends StatelessWidget {
  const WeightTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample weight data
    final weightData = [
      // ClientWeightEntity(date: DateTime(2023, 1, 1), weight: 92.3),
      ClientWeightEntity(date: DateTime(2023, 4, 1), weight: 80.4),
      ClientWeightEntity(date: DateTime(2023, 5, 1), weight: 83.8),
      ClientWeightEntity(date: DateTime(2023, 6, 1), weight: 90.22),
    ];

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
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Current Weight',
                  style: textTheme.titleMedium,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '90.22',
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
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: globalColorScheme.onErrorContainer,
                        size: 16,
                      ),
                      Text(
                        '4.2 (2.68%)',
                        style: TextStyle(
                          color: globalColorScheme.onErrorContainer,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Container(
              //   width: 60,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     color: Colors.blue.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(30),
              //   ),
              //   child: Center(
              //     child: Text(
              //       '60%',
              //       style: TextStyle(
              //         color: Colors.blue[300],
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),

          // Graph Section
          Container(
            height: 250,
            padding: const EdgeInsets.all(16),
            child: WeightTrackerGraph(
              entries: weightData,
              minWeight: 80.0,
              maxWeight: 95.0,
            ),
          ),

          // Additional Stats
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       _buildStatItem('Calories Burned', '1280', 'kcal'),
          //       _buildStatItem('Steps', '8,439', 'steps'),
          //       _buildStatItem('Distance', '6.2', 'km'),
          //     ],
          //   ),
          // ),
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
class WeightTrackerGraph extends StatelessWidget {
  final List<ClientWeightEntity> entries;
  final double minWeight;
  final double maxWeight;

  const WeightTrackerGraph({
    super.key,
    required this.entries,
    required this.minWeight,
    required this.maxWeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WeightGraphPainter(
        entries: entries,
        lineColor: globalColorScheme.onPrimaryContainer,
        pointColor: primaryColor,
      ),
      size: Size.infinite,
    );
  }
}

class WorkoutActionButton extends StatefulWidget {
  final VoidCallback onTap;

  const WorkoutActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

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
          return Container(
            // width: 50,
            // height: 50,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(12),
            //   gradient: LinearGradient(
            //     colors: [
            //       Colors.red.withOpacity(0.8),
            //       Colors.orange.withOpacity(0.8),
            //     ],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight,
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.red.withOpacity(0.3 * _glowAnimation.value),
            //       blurRadius: 8,
            //       spreadRadius: 2,
            //     ),
            //   ],
            // ),
            child: Stack(
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
                    )
                    // Container(
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: globalColorScheme.secondary.withOpacity(0.3),
                    //   ),
                    // ),
                    ),
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
            ),
          );
        },
      ),
    );
  }
}

class FitFlexClientProfilePage extends StatelessWidget {
  static const String route = "/fit-flex-client-profile";
// On Surface
  final Color darkerTeal =
      const Color(0xFF006F6F); // Darker Secondary (For contrast)

  final ColorScheme customColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFFCD7C),
    onPrimary: Colors.white,
    secondary: Color(0xFF00B3B8),
    onSecondary: Colors.white,
    surface: Color(0xFFF4F4F4),
    onSurface: Color(0xFF1A2A3D),
    background: Color(0xFFF1E6D4),
    onBackground: Color(0xFF1A2A3D),
    error: Color(0xFFFF6F61),
    onError: Colors.white,
    outline: Color(0xFFFFBC00),
    shadow: Colors.black54,
    tertiary: Color(0xFF8BB7D9),
    onTertiary: Color(0xFF1A2A3D),
  );

  const FitFlexClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final weightData = [
      ClientWeightEntity(date: DateTime(2023, 1, 1), weight: 92.3),
      ClientWeightEntity(date: DateTime(2023, 2, 1), weight: 89.5),
      ClientWeightEntity(date: DateTime(2023, 3, 1), weight: 85.7),
      ClientWeightEntity(date: DateTime(2023, 4, 1), weight: 80.4),
      ClientWeightEntity(date: DateTime(2023, 5, 1), weight: 83.8),
      ClientWeightEntity(date: DateTime(2023, 6, 1), weight: 90.22),
    ];
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
                                text: "",
                                onPressed: () => context
                                    .read<AuthenticationBloc>()
                                    .add(LogOutAuthenticationEvent()),
                              )!,
                            ],
                          ),
                          SizedBox(height: height * .1),
                          Text(
                            "May 27, 2023",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Hi, Hassan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
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

            const WorkoutPlanWidget()
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Container(
            //     padding: const EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //       color: primaryColor,
            //       borderRadius: BorderRadius.circular(30),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.2),
            //           blurRadius: 10,
            //           offset: const Offset(0, 5),
            //         ),
            //       ],
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         // Header Section
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Text(
            //                   "Workout Plan",
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.bold,
            //                     color: deepNavyBlue,
            //                   ),
            //                 ),
            //                 const SizedBox(height: 8),
            //                 Text(
            //                   "Keep pushing towards your goal!",
            //                   style: TextStyle(
            //                     fontSize: 14,
            //                     color: deepNavyBlue.withOpacity(0.8),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Container(
            //               width: 60,
            //               height: 60,
            //               decoration: BoxDecoration(
            //                 color: Colors.blue.withOpacity(0.2),
            //                 borderRadius: BorderRadius.circular(30),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   '60%',
            //                   style: TextStyle(
            //                     color: Colors.blue[300],
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         const SizedBox(height: 20),

            //         // Workout Details Section
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             _buildWorkoutDetail(
            //               icon: Icons.timer,
            //               title: "Duration",
            //               value: "45 mins",
            //               color: Colors.green,
            //             ),
            //             _buildWorkoutDetail(
            //               icon: Icons.fireplace,
            //               title: "Calories",
            //               value: "350 kcal",
            //               color: Colors.redAccent,
            //             ),
            //             _buildWorkoutDetail(
            //               icon: Icons.fitness_center,
            //               title: "Exercises",
            //               value: "8",
            //               color: Colors.orange,
            //             ),
            //           ],
            //         ),
            //         const SizedBox(height: 20),

            //         // Progress Bar Section
            //         const Text(
            //           "Today's Progress",
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.bold,
            //             color: deepNavyBlue,
            //           ),
            //         ),
            //         const SizedBox(height: 10),
            //         Stack(
            //           children: [
            //             Container(
            //               height: 10,
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: Colors.grey[300],
            //                 borderRadius: BorderRadius.circular(5),
            //               ),
            //             ),
            //             Container(
            //               height: 10,
            //               width: MediaQuery.of(context).size.width *
            //                   0.6, // 60% progress
            //               decoration: BoxDecoration(
            //                 color: Colors.blue,
            //                 borderRadius: BorderRadius.circular(5),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )
            ,
            const WeightTrackerScreen()
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

