// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncOutboxTable get syncOutbox => attachedDatabase.syncOutbox;
  $SyncMetadataEntriesTable get syncMetadataEntries =>
      attachedDatabase.syncMetadataEntries;
  SyncDaoManager get managers => SyncDaoManager(this);
}

class SyncDaoManager {
  final _$SyncDaoMixin _db;
  SyncDaoManager(this._db);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db.attachedDatabase, _db.syncOutbox);
  $$SyncMetadataEntriesTableTableManager get syncMetadataEntries =>
      $$SyncMetadataEntriesTableTableManager(
        _db.attachedDatabase,
        _db.syncMetadataEntries,
      );
}
