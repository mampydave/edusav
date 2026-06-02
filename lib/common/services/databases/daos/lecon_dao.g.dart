// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecon_dao.dart';

// ignore_for_file: type=lint
mixin _$LeconDaoMixin on DatabaseAccessor<AppDatabase> {
  $RolesTable get roles => attachedDatabase.roles;
  $UtilisateursTable get utilisateurs => attachedDatabase.utilisateurs;
  $MatieresTable get matieres => attachedDatabase.matieres;
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  $LeconsTable get lecons => attachedDatabase.lecons;
  LeconDaoManager get managers => LeconDaoManager(this);
}

class LeconDaoManager {
  final _$LeconDaoMixin _db;
  LeconDaoManager(this._db);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db.attachedDatabase, _db.utilisateurs);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db.attachedDatabase, _db.matieres);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
  $$LeconsTableTableManager get lecons =>
      $$LeconsTableTableManager(_db.attachedDatabase, _db.lecons);
}
