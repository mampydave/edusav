// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignation_ecole_dao.dart';

// ignore_for_file: type=lint
mixin _$AssignationEcoleDaoMixin on DatabaseAccessor<AppDatabase> {
  $AssignationsEcoleTable get assignationsEcole =>
      attachedDatabase.assignationsEcole;
  $RolesTable get roles => attachedDatabase.roles;
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  AssignationEcoleDaoManager get managers => AssignationEcoleDaoManager(this);
}

class AssignationEcoleDaoManager {
  final _$AssignationEcoleDaoMixin _db;
  AssignationEcoleDaoManager(this._db);
  $$AssignationsEcoleTableTableManager get assignationsEcole =>
      $$AssignationsEcoleTableTableManager(
        _db.attachedDatabase,
        _db.assignationsEcole,
      );
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
}
