import 'package:drift/drift.dart';

/// ==========================================================
/// 1. ROLES & PERMISSIONS
/// ==========================================================

@DataClassName('Role')
class Roles extends Table {
  TextColumn get id => text()();
  TextColumn get nomRole => text().named('nom_role')();
  TextColumn get description => text().nullable()();

  @override
  String get tableName => 'sie_role';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Permission')
class Permissions extends Table {
  TextColumn get id => text()();
  TextColumn get code => text().unique()();

  @override
  String get tableName => 'sie_permissions';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RolePermission')
class RolePermissions extends Table {
  TextColumn get roleId => text().named('role_id').references(Roles, #id)();

  TextColumn get permId =>
      text().named('perm_id').references(Permissions, #id)();

  @override
  String get tableName => 'sie_role_permissions';

  @override
  Set<Column> get primaryKey => {roleId, permId};
}

/// ==========================================================
/// 2. ECOLES / NIVEAUX / UTILISATEURS
/// ==========================================================

@DataClassName('Ecole')
class Ecoles extends Table {
  TextColumn get id => text()();
  TextColumn get nom => text()();
  TextColumn get ville => text().nullable()();
  IntColumn get dateCrea => integer().named('date_crea')();

  @override
  String get tableName => 'sie_ecole';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Niveau')
class Niveaux extends Table {
  TextColumn get id => text()();
  TextColumn get nomNiveau => text().named('nom_niveau')();

  TextColumn get ecoleId => text().named('ecole_id').references(Ecoles, #id)();

  @override
  String get tableName => 'sie_niveaux';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Utilisateur')
class Utilisateurs extends Table {
  TextColumn get id => text()();
  TextColumn get nom => text()();
  TextColumn get prenom => text().nullable()();
  TextColumn get email => text().unique()();
  TextColumn get mdp => text()();

  TextColumn get roleId =>
      text().nullable().named('role_id').references(Roles, #id)();

  IntColumn get dateCrea => integer().named('date_crea')();
  IntColumn get dateDel => integer().nullable().named('date_del')();

  @override
  String get tableName => 'sie_utilisateurs';

  @override
  Set<Column> get primaryKey => {id};
}

/// ==========================================================
/// 3. APPARTENANCE
/// ==========================================================

@DataClassName('Appartenance')
class Appartenances extends Table {
  TextColumn get id => text()();

  TextColumn get userId =>
      text().named('user_id').references(Utilisateurs, #id)();

  TextColumn get ecoleId => text().named('ecole_id').references(Ecoles, #id)();

  TextColumn get niveauId =>
      text().nullable().named('niveau_id').references(Niveaux, #id)();

  TextColumn get anneeSco => text().named('annee_sco')();

  BoolColumn get estActif => boolean().withDefault(const Constant(true))();

  IntColumn get dateMiseAJour => integer().named('date_mise_a_jour')();

  @override
  String get tableName => 'sie_appartenance';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AssignationEcole')
class AssignationsEcole extends Table {
  TextColumn get id => text()();

  TextColumn get userId => text()();
  TextColumn get ecoleId => text()();
  TextColumn get roleId => text()();

  DateTimeColumn get dateDebut => dateTime()();
  DateTimeColumn get dateFin => dateTime().nullable()();

  TextColumn get statut => text().withDefault(const Constant('PENDING'))();
  BoolColumn get estActif => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// ==========================================================
/// 4. PEDAGOGIQUE
/// ==========================================================

@DataClassName('Matiere')
class Matieres extends Table {
  TextColumn get id => text()();
  TextColumn get nom => text()();
  TextColumn get codeMatiere =>
      text().nullable().unique().named('code_matiere')();

  @override
  String get tableName => 'sie_matieres';

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Lecon')
class Lecons extends Table {
  TextColumn get id => text()();
  TextColumn get titre => text()();

  TextColumn get contenuBrut => text().nullable().named('contenu_brut')();
  TextColumn get contenuStyl => text().nullable().named('contenu_styl')();

  TextColumn get visibilite => text().withDefault(const Constant('PRIVE'))();

  TextColumn get auteurId =>
      text().nullable().named('auteur_id').references(Utilisateurs, #id)();

  TextColumn get matiereId =>
      text().nullable().named('matiere_id').references(Matieres, #id)();

  TextColumn get niveauId =>
      text().nullable().named('niveau_id').references(Niveaux, #id)();

  TextColumn get ecoleId =>
      text().nullable().named('ecole_id').references(Ecoles, #id)();

  IntColumn get dateUpd => integer().named('date_upd')();
  IntColumn get dateDel => integer().nullable().named('date_del')();

  TextColumn get sourceType =>
      text().withDefault(const Constant('scan'))(); // 'scan' ou 'import'
  @override
  String get tableName => 'sie_lecon';

  @override
  Set<Column> get primaryKey => {id};
}

/// ==========================================================
/// 5. CURRICULUM
/// ==========================================================

@DataClassName('Curriculum')
class Curriculums extends Table {
  TextColumn get id => text()();

  TextColumn get ecoleId => text().named('ecole_id').references(Ecoles, #id)();

  TextColumn get niveauId =>
      text().named('niveau_id').references(Niveaux, #id)();

  TextColumn get matiereId =>
      text().named('matiere_id').references(Matieres, #id)();

  @override
  String get tableName => 'sie_curriculum';

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {ecoleId, niveauId, matiereId},
  ];
}

/// ==========================================================
/// 6. PAGES
/// ==========================================================

@DataClassName('Page')
class Pages extends Table {
  TextColumn get id => text()();

  TextColumn get leconId => text().named('lecon_id').references(Lecons, #id)();

  IntColumn get numeroPage => integer().named('numero_page')();
  TextColumn get cheminImage => text().nullable().named('chemin_image')();
  TextColumn get ocrTexte => text().nullable().named('ocr_texte')();
  TextColumn get contenuStyl => text().nullable().named('contenu_styl')();
  IntColumn get ordre => integer()();

  @override
  String get tableName => 'sie_pages';

  @override
  Set<Column> get primaryKey => {id};
}

/// ==========================================================
/// 7. FLASHCARDS
///   ==========================================================

@DataClassName('Flashcard')
class Flashcards extends Table {
  TextColumn get id => text()();

  TextColumn get ecoleId =>
      text().nullable().named('ecole_id').references(Ecoles, #id)();
  // niveauId peut être null pour les flashcards génériques
  TextColumn get niveauId =>
      text().nullable().named('niveau_id').references(Niveaux, #id)();

  TextColumn get leconId =>
      text().nullable().named('lecon_id').references(Lecons, #id)();
  TextColumn get matiereId =>
      text().named('matiere_id').references(Matieres, #id)();
  TextColumn get userId =>
      text().named('user_id').references(Utilisateurs, #id)();

  TextColumn get question => text()();
  TextColumn get reponse => text()();
  TextColumn get explication => text().nullable()();

  // Spaced Repetition
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  RealColumn get easinessFactor => real().withDefault(const Constant(2.5))();
  IntColumn get nextReviewDate => integer()(); // timestamp

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
