// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_dao.dart';

// ignore_for_file: type=lint
mixin _$PageDaoMixin on DatabaseAccessor<AppDatabase> {
  $RolesTable get roles => attachedDatabase.roles;
  $UtilisateursTable get utilisateurs => attachedDatabase.utilisateurs;
  $MatieresTable get matieres => attachedDatabase.matieres;
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  $LeconsTable get lecons => attachedDatabase.lecons;
  $PagesTable get pages => attachedDatabase.pages;
  PageDaoManager get managers => PageDaoManager(this);
}

class PageDaoManager {
  final _$PageDaoMixin _db;
  PageDaoManager(this._db);
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
  $$PagesTableTableManager get pages =>
      $$PagesTableTableManager(_db.attachedDatabase, _db.pages);
}
