// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilisateur_dao.dart';

// ignore_for_file: type=lint
mixin _$UtilisateurDaoMixin on DatabaseAccessor<AppDatabase> {
  $RolesTable get roles => attachedDatabase.roles;
  $UtilisateursTable get utilisateurs => attachedDatabase.utilisateurs;
  UtilisateurDaoManager get managers => UtilisateurDaoManager(this);
}

class UtilisateurDaoManager {
  final _$UtilisateurDaoMixin _db;
  UtilisateurDaoManager(this._db);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db.attachedDatabase, _db.utilisateurs);
}
