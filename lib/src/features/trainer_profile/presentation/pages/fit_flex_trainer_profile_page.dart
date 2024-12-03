import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FitFlexTrainerProfilePage extends StatelessWidget {
  static const String route = "/fit-flex-trainer-profile";
  const FitFlexTrainerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GymClientsDashboard(
      colorScheme: globalColorScheme,
    );
  }
}

class GymClientsDashboard extends StatefulWidget {
  final ColorScheme colorScheme;

  const GymClientsDashboard({
    super.key,
    required this.colorScheme,
  });

  @override
  State<GymClientsDashboard> createState() => _GymClientsDashboardState();
}

class _GymClientsDashboardState extends State<GymClientsDashboard> {
  @override
  void initState() {
    super.initState();
    context.read<TrainerProfileBloc>().add(TrainerProfileGetClientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Sample data with gender added

    return Scaffold(
      backgroundColor: widget.colorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Client Profiles",
        context: context,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Search Bar
              AppTextFields.searchTextField(),

              const SizedBox(height: 16),

              // Clients List
              BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                builder: (context, state) {
                  if (state is TrainerProfileComplete) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.entities.length,
                        itemBuilder: (context, index) {
                          final client = state.entities[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: widget.colorScheme.inversePrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side:
                                  BorderSide(color: widget.colorScheme.outline),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Client Name and Gender
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          client.username as String,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: widget.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: client.gender == 'Male'
                                              ? widget.colorScheme.tertiary
                                                  .withOpacity(0.1)
                                              : widget.colorScheme.secondary
                                                  .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              client.gender == 'Male'
                                                  ? Icons.male
                                                  : Icons.female,
                                              size: 16,
                                              color: client.gender == 'Male'
                                                  ? widget.colorScheme.tertiary
                                                  : widget
                                                      .colorScheme.secondary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              client.gender ?? "",
                                              style: TextStyle(
                                                color: client.gender == 'Male'
                                                    ? widget
                                                        .colorScheme.tertiary
                                                    : widget
                                                        .colorScheme.secondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  // Client Details Row
                                  Row(
                                    children: [
                                      _buildDetailItem(
                                        icon: Icons.calendar_today,
                                        label: 'Age',
                                        value: '${client.age} years',
                                        colorScheme: widget.colorScheme,
                                      ),
                                      const SizedBox(width: 16),
                                      _buildDetailItem(
                                        icon: Icons.monitor_weight,
                                        label: 'Weight',
                                        value: '${client.weight} kg',
                                        colorScheme: widget.colorScheme,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),

                                  // Program Status
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        size: 20,
                                        color:
                                            widget.colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Program:',
                                        style: TextStyle(
                                          color: widget
                                              .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: client.currentWorkoutId != null
                                              ? widget.colorScheme.primary
                                              : widget.colorScheme.secondary,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          client.currentWorkoutId != null
                                              ? "Program Name"
                                              : 'Not Assigned',
                                          style: TextStyle(
                                            color: client.currentWorkoutId !=
                                                    null
                                                ? widget.colorScheme.onPrimary
                                                : widget
                                                    .colorScheme.onSecondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
      // FAB for quick actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: widget.colorScheme.primaryContainer,
        child: Icon(Icons.filter_list,
            color: widget.colorScheme.onPrimaryContainer),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required ColorScheme colorScheme,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
