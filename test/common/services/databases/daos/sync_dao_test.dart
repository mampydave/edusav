import 'dart:io';

import 'package:drift/native.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'outbox stores pending operations and removes completed operations',
    () async {
      await database.syncDao.enqueue(
        id: 'operation-1',
        entityType: 'lesson',
        entityId: 'lesson-1',
        operationType: 'upsert',
        payload: '{"id":"lesson-1"}',
        baseVersion: 1,
      );

      final pending = await database.syncDao.getPending();
      expect(pending, hasLength(1));
      expect(pending.single.entityId, 'lesson-1');
      expect(pending.single.baseVersion, 1);

      await database.syncDao.complete('operation-1');
      expect(await database.syncDao.getPending(), isEmpty);
    },
  );

  test('processing operations are recoverable after app restart', () async {
    await database.syncDao.enqueue(
      id: 'operation-2',
      entityType: 'lesson',
      entityId: 'lesson-2',
      operationType: 'upsert',
      payload: '{}',
    );
    await database.syncDao.markProcessing('operation-2');

    expect(await database.syncDao.getPending(), isEmpty);
    await database.syncDao.recoverProcessing();
    expect(await database.syncDao.getPending(), hasLength(1));
  });

  test('retry and conflict states retain diagnostic details', () async {
    await database.syncDao.enqueue(
      id: 'operation-3',
      entityType: 'lesson',
      entityId: 'lesson-3',
      operationType: 'upsert',
      payload: '{}',
    );

    await database.syncDao.markRetry('operation-3', 'network unavailable');
    var operation = await database.syncOutboxDaoRow('operation-3');
    expect(operation?.attempts, 1);
    expect(operation?.lastError, 'network unavailable');

    await database.syncDao.markConflict('operation-3', 'version conflict');
    operation = await database.syncOutboxDaoRow('operation-3');
    expect(operation?.status, 'conflict');
    expect(operation?.lastError, 'version conflict');
    expect(await database.syncDao.getPending(), isEmpty);
  });

  test('sync cursor can be saved and updated', () async {
    await database.syncDao.saveCursor('lessons', 'cursor-1');
    expect(await database.syncDao.readCursor('lessons'), 'cursor-1');

    await database.syncDao.saveCursor('lessons', 'cursor-2');
    expect(await database.syncDao.readCursor('lessons'), 'cursor-2');
  });

  test('an existing v1 database upgrades to the sync schema', () async {
    final directory = await Directory.systemTemp.createTemp('edusav-sync-');
    final databaseFile = File(p.join(directory.path, 'edusav.db'));

    try {
      final versionOneDatabase = AppDatabase(NativeDatabase(databaseFile));
      await versionOneDatabase.customSelect('SELECT 1').get();
      await versionOneDatabase.customStatement('DROP TABLE sync_outbox');
      await versionOneDatabase.customStatement(
        'DROP TABLE sync_metadata_entries',
      );
      await versionOneDatabase.customStatement('PRAGMA user_version = 1');
      await versionOneDatabase.close();

      final upgradedDatabase = AppDatabase(NativeDatabase(databaseFile));
      expect(await upgradedDatabase.syncDao.getPending(), isEmpty);
      await upgradedDatabase.syncDao.saveCursor('lessons', 'cursor-1');
      expect(await upgradedDatabase.syncDao.readCursor('lessons'), 'cursor-1');
      await upgradedDatabase.close();
    } finally {
      await directory.delete(recursive: true);
    }
  });
}

extension on AppDatabase {
  Future<SyncOperation?> syncOutboxDaoRow(String id) => (select(
    syncOutbox,
  )..where((operation) => operation.id.equals(id))).getSingleOrNull();
}
