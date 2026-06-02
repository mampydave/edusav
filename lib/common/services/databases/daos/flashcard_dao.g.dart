// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_dao.dart';

// ignore_for_file: type=lint
mixin _$FlashcardDaoMixin on DatabaseAccessor<AppDatabase> {
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  $RolesTable get roles => attachedDatabase.roles;
  $UtilisateursTable get utilisateurs => attachedDatabase.utilisateurs;
  $MatieresTable get matieres => attachedDatabase.matieres;
  $LeconsTable get lecons => attachedDatabase.lecons;
  $FlashcardsTable get flashcards => attachedDatabase.flashcards;
  FlashcardDaoManager get managers => FlashcardDaoManager(this);
}

class FlashcardDaoManager {
  final _$FlashcardDaoMixin _db;
  FlashcardDaoManager(this._db);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db.attachedDatabase, _db.roles);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db.attachedDatabase, _db.utilisateurs);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db.attachedDatabase, _db.matieres);
  $$LeconsTableTableManager get lecons =>
      $$LeconsTableTableManager(_db.attachedDatabase, _db.lecons);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db.attachedDatabase, _db.flashcards);
}
