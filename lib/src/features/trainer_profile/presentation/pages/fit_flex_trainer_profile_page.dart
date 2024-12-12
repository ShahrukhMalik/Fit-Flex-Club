import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/bloc/trainer_profile_bloc.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_client_details_page.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final ValueNotifier<List<ClientEntity>?> clients = ValueNotifier(null);
  List<ClientEntity> _originalList = [];
  @override
  void initState() {
    super.initState();
    context.read<TrainerProfileBloc>().add(TrainerProfileGetClientsEvent());
  }

  void _filterClients(String? searchQuery) {
    final existingClients = clients.value;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      // Use a separate filtered list instead of mutating the original.
      final filteredClients = existingClients
          ?.where((client) =>
              client.username != null &&
              client.username!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();

      // Assign the filtered list to clients.value.
      clients.value = filteredClients;
    } else {
      // If searchQuery is null or empty, reset the list to the original value.
      clients.value = _originalList; // Assuming you store the original list.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sample data with gender added

    return Scaffold(
      backgroundColor: widget.colorScheme.surface,
      appBar: PlatformAppbar.basicAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Client Profiles",
        context: context,
        trailing: PlatformButton().buildButton(
          context: context,
          type: ButtonType.icon,
          foregroundColor: globalColorScheme.primary,
          icon: Icons.logout,
          text: "",
          onPressed: () => context
              .read<AuthenticationBloc>()
              .add(LogOutAuthenticationEvent()),
        )!,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Search Bar
              AppTextFields.searchTextField(
                onChanged: (value) => _filterClients(value),
                // decoration: InputDecoration(
                //   labelText: 'Search by Name',
                //   hintText: 'Search by Name',
                // ),
              ),

              const SizedBox(height: 16),

              // Clients List
              BlocBuilder<TrainerProfileBloc, TrainerProfileState>(
                builder: (context, state) {
                  if (state is TrainerProfileLoading) {
                    return Expanded(
                      child: SingleChildScrollView(
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
                      ),
                    );
                  }
                  if (state is TrainerProfileComplete) {
                    clients.value = state.entities;
                    _originalList = state.entities;
                    return Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: clients,
                          builder: (context, clients, _) {
                            return ListView.builder(
                              itemCount: clients?.length,
                              itemBuilder: (context, index) {
                                final client = clients?[index];
                                return InkWell(
                                  onTap: () => context.go(
                                      FitFlexTrainerClientDetailsPage.route,
                                      extra: {'client': client}),
                                  child: Card(
                                    elevation: 2,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    color: widget.colorScheme.inversePrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                          color: widget.colorScheme.outline),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Client Name and Gender
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  client?.username ?? "",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: widget
                                                        .colorScheme.onSurface,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      client?.gender == 'Male'
                                                          ? widget.colorScheme
                                                              .tertiary
                                                              .withOpacity(0.1)
                                                          : widget.colorScheme
                                                              .secondary
                                                              .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      client?.gender == 'Male'
                                                          ? Icons.male
                                                          : Icons.female,
                                                      size: 16,
                                                      color: client?.gender ==
                                                              'Male'
                                                          ? widget.colorScheme
                                                              .tertiary
                                                          : widget.colorScheme
                                                              .secondary,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      client?.gender ?? "",
                                                      style: TextStyle(
                                                        color: client?.gender ==
                                                                'Male'
                                                            ? widget.colorScheme
                                                                .tertiary
                                                            : widget.colorScheme
                                                                .secondary,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                value: '${client?.age} years',
                                                colorScheme: widget.colorScheme,
                                              ),
                                              const SizedBox(width: 16),
                                              _buildDetailItem(
                                                icon: Icons.monitor_weight,
                                                label: 'Weight',
                                                value:
                                                    '${client?.weightInKg} kg',
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
                                                color: widget.colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Program:',
                                                style: TextStyle(
                                                  color: widget.colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      client?.currentWorkoutPlanName !=
                                                              null
                                                          ? widget.colorScheme
                                                              .primary
                                                          : widget.colorScheme
                                                              .secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  client?.currentWorkoutPlanName !=
                                                          null
                                                      ? client!
                                                          .currentWorkoutPlanName!
                                                      : 'Not Assigned',
                                                  style: TextStyle(
                                                    color:
                                                        client?.currentWorkoutPlanName !=
                                                                null
                                                            ? widget.colorScheme
                                                                .onPrimary
                                                            : widget.colorScheme
                                                                .onSecondary,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    );
                  }
                  return Expanded(
                    child: SingleChildScrollView(
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
                    ),
                  );
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
