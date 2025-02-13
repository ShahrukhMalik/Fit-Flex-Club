import 'dart:io';

import 'package:fit_flex_club/src/core/common/theme/basic_theme.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_appbar.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_button.dart';
import 'package:fit_flex_club/src/core/common/widgets/platform_textfields.dart';
import 'package:fit_flex_club/src/core/util/api/api_service.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_bp_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_gif_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/bloc/getgifurl/getgifurl_cubit.dart';
import 'package:fit_flex_club/src/features/workout_management/presentation/widgets/workout_debounce_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid_v4/uuid_v4.dart';

// class FitFlexAddExercisePage extends StatefulWidget {
//   static const route = 'add_exercise';
//   final ExerciseBpModel? exercise;
//   final ExerciseModel? editExercise;
//   final bool sets;
//   final bool duration;
//   final bool weight;
//   final bool reps;
//   final String dayId;

//   const FitFlexAddExercisePage({
//     super.key,
//     required this.exercise,
//     this.editExercise,
//     required this.sets,
//     required this.duration,
//     required this.weight,
//     required this.reps,
//     required this.dayId,
//   });

//   @override
//   State<FitFlexAddExercisePage> createState() => _FitFlexAddExercisePageState();
// }

// class _FitFlexAddExercisePageState extends State<FitFlexAddExercisePage> {
//   final ValueNotifier<ExerciseModel?> exerciseModel = ValueNotifier(null);
//   final ValueNotifier<List<SetModel>?> sets = ValueNotifier(null);
//   final TextEditingController durationController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     exerciseModel.value = widget.editExercise ??
//         ExerciseModel(
//           gifUrl: widget.exercise?.gifUrl ?? '',
//           dayId: widget.dayId,
//           // [
//           //   SetModel(
//           //     id: UUIDv4().toString(),
//           //   ),
//           // ],
//           [],
//           code: widget.exercise!.code,
//           id: UUIDv4().toString(),
//           name: widget.exercise!.name,
//           category: widget.exercise!.category,
//           muscleGroup: widget.exercise!.muscleGroup,
//           parameters: widget.exercise!.parameters,
//         );
//     sets.value = widget.editExercise?.sets ??
//         [
//           SetModel(
//             exerciseId: exerciseModel.value!.id!,
//             id: UUIDv4().toString(),
//           ),
//         ];
//   }

//   _deleteSet(String setId) {
//     final updatedSets = sets.value?.where((set) => set.id != setId).toList();
//     sets.value = updatedSets;
//   }

//   _editSet(SetModel editedSet) {
//     // Get the current list or initialize a new one
//     final currentSets = sets.value ?? [];

//     // Update the list: replace the matching set or add it
//     final updatedSets = currentSets.map((set) {
//       if (set.id == editedSet.id) {
//         return set.copyWith(
//           targetReps: editedSet.targetReps,
//           targetWeight: editedSet.targetWeight,
//         );
//       }
//       return set;
//     }).toList();

//     // Add the new set if it doesn't exist
//     if (!currentSets.any((set) => set.id == editedSet.id)) {
//       updatedSets.add(editedSet);
//     }
//     sets.value = updatedSets;
//   }

//   _addSet(SetModel newSet, [bool addNew = true, bool repeat = false]) {
//     // Get the current list or initialize a new one
//     final currentSets = sets.value ?? [];
//     List<SetModel> updatedSets;
//     if (repeat) {
//       updatedSets = currentSets;
//       final lastSet = updatedSets.last;
//       if (lastSet.targetDistance == null &&
//           lastSet.targetReps == null &&
//           lastSet.targetTime == null &&
//           lastSet.targetWeight == null) {
//         updatedSets.removeLast();
//       }
//       updatedSets.add(updatedSets.last.copyWith(id: UUIDv4().toString()));
//       sets.value = updatedSets
//           .map(
//             (e) => e,
//           )
//           .toList();
//       return;
//     }

//     // Update the list: replace the matching set or add it
//     updatedSets = currentSets.map((set) {
//       if (set.id == newSet.id) {
//         return set.copyWith(
//           targetReps: newSet.targetReps,
//           targetWeight: newSet.targetWeight,
//         );
//       }
//       return set;
//     }).toList();

//     // Add the new set if it doesn't exist
//     if (!currentSets.any((set) => set.id == newSet.id)) {
//       if (addNew) {
//         updatedSets.add(newSet);
//       } else {
//         updatedSets = updatedSets.map(
//           (e) {
//             if (e.id == updatedSets.last.id) {
//               return e.copyWith(
//                 targetReps: newSet.targetReps,
//                 targetWeight: newSet.targetWeight,
//               );
//             }
//             return e;
//           },
//         ).toList();
//       }
//     }

//     updatedSets.add(
//       SetModel(
//         clientId: newSet.clientId,
//         exerciseId: newSet.exerciseId,
//         id: UUIDv4().toString(),
//       ),
//     );

//     // Replace the value with a new list
//     sets.value = updatedSets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController weightController = TextEditingController();
//     final TextEditingController repsController = TextEditingController();
//     final TextEditingController durationController = TextEditingController();
//     final ValueNotifier<String?> _gifUrl = ValueNotifier(null);

//     return Scaffold(
//       appBar: PlatformAppbar.basicAppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: globalColorScheme.onPrimaryContainer,
//         title: "Add Exercise",
//         context: context,
//         trailing: PlatformButton().buildButton(
//           foregroundColor: globalColorScheme.primary,
//           context: context,
//           type: ButtonType.icon,
//           icon: Icons.logout,
//           text: "",
//           onPressed: () => context.pop(),
//         )!,
//       ),
//       body: SafeArea(
//         child: Container(
//           // margin: EdgeInsets.only(top: 100),
//           // padding: const EdgeInsets.all(16.0),
//           decoration: Platform.isIOS
//               ? null
//               : BoxDecoration(
//                   color: globalColorScheme.surface,
//                   borderRadius: BorderRadius.all(Radius.circular(20))),
//           constraints: BoxConstraints(
//             minWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height * 0.4,
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       width: double.maxFinite,
//                       height: 250,
//                       // width: double.maxFinite,
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: ValueListenableBuilder(
//                           valueListenable: _gifUrl,
//                           builder: (context, url, _) {
//                             // final data = snapshot.data;
//                             if (url?.isNotEmpty ?? false) {
//                               // if (snapshot.hasData) {
//                               if (url != null) {
//                                 return Gif(
//                                   placeholder: (context) =>
//                                       CupertinoActivityIndicator(),
//                                   alignment: Alignment.center,
//                                   autostart: Autostart.loop,
//                                   useCache: true,
//                                   image: NetworkImage(
//                                     url,
//                                   ),
//                                 );
//                               } else {
//                                 return Text('No GIF available');
//                               }
//                             } else {
//                               return Text('No data available');
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Index Circle
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 10),
//                                   child: CircleAvatar(
//                                     radius: 20,
//                                     backgroundColor: Colors.grey[300],
//                                     child: Icon(Icons.fitness_center),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       // Title and Subtitle
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   widget.exercise?.name ??
//                                                       widget.editExercise?.name ??
//                                                       "",
//                                                   style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   widget.exercise?.muscleGroup ??
//                                                       widget.editExercise
//                                                           ?.muscleGroup ??
//                                                       "",
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           // Tag (e.g., Hypertrophy)
//                                           if (widget.exercise?.category != null)
//                                             Container(
//                                               padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8.0,
//                                                 vertical: 4.0,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 color: globalColorScheme.secondary
//                                                     .withOpacity(0.5),
//                                                 borderRadius:
//                                                     BorderRadius.circular(16),
//                                               ),
//                                               child: Text(
//                                                 widget.exercise?.category ?? "",
//                                                 style: TextStyle(
//                                                   color: globalColorScheme
//                                                       .onErrorContainer,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                           if (widget.editExercise?.category !=
//                                               null)
//                                             Container(
//                                               padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8.0,
//                                                 vertical: 4.0,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 color: globalColorScheme.secondary
//                                                     .withOpacity(0.5),
//                                                 borderRadius:
//                                                     BorderRadius.circular(16),
//                                               ),
//                                               child: Text(
//                                                 widget.editExercise?.category ??
//                                                     "",
//                                                 style: TextStyle(
//                                                   color: globalColorScheme
//                                                       .onErrorContainer,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       // // Metrics Row
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (widget.duration)
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     "Duration (in Mins)",
//                                   ),
//                                   Expanded(
//                                     child: AppTextFields.basicTextField(
//                                       textAlign: TextAlign.center,
//                                       controller: durationController,
//                                       onChanged: (p0) {
//                                         durationController.text = p0;
//                                         sets.value = [
//                                           SetModel(
//                                             exerciseId: exerciseModel.value!.id!,
//                                             id: UUIDv4().toString(),
//                                             targetTime: Duration(
//                                               minutes: int.tryParse(p0) ?? 10,
//                                             ),
//                                           ),
//                                         ];
//                                       },
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           else
//                             // SizedBox()
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: ValueListenableBuilder(
//                                   valueListenable: sets,
//                                   builder: (context, set, _) {
//                                     if (!widget.duration) {
//                                       // if (sets.value?.isNotEmpty ?? false) {
//                                       return SingleChildScrollView(
//                                         child: Table(
//                                           defaultVerticalAlignment:
//                                               TableCellVerticalAlignment.middle,
//                                           // border: TableBorder.all(color: Colors.grey),
//                                           columnWidths: widget.weight
//                                               ? {
//                                                   0: FlexColumnWidth(1), // Set #
//                                                   1: FlexColumnWidth(3), // Reps
//                                                   2: FlexColumnWidth(3), // Weight
//                                                   3: FlexColumnWidth(
//                                                       2), // Actions
//                                                 }
//                                               : {
//                                                   0: FlexColumnWidth(1), // Set #
//                                                   1: FlexColumnWidth(2), // Reps
//                                                   2: FlexColumnWidth(1), // Weight
//                                                 },
//                                           children: [
//                                             // Table Header
//                                             TableRow(
//                                               // decoration: BoxDecoration(color: globalColorScheme.secondary),
//                                               children: [
//                                                 Center(
//                                                   child: Text(
//                                                     'Set',
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ),
//                                                 if (widget.reps)
//                                                   Center(
//                                                     child: Text(
//                                                       'Reps',
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                 if (widget.weight)
//                                                   Center(
//                                                     child: Text(
//                                                       'Weight',
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                 Center(
//                                                   child: Text(
//                                                     '',
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),

//                                             // Dynamic Rows
//                                             ...sets.value!
//                                                 .asMap()
//                                                 .entries
//                                                 .map((entry) {
//                                               final index = entry.key;
//                                               final set = entry.value;

//                                               final TextEditingController
//                                                   repsController =
//                                                   TextEditingController();
//                                               repsController.text =
//                                                   set.targetReps == null
//                                                       ? ""
//                                                       : set.targetReps.toString();
//                                               final TextEditingController
//                                                   weightController =
//                                                   TextEditingController();
//                                               weightController.text =
//                                                   set.targetWeight == null
//                                                       ? ""
//                                                       : set.targetWeight
//                                                           .toString();
//                                               return TableRow(
//                                                 children: [
//                                                   // Set #
//                                                   Center(
//                                                     child: Container(
//                                                       padding: EdgeInsets.all(10),
//                                                       decoration: ShapeDecoration(
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                             Radius.circular(
//                                                               100,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         '${index + 1}',
//                                                         style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: globalColorScheme
//                                                               .onPrimary,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   // Reps
//                                                   if (widget.reps)
//                                                     DebouncedTextField(
//                                                       controller: repsController,
//                                                       onChanged: (value) {
//                                                         _editSet(
//                                                           SetModel(
//                                                             exerciseId:
//                                                                 set.exerciseId,
//                                                             id: set.id,
//                                                             targetReps:
//                                                                 int.tryParse(
//                                                                     value),
//                                                             targetWeight:
//                                                                 set.targetWeight,
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),
//                                                   // Weight
//                                                   if (widget.weight)
//                                                     DebouncedTextField(
//                                                       controller:
//                                                           weightController,
//                                                       onChanged: (value) {
//                                                         _editSet(
//                                                           SetModel(
//                                                             exerciseId: set.id,
//                                                             id: set.id,
//                                                             targetReps:
//                                                                 set.targetReps,
//                                                             targetWeight:
//                                                                 double.tryParse(
//                                                               value,
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),

//                                                   Center(
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Expanded(
//                                                           child: IconButton(
//                                                             icon: Icon(
//                                                               Icons.add_box,
//                                                               color: globalColorScheme
//                                                                   .primaryContainer,
//                                                             ),
//                                                             onPressed: () {
//                                                               if (widget.weight) {
//                                                                 if (repsController
//                                                                         .text
//                                                                         .isEmpty ||
//                                                                     weightController
//                                                                         .text
//                                                                         .isEmpty) {
//                                                                   Fluttertoast
//                                                                       .showToast(
//                                                                     msg:
//                                                                         "Please input all the fields before adding new set",
//                                                                     backgroundColor:
//                                                                         globalColorScheme
//                                                                             .onErrorContainer,
//                                                                     textColor:
//                                                                         globalColorScheme
//                                                                             .primary,
//                                                                   );
//                                                                 } else {
//                                                                   _addSet(
//                                                                     SetModel(
//                                                                       clientId: set
//                                                                           .clientId,
//                                                                       exerciseId:
//                                                                           set.exerciseId,
//                                                                       id: set.id,
//                                                                       targetReps:
//                                                                           int.tryParse(
//                                                                         repsController
//                                                                             .text,
//                                                                       ),
//                                                                       targetWeight:
//                                                                           double
//                                                                               .tryParse(
//                                                                         weightController
//                                                                             .text,
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 }
//                                                               } else if (widget
//                                                                       .reps &&
//                                                                   !widget
//                                                                       .weight) {
//                                                                 if (repsController
//                                                                     .text
//                                                                     .isEmpty) {
//                                                                   Fluttertoast
//                                                                       .showToast(
//                                                                     msg:
//                                                                         "Please input all the fields before adding new set",
//                                                                     backgroundColor:
//                                                                         globalColorScheme
//                                                                             .onErrorContainer,
//                                                                     textColor:
//                                                                         globalColorScheme
//                                                                             .primary,
//                                                                   );
//                                                                 } else {
//                                                                   _addSet(
//                                                                     SetModel(
//                                                                       clientId: set
//                                                                           .clientId,
//                                                                       exerciseId:
//                                                                           set.exerciseId,
//                                                                       id: set.id,
//                                                                       targetReps:
//                                                                           int.tryParse(
//                                                                         repsController
//                                                                             .text,
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                                 }
//                                                               }
//                                                             },
//                                                           ),
//                                                         ),
//                                                         if (sets.value!.length >
//                                                             1)
//                                                           Expanded(
//                                                             child: IconButton(
//                                                               icon: Icon(
//                                                                 Icons.delete,
//                                                                 color: globalColorScheme
//                                                                     .onPrimaryContainer,
//                                                               ),
//                                                               onPressed: () {
//                                                                 _deleteSet(
//                                                                     set.id);
//                                                               },
//                                                             ),
//                                                           ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               );
//                                             }),
//                                           ],
//                                         ),
//                                       );
//                                       // }
//                                       // else {

//                                       // }
//                                     } else {
//                                       return Row(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               "Duration (in Mins)",
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: AppTextFields.basicTextField(
//                                               controller: durationController,
//                                               onChanged: (p0) {
//                                                 durationController.text = p0;
//                                                 sets.value = [
//                                                   SetModel(
//                                                     exerciseId:
//                                                         exerciseModel.value!.id!,
//                                                     id: UUIDv4().toString(),
//                                                     targetTime: Duration(
//                                                       minutes:
//                                                           int.tryParse(p0) ?? 10,
//                                                     ),
//                                                   ),
//                                                 ];
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(10),
//               //   child: Column(
//               //     children: [
//               //       Row(
//               //         spacing: 10,
//               //         children: [
//               //           ValueListenableBuilder(
//               //             valueListenable: sets,
//               //             builder: (context, sets, value) {
//               //               if ((sets?.length ?? 0) > 1) {
//               //                 return Expanded(
//               //                   child: PlatformButton().buildButton(
//               //                     context: context,
//               //                     type: ButtonType.outlined,
//               //                     borderRadius: 20,
//               //                     height: 45,
//               //                     // foregroundColor: ,
//               //                     backgroundColor: globalColorScheme.primary,
//               //                     textStyle: TextStyle(
//               //                       color: globalColorScheme.onPrimaryContainer,
//               //                     ),
//               //                     text: 'Repeat Set',
//               //                     onPressed: () {
//               //                       _addSet(
//               //                           sets![sets.length - 2]
//               //                               .copyWith(id: UUIDv4().toString()),
//               //                           false,
//               //                           true);
//               //                     },
//               //                   )!,
//               //                 );
//               //               } else {
//               //                 return SizedBox.shrink();
//               //               }
//               //             },
//               //           ),
//               //           Expanded(
//               //             child: PlatformButton().buildButton(
//               //               context: context,
//               //               type: ButtonType.primary,
//               //               // foregroundColor: ,
//               //               backgroundColor: globalColorScheme.primary,
//               //               textStyle: TextStyle(
//               //                   color: globalColorScheme.onPrimaryContainer),
//               //               text: 'Submit',
//               //               onPressed: () {
//               //                 if (widget.duration) {
//               //                   if (durationController.text.isEmpty) {
//               //                     Fluttertoast.showToast(
//               //                       msg: "Duration is not entered",
//               //                       backgroundColor:
//               //                           globalColorScheme.onErrorContainer,
//               //                       textColor: globalColorScheme.primary,
//               //                     );
//               //                   } else {
//               //                     context.pop(
//               //                       exerciseModel.value?.copyWith(
//               //                         sets: sets.value,
//               //                       ),
//               //                     );
//               //                   }
//               //                 } else {
//               //                   if (widget.reps && !widget.weight) {
//               //                     if (sets.value?.first.targetReps == null) {
//               //                       Fluttertoast.showToast(
//               //                         msg:
//               //                             "Please input reps for the first set",
//               //                         backgroundColor:
//               //                             globalColorScheme.onErrorContainer,
//               //                         textColor: globalColorScheme.primary,
//               //                       );
//               //                     } else {
//               //                       context.pop(
//               //                         exerciseModel.value?.copyWith(
//               //                           sets: sets.value,
//               //                         ),
//               //                       );
//               //                     }
//               //                   }

//               //                   if (widget.reps && widget.weight) {
//               //                     if (sets.value?.first.targetReps == null ||
//               //                         sets.value?.first.targetWeight == null) {
//               //                       Fluttertoast.showToast(
//               //                         msg:
//               //                             "Please input reps and sets for the first set",
//               //                         backgroundColor:
//               //                             globalColorScheme.onErrorContainer,
//               //                         textColor: globalColorScheme.primary,
//               //                       );
//               //                     } else {
//               //                       context.pop(
//               //                         exerciseModel.value?.copyWith(
//               //                           sets: sets.value,
//               //                         ),
//               //                       );
//               //                     }
//               //                   }
//               //                 }
//               //               },
//               //             )!,
//               //           ),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class FitFlexAddExercisePage extends StatefulWidget {
  static const route = 'add_exercise';
  final ExerciseBpModel? exercise;
  final ExerciseModel? editExercise;
  final bool sets;
  final bool duration;
  final bool weight;
  final bool reps;
  final String dayId;

  const FitFlexAddExercisePage({
    super.key,
    required this.exercise,
    this.editExercise,
    required this.sets,
    required this.duration,
    required this.weight,
    required this.reps,
    required this.dayId,
  });

  @override
  State<FitFlexAddExercisePage> createState() => _FitFlexAddExercisePageState();
}

class _FitFlexAddExercisePageState extends State<FitFlexAddExercisePage>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  late final ValueNotifier<ExerciseModel?> exerciseModel;
  late final ValueNotifier<List<SetModel>> sets;
  late final TextEditingController durationController;

  final ValueNotifier<bool> isKeyboardOpen = ValueNotifier<bool>(false);
  final Map<String, TextEditingController> _controllers = {};

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // Ensure the widget is still active before updating state
    if (!mounted) return;

    // Use the updated way to access the render view
    final bottomInset = RendererBinding
        .instance.renderViews.first.flutterView.viewInsets.bottom;

    // Update state based on the keyboard visibility
    isKeyboardOpen.value = bottomInset > 0;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // Initialize exercise model
    exerciseModel = ValueNotifier(widget.editExercise ??
        ExerciseModel(
          dayId: widget.dayId,
          [],
          code: widget.exercise!.code,
          id: UUIDv4().toString(),
          name: widget.exercise!.name,
          category: widget.exercise!.category,
          muscleGroup: widget.exercise!.muscleGroup,
          parameters: widget.exercise!.parameters,
        ));

    // Initialize sets
    sets = ValueNotifier(widget.editExercise?.sets ??
        [
          SetModel(
            exerciseId: exerciseModel.value!.id!,
            id: UUIDv4().toString(),
          ),
        ]);

    // Initialize controllers
    durationController = TextEditingController(
        text: widget.editExercise?.sets.firstOrNull?.targetTime?.inMinutes
            .toString());

    context.read<GetgifurlCubit>().getExerciseGif(
          widget.exercise?.code ?? widget.editExercise?.code ?? '',
        );
    // // Initialize GIF URL
    // gifUrl =
    //     ValueNotifier(widget.exercise?.gifUrl ?? widget.editExercise?.gifUrl);

    // Initialize controllers for existing sets
    _initializeSetControllers();
  }

  void _initializeSetControllers() {
    for (final set in sets.value) {
      _controllers['${set.id}_reps'] =
          TextEditingController(text: set.targetReps?.toString() ?? '');
      _controllers['${set.id}_weight'] =
          TextEditingController(text: set.targetWeight?.toString() ?? '');
    }
  }

  void _deleteSet(String setId) {
    // Remove controllers for the deleted set
    _controllers.remove('${setId}_reps');
    _controllers.remove('${setId}_weight');

    final updatedSets = sets.value.where((set) => set.id != setId).toList();
    sets.value = updatedSets;
  }

  void _editSet(SetModel editedSet) {
    final updatedSets = sets.value.map((set) {
      if (set.id == editedSet.id) {
        return editedSet;
      }
      return set;
    }).toList();
    sets.value = updatedSets;
  }

  void _addSet(SetModel newSet, [bool addNew = true, bool repeat = false]) {
    if (repeat) {
      SetModel lastSet = sets.value.last;
      final newId = UUIDv4().toString();
      List<SetModel> updatedSets = sets.value;
      if (lastSet.targetDistance == null &&
          lastSet.targetReps == null &&
          lastSet.targetTime == null &&
          lastSet.targetWeight == null) {
        updatedSets.removeLast();
        lastSet = updatedSets.last.copyWith(id: newId);
        updatedSets.add(lastSet);
        sets.value = updatedSets
            .map(
              (e) => e,
            )
            .toList();
        // Create controllers for the new set
        _controllers['${newId}_reps'] =
            TextEditingController(text: lastSet.targetReps?.toString() ?? '');
        _controllers['${newId}_weight'] =
            TextEditingController(text: lastSet.targetWeight?.toString() ?? '');
        return;
      }

      // Create controllers for the new set
      _controllers['${newId}_reps'] =
          TextEditingController(text: lastSet.targetReps?.toString() ?? '');
      _controllers['${newId}_weight'] =
          TextEditingController(text: lastSet.targetWeight?.toString() ?? '');

      sets.value = [...sets.value, lastSet.copyWith(id: newId)];
      return;
    }

    final updatedSets = [...sets.value];
    if (!updatedSets.any((set) => set.id == newSet.id)) {
      if (addNew) {
        updatedSets.add(newSet);
      } else {
        final lastIndex = updatedSets.length - 1;
        updatedSets[lastIndex] = updatedSets[lastIndex].copyWith(
          targetReps: newSet.targetReps,
          targetWeight: newSet.targetWeight,
        );
      }
    }

    // Add empty set at the end
    final newId = UUIDv4().toString();
    _controllers['${newId}_reps'] = TextEditingController();
    _controllers['${newId}_weight'] = TextEditingController();

    updatedSets.add(SetModel(
      clientId: newSet.clientId,
      exerciseId: newSet.exerciseId,
      id: newId,
    ));

    sets.value = updatedSets;
  }

  @override
  void dispose() {
    exerciseModel.dispose();
    sets.dispose();
    durationController.dispose();

    // Dispose all set controllers
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  Widget _buildSetTable() {
    return ValueListenableBuilder(
        valueListenable: sets,
        builder: (context, updatedSets, _) {
          return SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: widget.weight
                  ? {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(2),
                    }
                  : {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                    },
              children: [
                TableRow(
                  children: [
                    Center(
                        child: Text('Set',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    if (widget.reps)
                      Center(
                          child: Text('Reps',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    if (widget.weight)
                      Center(
                          child: Text('Weight',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    Center(child: Text('')),
                  ],
                ),
                ...updatedSets.asMap().entries.map((entry) {
                  final index = entry.key;
                  final set = entry.value;

                  return TableRow(
                    children: [
                      _buildSetNumber(index),
                      if (widget.reps) _buildRepsField(set),
                      if (widget.weight) _buildWeightField(set),
                      _buildSetActions(set),
                    ],
                  );
                }),
              ],
            ),
          );
        });
  }

  Widget _buildSetNumber(int index) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: globalColorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildRepsField(SetModel set) {
    return DebouncedTextField(
      controller: _controllers['${set.id}_reps']!,
      onChanged: (value) {
        _editSet(SetModel(
          exerciseId: set.exerciseId,
          id: set.id,
          targetReps: int.tryParse(value),
          targetWeight: set.targetWeight,
        ));
      },
    );
  }

  Widget _buildWeightField(SetModel set) {
    return DebouncedTextField(
      controller: _controllers['${set.id}_weight']!,
      onChanged: (value) {
        _editSet(SetModel(
          exerciseId: set.exerciseId,
          id: set.id,
          targetReps: set.targetReps,
          targetWeight: double.tryParse(value),
        ));
      },
    );
  }

  Widget _buildSetActions(SetModel set) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.add_box,
                color: globalColorScheme.primaryContainer,
              ),
              onPressed: () => _handleAddSet(set),
            ),
          ),
          if (sets.value.length > 1)
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: globalColorScheme.onPrimaryContainer,
                ),
                onPressed: () => _deleteSet(set.id),
              ),
            ),
        ],
      ),
    );
  }

  void _handleAddSet(SetModel set) {
    final repsController = _controllers['${set.id}_reps'];
    final weightController = _controllers['${set.id}_weight'];

    // if (widget.weight) {
    //   if (repsController?.text.isEmpty ?? true) {
    //     Fluttertoast.showToast(
    //       msg: "Please input all the fields before adding new set",
    //       backgroundColor: globalColorScheme.onErrorContainer,
    //       textColor: globalColorScheme.primary,
    //     );
    //     return;
    //   }
    // } else if (widget.reps && !widget.weight) {
    //   if (repsController?.text.isEmpty ?? true) {
    //     Fluttertoast.showToast(
    //       msg: "Please input all the fields before adding new set",
    //       backgroundColor: globalColorScheme.onErrorContainer,
    //       textColor: globalColorScheme.primary,
    //     );
    //     return;
    //   }
    // }

    if (widget.weight) {
      if (repsController!.text.isEmpty || weightController!.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please input all the fields before adding new set",
          backgroundColor: globalColorScheme.onErrorContainer,
          textColor: globalColorScheme.primary,
        );
      } else {
        _addSet(
          SetModel(
            clientId: set.clientId,
            exerciseId: set.exerciseId,
            id: set.id,
            targetReps: int.tryParse(
              repsController.text,
            ),
            targetWeight: double.tryParse(
              weightController.text,
            ),
          ),
        );
      }
    } else if (widget.reps && !widget.weight) {
      if (repsController!.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please input all the fields before adding new set",
          backgroundColor: globalColorScheme.onErrorContainer,
          textColor: globalColorScheme.primary,
        );
      } else {
        _addSet(
          SetModel(
            clientId: set.clientId,
            exerciseId: set.exerciseId,
            id: set.id,
            targetReps: int.tryParse(
              repsController.text,
            ),
          ),
        );
      }
    }

    // _addSet(SetModel(
    //   clientId: set.clientId,
    //   exerciseId: set.exerciseId,
    //   id: set.id,
    //   targetReps: int.tryParse(repsController?.text ?? ''),
    //   targetWeight: double.tryParse(weightController?.text ?? ''),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PlatformAppbar.basicAppBar(
        // automaticallyImplyLeading: false,
        onLeadingPressed: context.pop,
        backgroundColor: globalColorScheme.onPrimaryContainer,
        title: "Add Exercise",
        context: context,
        // trailing: PlatformButton().buildButton(
        //   foregroundColor: globalColorScheme.primary,
        //   context: context,
        //   type: ButtonType.icon,
        //   icon: Icons.logout,
        //   text: "",
        //   onPressed: () => context.pop(),
        // )!,
      ),
      body: SafeArea(
        child: Container(
          decoration: Platform.isIOS
              ? null
              : BoxDecoration(
                  color: globalColorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildGifPreview(),
                    Expanded(
                      child: _buildExerciseDetails(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: sets,
                          builder: (context, sets, value) {
                            if ((sets.length ?? 0) > 1) {
                              return Expanded(
                                child: PlatformButton().buildButton(
                                  context: context,
                                  type: ButtonType.outlined,
                                  borderRadius: 20,
                                  height: 45,
                                  // foregroundColor: ,
                                  backgroundColor: globalColorScheme.primary,
                                  textStyle: TextStyle(
                                    color: globalColorScheme.onPrimaryContainer,
                                  ),
                                  text: 'Repeat Set',
                                  onPressed: () {
                                    _addSet(
                                        sets[sets.length - 2]
                                            .copyWith(id: UUIDv4().toString()),
                                        false,
                                        true);
                                  },
                                )!,
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                        Expanded(
                          child: PlatformButton().buildButton(
                            context: context,
                            type: ButtonType.primary,
                            // foregroundColor: ,
                            backgroundColor: globalColorScheme.primary,
                            textStyle: TextStyle(
                                color: globalColorScheme.onPrimaryContainer),
                            text: 'Submit',
                            onPressed: () {
                              if (widget.duration) {
                                if (durationController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Duration is not entered",
                                    backgroundColor:
                                        globalColorScheme.onErrorContainer,
                                    textColor: globalColorScheme.primary,
                                  );
                                } else {
                                  context.pop(
                                    exerciseModel.value?.copyWith(
                                      sets: sets.value,
                                    ),
                                  );
                                }
                              } else {
                                if (widget.reps && !widget.weight) {
                                  if (sets.value.first.targetReps == null) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Please input reps for the first set",
                                      backgroundColor:
                                          globalColorScheme.onErrorContainer,
                                      textColor: globalColorScheme.primary,
                                    );
                                  } else {
                                    context.pop(
                                      exerciseModel.value?.copyWith(
                                        sets: sets.value,
                                      ),
                                    );
                                  }
                                }

                                if (widget.reps && widget.weight) {
                                  if (sets.value.first.targetReps == null ||
                                      sets.value.first.targetWeight == null) {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Please input reps and sets for the first set",
                                      backgroundColor:
                                          globalColorScheme.onErrorContainer,
                                      textColor: globalColorScheme.primary,
                                    );
                                  } else {
                                    context.pop(
                                      exerciseModel.value?.copyWith(
                                        sets: sets.value,
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          )!,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGifPreview() {
    return ValueListenableBuilder(
      valueListenable: isKeyboardOpen,
      builder: (context, isKeyboardVisible, child) {
        if (!isKeyboardVisible) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                width: double.maxFinite,
                height: 250,
                // width: double.maxFinite,
                child: Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<GetgifurlCubit, GetgifurlState>(
                    builder: (context, state) {
                      if (state is GetgifurlLoading) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      if (state is GetgifurlError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Text(
                              state.failures.message ??
                                  "Something went wrong, please try again",
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Retry',
                              ),
                            )
                          ],
                        );
                      }
                      if (state is GetgifurlComplete) {
                        final ExerciseGifModel exerciseGifModel =
                            state.exerciseGifModel;
                        return Gif(
                          useCache: true,
                          placeholder: (context) =>
                              CupertinoActivityIndicator(),
                          alignment: Alignment.center,
                          autostart: Autostart.loop,
                          image: NetworkImage(
                            exerciseGifModel.gifUrl ?? '',
                          ),
                        );
                      }
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                      // return Loading();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 40,
                  child: Divider(
                    // indent: 10,
                    thickness: 3,
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
    // return Container(
    //   color: Colors.white,
    //   width: double.maxFinite,
    //   height: 250,
    //   child: Align(
    //     alignment: Alignment.center,
    //     child: ValueListenableBuilder(
    //       valueListenable: gifUrl,
    //       builder: (context, url, _) {
    //         if (url?.isNotEmpty ?? false) {
    //           return Gif(
    //             placeholder: (context) => CupertinoActivityIndicator(),
    //             alignment: Alignment.center,
    //             autostart: Autostart.loop,
    //             useCache: true,
    //             image: NetworkImage(url!),
    //           );
    //         } else {
    //           return Text('No Gif available');
    //         }
    //       },
    //     ),
    //   ),
    // );
  }

  _buildExerciseHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Index Circle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.fitness_center),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Subtitle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.exercise?.name ??
                                      widget.editExercise?.name ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.exercise?.muscleGroup ??
                                      widget.editExercise?.muscleGroup ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tag (e.g., Hypertrophy)
                          if (widget.exercise?.category != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: globalColorScheme.secondary
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                widget.exercise?.category ?? "",
                                style: TextStyle(
                                  color: globalColorScheme.onErrorContainer,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          if (widget.editExercise?.category != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: globalColorScheme.secondary
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                widget.editExercise?.category ?? "",
                                style: TextStyle(
                                  color: globalColorScheme.onErrorContainer,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // // Metrics Row
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDetails() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildExerciseHeader(),
        // if (widget.duration)
        //   _buildDurationField()
        // else
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: _buildSetTable(),
          ),
        ),
      ],
    );
  }

  // ... Rest of the UI building methods follow the same pattern
}
