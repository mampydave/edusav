// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matiere_dao.dart';

// ignore_for_file: type=lint
mixin _$MatiereDaoMixin on DatabaseAccessor<AppDatabase> {
  $MatieresTable get matieres => attachedDatabase.matieres;
  MatiereDaoManager get managers => MatiereDaoManager(this);
}

class MatiereDaoManager {
  final _$MatiereDaoMixin _db;
  MatiereDaoManager(this._db);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db.attachedDatabase, _db.matieres);
}
