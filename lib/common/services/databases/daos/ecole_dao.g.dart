// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecole_dao.dart';

// ignore_for_file: type=lint
mixin _$EcoleDaoMixin on DatabaseAccessor<AppDatabase> {
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  EcoleDaoManager get managers => EcoleDaoManager(this);
}

class EcoleDaoManager {
  final _$EcoleDaoMixin _db;
  EcoleDaoManager(this._db);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
}
