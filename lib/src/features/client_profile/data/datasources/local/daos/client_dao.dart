import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/client_profile/data/datasources/local/tables/client_table.dart';
part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients])
class ClientsDao extends DatabaseAccessor<AppDatabase> with _$ClientsDaoMixin {
  ClientsDao(super.db);

  // Method to fetch paginated clients
  Future<List<Client>> getClientsPaginated(int page, int pageSize) {
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

  // Insert a single client
  Future<int> insertClient(Client client) {
    return into(clients).insert(client);
  }

  // Insert multiple clients
  Future<void> insertClients(List<Client> clientsList) {
    return batch((batch) {
      batch.insertAll(clients, clientsList);
    });
  }

  // Fetch all clients
  Future<List<Client>> getAllClients() {
    return select(clients).get();
  }
}
