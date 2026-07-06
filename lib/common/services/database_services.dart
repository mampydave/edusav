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
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final db = ref.watch(databaseProvider);
  return DatabaseService(db);
});

class DatabaseService {
  final AppDatabase _db;

  DatabaseService(this._db);

  LeconDao get lecons => _db.leconDao;
  UtilisateurDao get utilisateurs => _db.utilisateurDao;
  AppartenanceDao get appartenances => _db.appartenanceDao;
  MatiereDao get matieres => _db.matiereDao;
  RoleDao get roles => _db.roleDao;
  CurriculumDao get curriculums => _db.curriculumDao;
  NiveauDao get niveaux => _db.niveauDao;
  EcoleDao get ecoles => _db.ecoleDao;
  PageDao get pages => _db.pageDao;
  AssignationEcoleDao get assignationsEcole => _db.assignationEcoleDao;
  FlashcardDao get flashcards => _db.flashcardDao;
}
