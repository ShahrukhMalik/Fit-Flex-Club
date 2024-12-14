import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platfom_loader.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_dialog.dart';
import 'package:fit_flex_club/src/features/client_management/presentation/pages/fit_flex_client_workout_history_page.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:fit_flex_club/src/features/client_profile/domain/entities/client_entity.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_history_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_profile_page.dart';
import 'package:fit_flex_club/src/features/trainer_profile/presentation/pages/fit_flex_trainer_workout_page.dart';
import 'package:fit_flex_club/src/features/workout_history/presentation/bloc/workout_history_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/workout_plan_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/workout_management_bloc.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/pages/fit_flex_club_create_workout_plan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid_v4/uuid_v4.dart';

class WorkoutPlanPickerWidget extends StatefulWidget {
  const WorkoutPlanPickerWidget({super.key});

  @override
  State<WorkoutPlanPickerWidget> createState() =>
      _WorkoutPlanPickerWidgetState();
}

class _WorkoutPlanPickerWidgetState extends State<WorkoutPlanPickerWidget> {
  Widget _buildProgramItem(WorkoutPlanModel program) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, program);
      },
      child: Card(
        elevation: 1, // Subtle shadow for a cleaner look
        margin: const EdgeInsets.only(bottom: 12),
        color: globalColorScheme
            .inversePrimary, // Surface color for a professional look
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Slightly rounded corners
          side: BorderSide(
            color: globalColorScheme.outline,
          ), // Soft border
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center align elements
            children: [
              // Leading Icon
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    globalColorScheme.primaryContainer, // Subtle background
                child: Icon(
                  Icons.fitness_center,
                  color: globalColorScheme
                      .onPrimaryContainer, // Contrasting icon color
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Program name and actions
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Program Name

                    // Program Status
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: globalColorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              program.name,
                              style: TextStyle(
                                color: globalColorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // Edit Button
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle edit action
                                context.go(
                                  FitFlexClubCreateWorkoutPlanPage.route,
                                  extra: {
                                    'updateData': true,
                                    "workoutPlan": program,
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: globalColorScheme
                                    .secondaryContainer, // Primary color for edit
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        // const Spacer(), // Push the delete button to the right
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 500,
        child: Container(
          color: globalColorScheme.shadow,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: globalColorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Select Workout Plan',
                  style: TextStyle(
                    color: globalColorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              BlocBuilder<WorkoutManagementBloc, WorkoutManagementState>(
                builder: (context, state) {
                  if (state is WorkoutManagementLoading) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            8,
                            (index) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: PlatformLoader().buildLoader(
                                type: LoaderType.shimmer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is GetWorkoutPlansComplete) {
                    final workoutPlans = state.workoutPlans;
                    if (workoutPlans.isNotEmpty) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: workoutPlans.length,
                            itemBuilder: (context, index) {
                              return _buildProgramItem(
                                workoutPlans[index],
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Text('No workout plans found.');
                    }
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          8,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: PlatformLoader().buildLoader(
                              type: LoaderType.shimmer,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FitFlexTrainerClientDetailsPage extends StatefulWidget {
  final ClientEntity client;
  static const route = '/fit-flex-trainer-client-details';
  const FitFlexTrainerClientDetailsPage({super.key, required this.client});

  @override
  State<FitFlexTrainerClientDetailsPage> createState() =>
      _FitFlexTrainerClientDetailsPageState();
}

class _FitFlexTrainerClientDetailsPageState
    extends State<FitFlexTrainerClientDetailsPage> {
  ClientModel client = ClientModel();
  final ValueNotifier<bool> isUserActive = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    isUserActive.value = widget.client.isUserActive ?? false;
    client = ClientModel.fromClientEntity(widget.client);
    context.read<WorkoutManagementBloc>().add(
          GetWorkoutPlansForClientEvent(
            clientId: widget.client.id!,
          ),
        );
  }

  void _toggleUserActiveStatus(bool isActive) {
    isUserActive.value = isActive;
  }

  Future<dynamic> _showExistingWorkoutPlans() async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return WorkoutPlanPickerWidget();
        },
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return WorkoutPlanPickerWidget();
        },
      );
    }
  }

  WorkoutPlanModel? _getWorkoutPlanToAssign({
    dynamic workoutPlan,
    String? clientId,
  }) {
    final oldWorkoutPlan = workoutPlan as WorkoutPlanModel?;

    if (oldWorkoutPlan == null) {
      return null; // Handle null case if needed.
    }

    if (clientId != null) {
      // Generate new IDs for the hierarchy
      final newWeeks = oldWorkoutPlan.weeks.map((oldWeek) {
        final newWeekId = UUIDv4().toString();

        final newDays = oldWeek.days.map((oldDay) {
          final newDayId = UUIDv4().toString();

          final newExercises = oldDay.exercises.map((oldExercise) {
            final newExerciseId = UUIDv4().toString();

            final newSets = oldExercise.sets.map((oldSet) {
              return oldSet.copyWith(
                id: UUIDv4().toString(),
                clientId: clientId,
              );
            }).toList();

            return oldExercise.copyWith(
              id: newExerciseId,
              sets: newSets,
              clientId: clientId,
            );
          }).toList();

          return oldDay.copyWith(
            id: newDayId,
            exercises: newExercises,
            clientId: clientId,
          );
        }).toList();

        return oldWeek.copyWith(
          id: newWeekId,
          days: newDays,
          clientId: clientId,
        );
      }).toList();

      final newWorkoutPlan = oldWorkoutPlan.copyWith(
        uid: UUIDv4().toString(),
        weeks: newWeeks,
        clientId: clientId,
      );
      return newWorkoutPlan;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppbar.basicAppBar(
        title: "Client Details Page",
        context: context,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        onLeadingPressed: () => context.go(FitFlexTrainerProfilePage.route),
      ),
      body: ClientEntityCompactWidget(
        isUserActive: isUserActive,
        client: widget.client,
        colorScheme: globalColorScheme,
        onUserActiveToggle: _toggleUserActiveStatus,
        onAddWorkoutPlan: (clientId) {
          context.read<WorkoutManagementBloc>().add(GetWorkoutPlansEvent());
          _showExistingWorkoutPlans().then(
            (value) {
              if (value != null) {
                final workoutToAssign = _getWorkoutPlanToAssign(
                  workoutPlan: value,
                  clientId: clientId,
                );

                if (workoutToAssign != null) {
                  context.read<WorkoutManagementBloc>().add(
                        AssignWorkoutPlanEvent(
                          workoutPlan: workoutToAssign,
                        ),
                      );
                } else {
                  // Handle null case if needed.
                }
              } else {
                // Handle null case if needed.
              }
            },
          );
        },
      ),
    );
  }
}

class ClientEntityCompactWidget extends StatelessWidget {
  final ClientEntity client;
  final ColorScheme colorScheme;
  final ValueChanged<bool> onUserActiveToggle;
  final ValueNotifier<bool> isUserActive;
  final Function(String) onAddWorkoutPlan;

  const ClientEntityCompactWidget({
    super.key,
    required this.client,
    required this.colorScheme,
    required this.onUserActiveToggle,
    required this.isUserActive,
    required this.onAddWorkoutPlan,
  });

  Widget _buildDetailItem(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value ?? 'N/A',
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutManagementBloc, WorkoutManagementState>(
      listener: (context, state) {
        if (state is AssigneWorkoutPlanLoading) {
          PlatformDialog.showLoadingDialog(
            context: context,
            message: "Processing your request...",
          );
        }

        if (state is GetWorkoutPlansForClientLoading) {
          PlatformDialog.showLoadingDialog(
            context: context,
            message: "Fetching workout plan for client...",
          );
        }

        if (state is WorkoutManagementError) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Client Details",
            message: state.failures.message ?? "Something Went Wrong!",
            onConfirm: () => Navigator.pop(context),
          );
        }

        if (state is DeleteWorkoutLoading) {
          PlatformDialog.showLoadingDialog(
            context: context,
            message: "Deleting the workout plan...",
          );
        }

        if (state is DeleteWorkoutComplete) {
          Navigator.pop(context);
          context.read<WorkoutManagementBloc>().add(
                GetWorkoutPlansForClientEvent(
                  clientId: client.id!,
                ),
              );
        }

        if (state is AssignWorkoutComplete) {
          PlatformDialog.showAlertDialog(
            context: context,
            title: "Assign Workout Plan",
            message: "Workout Plan assigned Successfully!",
            onConfirm: () {
              Navigator.pop(context);
              context.go(
                FitFlexTrainerClientDetailsPage.route,
                extra: {
                  'client': client,
                },
              );
              context.read<WorkoutManagementBloc>().add(
                    GetWorkoutPlansForClientEvent(
                      clientId: client.id!,
                    ),
                  );
              // Navigator.pop(context);
            },
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16), // Slightly rounded corners
                side: BorderSide(
                  color: globalColorScheme.outline,
                ), // Soft border
              ),
              color: colorScheme.inversePrimary,
              margin: EdgeInsets.all(10),
              elevation: 4,
              shadowColor: colorScheme.shadow,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section with Name and Active Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: colorScheme.primaryContainer,
                              child: Icon(
                                Icons.person,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  client.username ?? 'Unknown User',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ValueListenableBuilder(
                                  valueListenable: isUserActive,
                                  builder: (context, isUserActive, _) {
                                    return Text(
                                      isUserActive ? 'Active' : 'Inactive',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isUserActive
                                            ? colorScheme.secondary
                                            : colorScheme.error,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Switch Button
                        ValueListenableBuilder(
                          valueListenable: isUserActive,
                          builder: (context, isUserActive, _) {
                            return Switch(
                              value: isUserActive,
                              onChanged: (value) {
                                print(value);
                                onUserActiveToggle(value);
                              },
                              activeColor: colorScheme.primaryContainer,
                              activeTrackColor: colorScheme.secondary,
                              inactiveThumbColor:
                                  colorScheme.onPrimaryContainer,
                              inactiveTrackColor: colorScheme.errorContainer,
                            );
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: Colors.grey),
                    // Details Grid Section

                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem(
                                    'Email',
                                    client.email,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: _buildDetailItem(
                                    'Phone',
                                    '${client.phone?['countryCode']}'
                                        '-'
                                        '${client.phone?['phoneNumber']}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem(
                                      'Age', client.age?.toString()),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child:
                                      _buildDetailItem('Gender', client.gender),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem('Height',
                                      '${client.heightInFt ?? 'N/A'} ${'ft' ?? ''}'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: _buildDetailItem('Weight',
                                      '${client.weightInKg ?? 'N/A'} ${'kg' ?? ''}'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    // GridView(
                    //   shrinkWrap: true,

                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     mainAxisSpacing: 12,
                    //     crossAxisSpacing: 16,
                    //     childAspectRatio: 3.5,
                    //   ),
                    //   children: [
                    //     _buildDetailItem('Email', client.email),
                    //     _buildDetailItem(
                    //         'Phone',
                    //         '${client.phone?['countryCode']}'
                    //             '-'
                    //             '${client.phone?['phoneNumber']}'),
                    //     _buildDetailItem('Age', client.age?.toString()),
                    //     _buildDetailItem('Gender', client.gender),
                    //     _buildDetailItem('Height',
                    //         '${client.heightInFt ?? 'N/A'} ${'ft' ?? ''}'),
                    //     _buildDetailItem('Weight',
                    //         '${client.weightInKg ?? 'N/A'} ${'kg' ?? ''}'),
                    //   ],
                    // ),

                    //
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<WorkoutManagementBloc, WorkoutManagementState>(
            listener: (context, state) {
              if (state is GetWorkoutPlansForClientComplete) {
                Navigator.pop(context);
              }

              if (state is WorkoutManagementError) {
                PlatformDialog.showAlertDialog(
                  context: context,
                  title: "Client Details",
                  message: state.failures.message ?? "Something Went Wrong",
                );
              }
            },
            builder: (context, state) {
              if (state is WorkoutManagementError) {
                return Text(
                  state.failures.message ?? "Something went wrong!",
                );
              }
              if (state is GetWorkoutPlansForClientComplete) {
                final workoutPlan = state.workoutPlan;
                return Card(
                  elevation: 4, // Subtle shadow for a cleaner look
                  margin: const EdgeInsets.all(10),
                  color: globalColorScheme
                      .inversePrimary, // Surface color for a professional look
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16), // Slightly rounded corners
                    side: BorderSide(
                      color: globalColorScheme.outline,
                    ), // Soft border
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Current Assigned Program',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Center align elements
                          children: [
                            // Leading Icon
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: globalColorScheme
                                  .primaryContainer, // Subtle background
                              child: Icon(
                                Icons.fitness_center,
                                color: globalColorScheme
                                    .onPrimaryContainer, // Contrasting icon color
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Program name and actions
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: globalColorScheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            workoutPlan?.name ?? "Not Assigned",
                                            style: TextStyle(
                                              color: workoutPlan == null
                                                  ? globalColorScheme.secondary
                                                  : globalColorScheme.onPrimary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Edit Button
                                      if (workoutPlan == null)
                                        IconButton(
                                          onPressed: () {
                                            onAddWorkoutPlan(client.id!);
                                          },
                                          icon: Icon(
                                            Icons.add,
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (workoutPlan != null)
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    PlatformButton().buildButton(
                                      context: context,
                                      type: ButtonType.icon,
                                      icon: Icons.edit_document,
                                      foregroundColor:
                                          globalColorScheme.onPrimaryContainer,
                                      text: '',
                                      onPressed: () {
                                        context.go(
                                          FitFlexClubCreateWorkoutPlanPage
                                              .route,
                                          extra: {
                                            'updateData': true,
                                            "workoutPlan": workoutPlan,
                                            "clientEntity": client
                                          },
                                        );
                                      },
                                    )!,
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    PlatformButton().buildButton(
                                      context: context,
                                      type: ButtonType.icon,
                                      icon: Icons.delete,
                                      foregroundColor:
                                          globalColorScheme.tertiaryContainer,
                                      text: '',
                                      onPressed: () {
                                        context
                                            .read<WorkoutManagementBloc>()
                                            .add(
                                              DeleteAssignedWorkoutPlanEvent(
                                                workoutPlan: workoutPlan,
                                              ),
                                            );
                                      },
                                    )!,
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                              BlocListener<WorkoutHistoryBloc,
                                  WorkoutHistoryState>(
                                listener: (context, state) {
                                  if (state is GetWorkoutHistoryLoading) {
                                    PlatformDialog.showLoadingDialog(
                                      context: context,
                                      message: "Fetching Workout History!....",
                                    );
                                  }

                                  if (state is GetWorkoutHistoryComplete) {
                                    context.go(
                                      FitFlexTrainerHistoryPage.route,
                                      extra: {
                                        'histories': state.workoutHistory,
                                        'client': client,
                                      },
                                    );
                                  }
                                },
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      PlatformButton().buildButton(
                                        context: context,
                                        type: ButtonType.icon,
                                        icon: Icons.history_toggle_off,
                                        foregroundColor:
                                            globalColorScheme.secondary,
                                        text: '',
                                        onPressed: () {
                                          context
                                              .read<WorkoutHistoryBloc>()
                                              .add(
                                                GetWorkoutHistoryEvent(
                                                  cliendId:
                                                      client.id,
                                                ),
                                              );
                                        },
                                      )!,
                                      Text('View History'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: PlatformLoader().buildLoader(
                  type: LoaderType.shimmer,
                  height: 200,
                ),
              );
            },
          ),
          // Container(
          //   height: 200,
          //   width: double.maxFinite,
          //   decoration: BoxDecoration(),
          //   child: Center(
          //     child: Text(
          //       'Workout History Comming Soon..',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
