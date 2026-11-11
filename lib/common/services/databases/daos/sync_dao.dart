import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'sync_dao.g.dart';

@DriftAccessor(tables: [SyncOutbox, SyncMetadataEntries])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  Future<int> enqueue({
    required String id,
    required String entityType,
    required String entityId,
    required String operationType,
    required String payload,
    int? baseVersion,
  }) => into(syncOutbox).insert(
    SyncOutboxCompanion.insert(
      id: id,
      entityType: entityType,
      entityId: entityId,
      operationType: operationType,
      payload: payload,
      baseVersion: Value(baseVersion),
    ),
  );

  Future<List<SyncOperation>> getPending({int limit = 100}) =>
      (select(syncOutbox)
            ..where((operation) => operation.status.equals('pending'))
            ..orderBy([(operation) => OrderingTerm.asc(operation.createdAt)])
            ..limit(limit))
          .get();

  Future<int> markProcessing(String id) =>
      (update(syncOutbox)..where((operation) => operation.id.equals(id))).write(
        const SyncOutboxCompanion(status: Value('processing')),
      );

  Future<int> markRetry(String id, Object error) async {
    final operation = await (select(
      syncOutbox,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (operation == null) return 0;

    return (update(syncOutbox)..where((row) => row.id.equals(id))).write(
      SyncOutboxCompanion(
        status: const Value('pending'),
        attempts: Value(operation.attempts + 1),
        lastError: Value(error.toString()),
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> markConflict(String id, Object error) =>
      (update(syncOutbox)..where((operation) => operation.id.equals(id))).write(
        SyncOutboxCompanion(
          status: const Value('conflict'),
          lastError: Value(error.toString()),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );

  Future<int> complete(String id) =>
      (delete(syncOutbox)..where((operation) => operation.id.equals(id))).go();

  Future<int> recoverProcessing() =>
      (update(syncOutbox)
            ..where((operation) => operation.status.equals('processing')))
          .write(const SyncOutboxCompanion(status: Value('pending')));

  Future<String?> readCursor(String key) async {
    final row = await (select(
      syncMetadataEntries,
    )..where((metadata) => metadata.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> saveCursor(String key, String value) async {
    await into(syncMetadataEntries).insertOnConflictUpdate(
      SyncMetadataEntriesCompanion.insert(key: key, value: value),
    );
  }
}
