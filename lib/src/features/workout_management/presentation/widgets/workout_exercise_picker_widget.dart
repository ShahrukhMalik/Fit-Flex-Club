import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/exercise_bp_entity.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/getexercises/getexercises_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart'; // For platform checks

class ExercisePickerBottomSheet extends StatefulWidget {
  final List<ExerciseEntity> exercises;

  const ExercisePickerBottomSheet({required this.exercises, super.key});

  @override
  _ExercisePickerBottomSheetState createState() =>
      _ExercisePickerBottomSheetState();
}

class _ExercisePickerBottomSheetState extends State<ExercisePickerBottomSheet> {
  // String? selectedCategory;
  String? selectedMuscleGroup;

  // Filtered list of exercises based on search and filters
  final ValueNotifier<List<ExerciseEntity>> filteredExercises =
      ValueNotifier([]);
  // {
  //   return widget.exercises.where((exercise) {
  //     final matchesSearch =
  //         exercise.name?.toLowerCase().contains(searchQuery.toLowerCase()) ??
  //             false;
  //     final matchesCategory = selectedCategory.value == null ||
  //         exercise.category == selectedCategory.value;
  //     final matchesMuscleGroup = selectedMuscleGroup == null ||
  //         exercise.muscleGroup == selectedMuscleGroup;

  //     return matchesSearch && matchesCategory && matchesMuscleGroup;
  //   }).toList();
  // }

  // String selectedCategory = 'Sort by';
  // String selectedOption = 'Popularity';
  final ValueNotifier<String?> searchQuery = ValueNotifier(null);
  final ValueNotifier<String?> selectedCategory =
      ValueNotifier(null); // Categories for the left-hand column
  final ValueNotifier<String?> selectedCategoryOption =
      ValueNotifier(null); // Categories for the left-hand column
  final ValueNotifier<String?> selectedMuscleGroupOption =
      ValueNotifier(null); // Categories for the left-hand column

  void filterExercises() {
    filteredExercises.value = widget.exercises.where((exercise) {
      // Handle the search query based on searchQuery.value only.
      if (searchQuery.value == null &&
          selectedCategoryOption.value == null &&
          selectedMuscleGroupOption.value == null) {
        return true;
      } else {
        final searchMatch = searchQuery.value != null
            ? exercise.name
                    ?.toLowerCase()
                    .contains(searchQuery.value!.toLowerCase()) ??
                false
            : true;

        // Handle category match.
        final categoryMatch = (selectedCategoryOption.value == null ||
            exercise.category == selectedCategoryOption.value);

        // Handle muscle group match.
        final muscleGroupMatch = (selectedMuscleGroupOption.value == null ||
            exercise.muscleGroup == selectedMuscleGroupOption.value);

        // Combine all conditions to ensure all filters are applied.
        return searchMatch && categoryMatch && muscleGroupMatch;
      }
    }).toList();
  }

  final List<String> categories = [
    'Category',
    'Muscle Group',
  ];

  @override
  void initState() {
    super.initState();
    searchQuery.addListener(
      () {
        filterExercises();
      },
    );
    selectedCategoryOption.addListener(
      () {
        filterExercises();
      },
    );
    selectedMuscleGroupOption.addListener(
      () {
        filterExercises();
      },
    );
    filteredExercises.value = widget.exercises;
    options[categories[0]] = widget.exercises
        .where((e) => e.category != null)
        .map(
          (e) => e.category,
        )
        .toSet()
        .toList();
    options[categories[1]] =
        widget.exercises.map((e) => e.muscleGroup).toSet().toList();
  }

  // Options for "Sort by" category
  Map<String, List<String?>> options = {};
  // Shows the filter action sheet (platform-specific)
  void _showFilters() {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          // barrierColor: globalColorScheme.surface,
          context: context,
          builder: (_) {
            return _buildFilterWidget();
          });
    } else {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return _buildFilterWidget();
        },
      );
    }
  }

  _buildFilterWidget() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SizedBox(
        height: 400,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: globalColorScheme.surface,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Left-hand column (Categories)
                    ValueListenableBuilder(
                      valueListenable: selectedCategory,
                      builder: (context, selectedCategoryValue, _) {
                        return SizedBox(
                          width: 120,
                          height: 300, // Restrict height
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              String currentCategory = categories[index];
                              return GestureDetector(
                                onTap: () =>
                                    selectedCategory.value = currentCategory,
                                child: Container(
                                  color: currentCategory ==
                                          selectedCategoryValue
                                      ? globalColorScheme.secondary
                                      : Colors
                                          .transparent, // Highlight selected category
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        currentCategory,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: currentCategory ==
                                                  selectedCategoryValue
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: currentCategory ==
                                                  selectedCategoryValue
                                              ? globalColorScheme.inversePrimary
                                              : CupertinoColors.systemGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    // Vertical Divider (Ensure it's visible)
                    VerticalDivider(
                      color: globalColorScheme.shadow,
                      thickness: 1, // Set a thickness to ensure visibility
                    ),
                    // Right-hand content (Options for selected category)
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        child: ValueListenableBuilder(
                          valueListenable: selectedCategory,
                          builder: (context, selectedCategoryValue, _) {
                            return Material(
                              color: globalColorScheme.surface,
                              child: ListView.builder(
                                itemCount:
                                    options[selectedCategoryValue]?.length ?? 0,
                                itemBuilder: (context, index) {
                                  String option =
                                      options[selectedCategoryValue]![index] ??
                                          "";
                                  return ValueListenableBuilder<String?>(
                                    valueListenable:
                                        selectedCategoryValue == categories[0]
                                            ? selectedCategoryOption
                                            : selectedMuscleGroupOption,
                                    builder: (context, selectedOptionValue, _) {
                                      return RadioListTile<String>(
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        value: option,
                                        groupValue: selectedOptionValue,
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            if (selectedCategoryValue ==
                                                categories[0]) {
                                              selectedCategoryOption.value =
                                                  value;
                                            } else {
                                              selectedMuscleGroupOption.value =
                                                  value;
                                            }
                                          }
                                        },
                                        title: Text(option),
                                        activeColor:
                                            globalColorScheme.secondary,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Buttons at the bottom for Reset and Apply Filters
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Reset Button
                    CupertinoButton(
                      onPressed: () {
                        // Reset the selections to initial values
                        selectedCategory.value =
                            categories[0]; // Reset category
                        selectedCategoryOption.value =
                            null; // Reset selected option
                        selectedMuscleGroupOption.value =
                            null; // Reset selected option
                        Navigator.pop(context); // Close BottomSheet
                      },
                      child: Text("Reset"),
                    ),
                    // Apply Filters Button
                    CupertinoButton.filled(
                      onPressed: () {
                        // Apply the filters
                        Navigator.pop(context); // Close BottomSheet
                      },
                      child: Text("Done"),
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

  // Material BottomSheet for Android
  Widget _buildMaterialFilterSheet() {
    return Column(
      children: [
        // ListTile(
        //   title: Text('Category'),
        //   trailing: DropdownButton<String>(
        //     value: selectedCategory,
        //     hint: Text('Select'),
        //     onChanged: (value) {
        //       setState(() {
        //         selectedCategory = value;
        //       });
        //       Navigator.pop(context);
        //     },
        //     items:
        //         widget.exercises.map((e) => e.category).toSet().map((category) {
        //       return DropdownMenuItem<String>(
        //         value: category,
        //         child: Text(category ?? 'Unknown'),
        //       );
        //     }).toList(),
        //   ),
        // ),
        // ListTile(
        //   title: Text('Muscle Group'),
        //   trailing: DropdownButton<String>(
        //     value: selectedMuscleGroup,
        //     hint: Text('Select'),
        //     onChanged: (value) {
        //       setState(() {
        //         selectedMuscleGroup = value;
        //       });
        //       Navigator.pop(context);
        //     },
        //     items: widget.exercises
        //         .map((e) => e.muscleGroup)
        //         .toSet()
        //         .map((muscleGroup) {
        //       return DropdownMenuItem<String>(
        //         value: muscleGroup,
        //         child: Text(muscleGroup ?? 'Unknown'),
        //       );
        //     }).toList(),
        //   ),
        // ),
        // TextButton(
        //   onPressed: () {
        //     setState(() {
        //       selectedCategory = null;
        //       selectedMuscleGroup = null;
        //     });
        //     Navigator.pop(context);
        //   },
        //   child: Text('Clear Filters', style: TextStyle(color: Colors.red)),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Field with Filter Icon
        Padding(
          padding: const EdgeInsets.all(20),
          child: Platform.isIOS
              ? CupertinoSearchTextField(
                  suffixMode: OverlayVisibilityMode.always,
                  keyboardType: TextInputType.name,
                  backgroundColor: globalColorScheme.primary,
                  suffixIcon: Icon(
                    CupertinoIcons.slider_horizontal_3,
                    color: globalColorScheme.tertiary,
                  ),
                  onSuffixTap: _showFilters,
                  onChanged: (value) {
                    searchQuery.value = value;
                    filterExercises();
                  },
                )
              : TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Exercises',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: (selectedCategory.value != null ||
                                selectedMuscleGroup != null)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      onPressed: _showFilters,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchQuery.value = value;
                    filterExercises();
                  },
                ),
        ),
        // Exercise List
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder(
                    valueListenable: filteredExercises,
                    builder: (context, exercises, _) {
                      return ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pop(context, exercise);
                            },
                            child: Column(
                              children: [
                                Divider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Index Circle
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey[300],
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Content Column
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title and Subtitle
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    exercise.name ?? "",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    exercise.muscleGroup ?? "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Tag (e.g., Hypertrophy)
                                            if (exercise.category != null)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 4.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: globalColorScheme
                                                      .secondary
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Text(
                                                  exercise.category ?? "",
                                                  style: TextStyle(
                                                    color: globalColorScheme
                                                        .onErrorContainer,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
        ),
      ],
    )
        //   ,
        // )
        ;
  }
}

class FitFlexClubSelectExercisePage extends StatefulWidget {
  static const route = "/fit-flex-club-select-exercise";
  const FitFlexClubSelectExercisePage({
    super.key,
  });

  @override
  State<FitFlexClubSelectExercisePage> createState() =>
      _FitFlexClubSelectExercisePageState();
}

class _FitFlexClubSelectExercisePageState
    extends State<FitFlexClubSelectExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetexercisesCubit, GetexercisesState>(
        builder: (context, state) {
          // if (state is SubjectFailed) {
          //   return ErrorOutput(message: state.message);
          // }
          if (state is GetExercisesComplete) {
            return CupertinoScrollbar(
              child: ExercisePickerBottomSheet(
                exercises: state.exercises,
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
