import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:edusav/common/services/databases/daos/appartenance_dao.dart';
import 'package:edusav/common/services/databases/daos/assignation_ecole_dao.dart';
import 'package:edusav/common/services/databases/daos/curriculum_dao.dart';
import 'package:edusav/common/services/databases/daos/ecole_dao.dart';
import 'package:edusav/common/services/databases/daos/flashcard_dao.dart';
import 'package:edusav/common/services/databases/daos/lecon_dao.dart';
import 'package:edusav/common/services/databases/daos/matiere_dao.dart';
import 'package:edusav/common/services/databases/daos/niveau_dao.dart';
import 'package:edusav/common/services/databases/daos/page_dao.dart';
import 'package:edusav/common/services/databases/daos/role_dao.dart';
import 'package:edusav/common/services/databases/daos/utilisateur_dao.dart';
import 'package:edusav/common/services/databases/tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart'; // généré automatiquement par Drift, ne pas toucher

@DriftDatabase(
  tables: [
    Roles, Permissions, RolePermissions,
    Ecoles, Niveaux, Utilisateurs, Appartenances,
    Matieres, Lecons, Curriculums, Pages,
    Flashcards, AssignationsEcole,
    // Revisions,
    // Roles, Permissions, RolePermissions → à ajouter plus tard
  ],
  daos: [
    LeconDao,
    UtilisateurDao,
    MatiereDao,
    RoleDao,
    CurriculumDao,
    AppartenanceDao,
    FlashcardDao,
    NiveauDao,
    EcoleDao,
    PageDao,
    AssignationEcoleDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; // incrémente quand on changes la structure

  // Optionnel : migrations futures
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
        // activer les FK pour assurer l'intégrité référentielle
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (migrator, from, to) async {
        // ex: if (from < 2) await migrator.addColumn(...);
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'edusav.db'));
    return NativeDatabase.createInBackground(file);
  });
}
