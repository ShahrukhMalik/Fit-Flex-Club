import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/client_management/data/models/client_weight_model.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_weight.dart';
import 'package:fit_flex_club/src/features/client_profile/data/models/client_model.dart';
import 'package:injectable/injectable.dart';
part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients, ClientWeight])
@singleton
class ClientsDao extends DatabaseAccessor<AppDatabase> with _$ClientsDaoMixin {
  ClientsDao(super.attachedDatabase);

  Future<void> insertClientWeightsBatch(List<ClientWeightModel> models) async {
    await batch(
      (batch) {
        batch.insertAll(
          clientWeight, // The table you're inserting into
          models.map(
            (model) {
              return ClientWeightCompanion(
                clientId: model.clientId != null
                    ? Value(model.clientId!)
                    : Value.absent(),
                timeStamp: Value(model.timeStamp),
                weightInKg: Value(model.weightInKg),
                weightInLb: Value(model.weightInLb),
              );
            },
          ).toList(),
        );
      },
    );
  }

  // Insert method
  Future<int> insertClientWeight(ClientWeightModel model) {
    return into(clientWeight).insert(
      ClientWeightCompanion(
        clientId:
            model.clientId != null ? Value(model.clientId!) : Value.absent(),
        timeStamp: Value(model.timeStamp), // Use int timestamp directly
        weightInKg: Value(model.weightInKg),
        weightInLb: Value(model.weightInLb),
      ),
    );
  }

// Fetch method
  Future<List<ClientWeightModel>> getClientWeights(String? clientId) async {
    final query = select(clientWeight);
    if (clientId != null) {
      query.where((tbl) => tbl.clientId.equals(clientId));
    }
    final rows = await query.get();

    return rows.map((row) => ClientWeightModel.fromRow(row)).toList();
  }

  Future<void> assignWorkoutPlan(
    String id,
    String workoutPlanUid,
  ) async {
    // Perform the update where the id matches
    await (update(clients)..where((tbl) => tbl.id.equals(id))).write(
      ClientsCompanion(
        currentWorkoutPlanName:
            Value(workoutPlanUid), // Update currentWorkoutPlanName
        updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  // Method to fetch paginated clients
  Future<List<Client>> getClientsPaginated(
    int page,
    int pageSize,
  ) {
    final offset = (page - 1) * pageSize; // Calculate the offset for pagination

    // Use LIMIT and OFFSET to paginate results
    return (select(clients)..limit(pageSize, offset: offset)).get();
  }

  // Method to count total number of clients (for total pages calculation)
  Future<int> getTotalClientsCount() async {
    final row =
        await customSelect('SELECT COUNT(*) AS count FROM clients').getSingle();
    return row.read<int>('count'); // Parse the result to an int
  }

  // Insert a single client using ClientModel
  Future<int> insertClient(ClientModel clientModel) {
    // Map the ClientModel fields to the Clients table fields, with null checks
    final client = ClientsCompanion(
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      id: Value(clientModel.id!),
      age: clientModel.age != null ? Value(clientModel.age!) : Value.absent(),
      gender: clientModel.gender != null
          ? Value(clientModel.gender!)
          : Value.absent(),
      weightInKg: clientModel.weightInKg != null
          ? Value(clientModel.weightInKg!)
          : Value.absent(),
      weightInLb: clientModel.weightInLb != null
          ? Value(clientModel.weightInLb!)
          : Value.absent(),
      heightInCm: clientModel.heightInCm != null
          ? Value(clientModel.heightInCm!)
          : Value.absent(),
      heightInFt: clientModel.heightInFt != null
          ? Value(clientModel.heightInFt!)
          : Value.absent(),
      isTrainer: clientModel.isTrainer != null
          ? Value(clientModel.isTrainer!)
          : Value.absent(),
      isUserActive: clientModel.isUserActive != null
          ? Value(clientModel.isUserActive!)
          : Value.absent(),
      username: clientModel.username != null
          ? Value(clientModel.username!)
          : Value.absent(),
      email: clientModel.email != null
          ? Value(clientModel.email!)
          : Value.absent(),
      phone: clientModel.phone?['phoneNumber'] != null
          ? Value(clientModel.phone!['phoneNumber']!)
          : Value.absent(),
      phoneCountryCode: clientModel.phone?['countryCode'] != null
          ? Value(clientModel.phone!['countryCode']!)
          : Value.absent(),
      currentWorkoutPlanName: clientModel.currentWorkoutPlanName != null
          ? Value(clientModel.currentWorkoutPlanName!)
          : Value.absent(),
    );

    return into(clients).insert(client);
  }

  // Insert multiple clients using ClientModel
  Future<void> insertClients(List<ClientModel> clientsList) {
    return transaction(() async {
      batch((batch) {
        batch.insertAll(
          clients,
          clientsList.map(
            (clientModel) {
              return ClientsCompanion(
                  id: Value(clientModel.id!),
                  age: clientModel.age != null
                      ? Value(clientModel.age!)
                      : Value.absent(),
                  gender: clientModel.gender != null
                      ? Value(clientModel.gender!)
                      : Value.absent(),
                  weightInKg: clientModel.weightInKg != null
                      ? Value(clientModel.weightInKg!)
                      : Value.absent(),
                  weightInLb: clientModel.weightInLb != null
                      ? Value(clientModel.weightInLb!)
                      : Value.absent(),
                  heightInCm: clientModel.heightInCm != null
                      ? Value(clientModel.heightInCm!)
                      : Value.absent(),
                  heightInFt: clientModel.heightInFt != null
                      ? Value(clientModel.heightInFt!)
                      : Value.absent(),
                  isTrainer: clientModel.isTrainer != null
                      ? Value(clientModel.isTrainer!)
                      : Value.absent(),
                  isUserActive: clientModel.isUserActive != null
                      ? Value(clientModel.isUserActive!)
                      : Value.absent(),
                  username: clientModel.username != null
                      ? Value(clientModel.username!)
                      : Value.absent(),
                  email: clientModel.email != null
                      ? Value(clientModel.email!)
                      : Value.absent(),
                  phone: clientModel.phone?['phoneNumber'] != null
                      ? Value(clientModel.phone?['phoneNumber']!)
                      : Value.absent(),
                  phoneCountryCode: clientModel.phone?['countryCode'] != null
                      ? Value(clientModel.phone?['countryCode']!)
                      : Value.absent(),
                  currentWorkoutPlanName:
                      clientModel.currentWorkoutPlanName != null
                          ? Value(clientModel.currentWorkoutPlanName!)
                          : Value.absent(),
                  createdAt: Value(DateTime.now().millisecondsSinceEpoch),
                  updatedAt: Value.absent());
            },
          ).toList(),
        );
      }).then(
        (value) {
          // print(value);
        },
      );
    }).then(
      (value) {
        print(value);
      },
    );
  }

  // Method to get a client by their primary key (id)
  Future<Client?> getClientByid(String id) async {
    final clientRow = await (select(clients)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull(); // Returns null if no client is found
    return clientRow;
    // Directly map fields from the clientRow to ClientModel constructor
    // if (clientRow != null) {
    //   return ClientModel(
    //     id: clientRow.id,
    //     age: clientRow.age,
    //     gender: clientRow.gender,
    //     weight: clientRow.weight,
    //     weightUnit: clientRow.weightUnit,
    //     height: clientRow.height,
    //     heightUnit: clientRow.heightUnit,
    //     isTrainer: clientRow.isTrainer,
    //     isUserActive: clientRow.isUserActive,
    //     username: clientRow.username,
    //     email: clientRow.email,
    //     phone: {
    //       "phoneNumber": clientRow.phone,
    //       "countryCode": clientRow.phoneCountryCode
    //     },
    //     currentWorkoutPlanName: clientRow.currentWorkoutPlanName,
    //   );
    // }
    // return null; // Return null if no client is found
  }

  // Fetch all clients
  Future<List<Client>> getAllClients() async {
    final insertedClients = await select(clients).get();
    print(insertedClients);
    return insertedClients;
  }
}
