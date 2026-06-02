// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appartenance_dao.dart';

// ignore_for_file: type=lint
mixin _$AppartenanceDaoMixin on DatabaseAccessor<AppDatabase> {
  $RolesTable get roles => attachedDatabase.roles;
  $UtilisateursTable get utilisateurs => attachedDatabase.utilisateurs;
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  $AppartenancesTable get appartenances => attachedDatabase.appartenances;
  AppartenanceDaoManager get managers => AppartenanceDaoManager(this);
}

class AppartenanceDaoManager {
  final _$AppartenanceDaoMixin _db;
  AppartenanceDaoManager(this._db);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db.attachedDatabase, _db.utilisateurs);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
  $$AppartenancesTableTableManager get appartenances =>
      $$AppartenancesTableTableManager(_db.attachedDatabase, _db.appartenances);
}
