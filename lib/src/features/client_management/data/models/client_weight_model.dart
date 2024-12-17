import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/client_management/domain/entities/client_weight_entity.dart';

class ClientWeightModel extends ClientWeightEntity {
  const ClientWeightModel({
    super.clientId,
    required super.timeStamp,
    required super.weightInKg,
    required super.weightInLb,
  });

  // Factory constructor for creating a model from a map (e.g., JSON or database row)
  factory ClientWeightModel.fromMap(Map<String, dynamic> map) {
    return ClientWeightModel(
      clientId: map['clientId'] as String?,
      timeStamp: map['timeStamp'] as int, // Time in milliseconds since epoch
      weightInKg: map['weightInKg'] as double,
      weightInLb: map['weightInLb'] as double,
    );
  }

  // Factory constructor for creating a model from a Drift row
  factory ClientWeightModel.fromRow(ClientWeightData row) {
    return ClientWeightModel(
      clientId: row.clientId,
      timeStamp: row.timeStamp, // Already in milliseconds
      weightInKg: row.weightInKg,
      weightInLb: row.weightInLb,
    );
  }

  // Convert the model to a map (e.g., for JSON or Drift insertion)
  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'timeStamp': timeStamp, // Keep as int
      'weightInKg': weightInKg,
      'weightInLb': weightInLb,
    };
  }
}

