import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:flutter/material.dart';

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

class GymClientsDashboard extends StatelessWidget {
  final ColorScheme colorScheme;

  const GymClientsDashboard({
    super.key,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data with gender added
    final clients = [
      {
        'name': 'John Doe',
        'age': 28,
        'weight': 75.0,
        'gender': 'Male',
        'program': 'Strength Training',
        'isAssigned': true,
      },
      {
        'name': 'Jane Smith',
        'age': 32,
        'weight': 62.0,
        'gender': 'Female',
        'program': 'Weight Loss',
        'isAssigned': true,
      },
      {
        'name': 'Mike Johnson',
        'age': 45,
        'weight': 88.0,
        'gender': 'Male',
        'program': null,
        'isAssigned': false,
      },
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
            children: [
              // Search Bar
              AppTextFields.searchTextField(),

              const SizedBox(height: 16),

              // Clients List
              Expanded(
                child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      color: colorScheme.inversePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: colorScheme.outline),
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
                                    client['name'] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: client['gender'] == 'Male'
                                        ? colorScheme.tertiary.withOpacity(0.1)
                                        : colorScheme.secondary
                                            .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        client['gender'] == 'Male'
                                            ? Icons.male
                                            : Icons.female,
                                        size: 16,
                                        color: client['gender'] == 'Male'
                                            ? colorScheme.tertiary
                                            : colorScheme.secondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        client['gender'] as String,
                                        style: TextStyle(
                                          color: client['gender'] == 'Male'
                                              ? colorScheme.tertiary
                                              : colorScheme.secondary,
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
                                  value: '${client['age']} years',
                                  colorScheme: colorScheme,
                                ),
                                const SizedBox(width: 16),
                                _buildDetailItem(
                                  icon: Icons.monitor_weight,
                                  label: 'Weight',
                                  value: '${client['weight']} kg',
                                  colorScheme: colorScheme,
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
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Program:',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: client['isAssigned'] as bool
                                        ? colorScheme.primary
                                        : colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    client['isAssigned'] as bool
                                        ? client['program'] as String
                                        : 'Not Assigned',
                                    style: TextStyle(
                                      color: client['isAssigned'] as bool
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSecondary,
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
              ),
            ],
          ),
        ),
      ),
      // FAB for quick actions
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(Icons.filter_list, color: colorScheme.onPrimaryContainer),
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
