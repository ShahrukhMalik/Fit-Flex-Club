import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/set_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/workout_plan_entity.dart';

class WorkoutPlanModel extends WorkoutPlan {
  final int? createdAt;
  final int? updatedAt;
  final int totalExercises;
  final int muscleBuildingExercises;
  final int cardioExercises;
// Add the weeks to this model

  const WorkoutPlanModel({
    required super.name,
    required super.weeks,
    required super.uid,
    required this.totalExercises,
    required this.muscleBuildingExercises,
    required this.cardioExercises,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkoutPlanModel.fromMap(Map<String, dynamic> data) {
    return WorkoutPlanModel(
      cardioExercises: data['cardioExercises'],
      muscleBuildingExercises: data['muscleBuildingExercises'],
      totalExercises: data['totalExercises'],
      name: data['name'],
      weeks: data['weeks'],
      uid: data['uid'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  // Firestore to WorkoutPlanModel
  static Future<WorkoutPlanModel> fromFirestore(
     QueryDocumentSnapshot<Map<String,dynamic>> snapshot) async {
    final data = snapshot.data();

    // Get weeks from Firestore subcollection
    final weeksSnapshot = await snapshot.reference.collection('week').get();
    final List<WeekModel> weeks =
        await Future.wait(weeksSnapshot.docs.map((weekDoc) async {
      final weekData = weekDoc.data();
      final daysSnapshot = await weekDoc.reference.collection('days').get();
      final List<DayModel> days =
          await Future.wait(daysSnapshot.docs.map((dayDoc) async {
        final dayData = dayDoc.data();
        final exercisesSnapshot =
            await dayDoc.reference.collection('exercises').get();
        final List<ExerciseModel> exercises =
            await Future.wait(exercisesSnapshot.docs.map((exerciseDoc) async {
          final exerciseData = exerciseDoc.data();
          final setsSnapshot =
              await exerciseDoc.reference.collection('sets').get();
          final List<SetModel> sets = setsSnapshot.docs
              .map((setDoc) => SetModel.fromMap(setDoc.data()))
              .toList();
          return ExerciseModel.fromMap({
            ...exerciseData,
            'sets': sets,
          });
        }));
        return DayModel.forEachElement(
          dayData['dayNumber'],
          dayData['id'],
          exercises,
        );
      }));
      return WeekModel.forEachElement(
        weekData['weekNumber'],
        weekData['id'],
        days,
      );
    }));

    return WorkoutPlanModel.fromMap({
      'cardioExercises': data['cardioExercises'],
      'muscleBuildingExercises': data['muscleBuildingExercises'],
      'totalExercises': data['totalExercises'],
      'name': data['name'],
      'weeks': weeks,
      'uid': data['uid'],
      'createdAt': data['createdAt'],
      'updatedAt': data['updatedAt'],
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'totalExercises': totalExercises,
      'muscleBuildingExercises': muscleBuildingExercises,
      'cardioExercises': cardioExercises,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
