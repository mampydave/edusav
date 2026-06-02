// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niveau_dao.dart';

// ignore_for_file: type=lint
mixin _$NiveauDaoMixin on DatabaseAccessor<AppDatabase> {
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  NiveauDaoManager get managers => NiveauDaoManager(this);
}

class NiveauDaoManager {
  final _$NiveauDaoMixin _db;
  NiveauDaoManager(this._db);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
}
