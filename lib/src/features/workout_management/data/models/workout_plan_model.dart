import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/day_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/exercise_model.dart';
import 'package:fit_flex_club/src/features/workout_management/data/models/week_model.dart';
import 'package:fit_flex_club/src/features/workout_management/domain/entities/workout_plan_entity.dart';

class WorkoutPlanModel extends WorkoutPlan {
  final int? createdAt;
  final int? updatedAt;
  final String? clientId;

// Add the weeks to this model

  const WorkoutPlanModel({
    required super.name,
    required super.weeks,
    required super.uid,
    this.createdAt,
    this.updatedAt,
    this.clientId,
  });

  factory WorkoutPlanModel.fromMap(Map<String, dynamic> data,
      [bool isFromModel = false]) {
    return WorkoutPlanModel(
      name: data['name'],
      weeks: data['weeks'] != null
          ? isFromModel
              ? data['weeks']
              : (data['weeks'])
                  .map(
                    (e) => WeekModel.fromMap(e, isFromModel),
                  )
                  .cast<WeekModel>()
                  .toList()
          : [],
      uid: data['uid'],
      clientId: data['clientId'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  static Future<WorkoutPlanModel> fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) async {
    final data = snapshot.data();

    // Get weeks from Firestore subcollection, ordered by weekNumber
    final weeksSnapshot = await snapshot.reference
        .collection('weeks')
        .orderBy('weekNumber')
        .get();

    final List<WeekModel> weeks =
        await Future.wait(weeksSnapshot.docs.map((weekDoc) async {
      final weekData = weekDoc.data();
      weekData['workoutPlanId'] = data['uid'];

      // Get days from Firestore subcollection, ordered by dayNumber
      final daysSnapshot =
          await weekDoc.reference.collection('days').orderBy('dayNumber').get();

      final List<DayModel> days =
          await Future.wait(daysSnapshot.docs.map((dayDoc) async {
        final dayData = dayDoc.data();
        dayData['weekId'] = weekData['id'];

        // Get exercises from Firestore subcollection, ordered by exerciseOrder
        final exercisesSnapshot = await dayDoc.reference
            .collection('exercises')
            .orderBy('exerciseOrder')
            .get();

        final List<ExerciseModel> exercises =
            await Future.wait(exercisesSnapshot.docs.map((exerciseDoc) async {
          final exerciseData = exerciseDoc.data();
          exerciseData['dayId'] = dayData['id'];

          // Get sets from Firestore subcollection, ordered by setNumber
          final setsSnapshot = await exerciseDoc.reference
              .collection('sets')
              .orderBy('setNumber')
              .get();

          final List<Map<String, dynamic>> sets =
              setsSnapshot.docs.map((setDoc) => setDoc.data()).toList();

          return ExerciseModel.fromMap({
            ...exerciseData,
            'sets': sets,
          });
        }));

        return DayModel.forEachElement(
          dayData['dayNumber'],
          dayData['id'],
          dayData['weekId'],
          dayData['clientId'],
          exercises,
        );
      }));

      return WeekModel.forEachElement(
        weekData['weekNumber'],
        weekData['id'],
        weekData['workoutPlanId'],
        weekData['clientId'],
        days,
      );
    }));

    return WorkoutPlanModel.fromMap({
      'name': data['name'],
      'weeks': weeks,
      'uid': data['uid'],
      'clientId': data['clientId'],
      'createdAt': data['createdAt'],
      'updatedAt': data['updatedAt'],
    }, true);
  }

  WorkoutPlanModel copyWith({
    String? name,
    List<WeekModel>? weeks,
    String? uid,
    String? clientId,
    int? createdAt,
    int? updatedAt,
  }) {
    return WorkoutPlanModel(
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      weeks: weeks ?? this.weeks,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'clientId': clientId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'weeks': weeks
          .map(
            (e) => e.toMap(),
          )
          .toList()
    };
  }
}
