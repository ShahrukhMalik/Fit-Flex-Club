import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/core/db/sync/sync_queue_table.dart';
import 'package:flutter/foundation.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<void> syncDataWithFirebase() async {
    final unsyncedActions = await (select(syncQueue)
          ..where((tbl) => tbl.synced.equals(false)))
        .get();

    for (final action in unsyncedActions) {
      final data = jsonDecode(action.data);
      try {
        // Perform operation on Firebase
        // if (action.operation == 'INSERT') {
        //   await FirebaseFirestore.instance.collection(action.table).add(data);
        // } else if (action.operation == 'UPDATE') {
        //   await FirebaseFirestore.instance.collection(action.table).doc(data['id']).update(data);
        // } else if (action.operation == 'DELETE') {
        //   await FirebaseFirestore.instance.collection(action.table).doc(data['id']).delete();
        // }

        // Mark action as synced
        await (update(syncQueue)..where((tbl) => tbl.id.equals(action.id)))
            .write(
          SyncQueueCompanion(
            synced: Value(
              true,
            ),
          ),
        );
      } catch (e) {
        // Handle errors (e.g., retry later)
        if (kDebugMode) {
          print('Error syncing action: $e');
        }
      }
    }
  }

  Future<void> logSyncAction(
    String operation,
    String table,
    Map<String, dynamic> data,
  ) async {
    await into(syncQueue).insert(
      SyncQueueCompanion(
        operation: Value(operation),
        table: Value(table),
        data: Value(jsonEncode(data)),
        timestamp: Value(DateTime.now().millisecondsSinceEpoch),
        synced: Value(false),
      ),
    );
  }
}
