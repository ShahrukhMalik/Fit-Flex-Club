import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fit_flex_club/src/core/db/fit_flex_local_db.dart';
import 'package:fit_flex_club/src/features/syncmanager/data/datasources/local/tables/sync_queue_table.dart';
import 'package:flutter/foundation.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueData>> getUnsyncedData() async {
    final unsyncedActions = await (select(syncQueue)
          ..where((tbl) => tbl.synced.equals(false)))
        .get();
    return unsyncedActions;
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
