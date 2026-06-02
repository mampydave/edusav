// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum_dao.dart';

// ignore_for_file: type=lint
mixin _$CurriculumDaoMixin on DatabaseAccessor<AppDatabase> {
  $EcolesTable get ecoles => attachedDatabase.ecoles;
  $NiveauxTable get niveaux => attachedDatabase.niveaux;
  $MatieresTable get matieres => attachedDatabase.matieres;
  $CurriculumsTable get curriculums => attachedDatabase.curriculums;
  CurriculumDaoManager get managers => CurriculumDaoManager(this);
}

class CurriculumDaoManager {
  final _$CurriculumDaoMixin _db;
  CurriculumDaoManager(this._db);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db.attachedDatabase, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db.attachedDatabase, _db.niveaux);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db.attachedDatabase, _db.matieres);
  $$CurriculumsTableTableManager get curriculums =>
      $$CurriculumsTableTableManager(_db.attachedDatabase, _db.curriculums);
}
