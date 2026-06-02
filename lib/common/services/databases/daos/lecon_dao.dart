import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'lecon_dao.g.dart';

@DriftAccessor(tables: [Lecons, Utilisateurs, Matieres, Ecoles])
class LeconDao extends DatabaseAccessor<AppDatabase> with _$LeconDaoMixin {
  LeconDao(super.db);

  Future<int> insert(LeconsCompanion data) => into(lecons).insert(data);

  Future<Lecon?> getById(String id) =>
      (select(lecons)..where((l) => l.id.equals(id))).getSingleOrNull();

  Future<List<Lecon>> getAll() =>
      (select(lecons)..where((l) => l.dateDel.isNull())).get();

  Stream<List<Lecon>> watchAll() =>
      (select(lecons)..where((l) => l.dateDel.isNull())).watch();

  Future<void> updateLecon(LeconsCompanion data) =>
      update(lecons).replace(data);

  Future<int> softDelete(String id) =>
      (update(lecons)..where((l) => l.id.equals(id))).write(
        LeconsCompanion(dateDel: Value(DateTime.now().millisecondsSinceEpoch)),
      );

  // 🔥 JOIN COMPLET
  Future<List<(Lecon, Utilisateur?, Matiere?, Ecole?)>> getFull() async {
    final query = select(lecons).join([
      leftOuterJoin(utilisateurs, utilisateurs.id.equalsExp(lecons.auteurId)),
      leftOuterJoin(matieres, matieres.id.equalsExp(lecons.matiereId)),
      leftOuterJoin(ecoles, ecoles.id.equalsExp(lecons.ecoleId)),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      return (
        row.readTable(lecons),
        row.readTableOrNull(utilisateurs),
        row.readTableOrNull(matieres),
        row.readTableOrNull(ecoles),
      );
    }).toList();
  }

  // 🔥 JOIN AVEC FILTRE PAR AUTEUR
  Future<List<Lecon>> getLeconsByAuteur(String auteurId) async {
    final query = select(lecons)..where((l) => l.auteurId.equals(auteurId));
    return await query.get();
  }

  Stream<List<Lecon>> watchLeconsByAuteur(String auteurId) {
    final query = select(lecons)..where((l) => l.auteurId.equals(auteurId));
    return query.watch();
  }

  // create methode searchLecons avec filtres optionnels : query (sur titre), niveauId, ecoleId
  Future<List<Lecon>> searchLecons({
    String? query,
    String? niveauId,
    String? ecoleId,
    String? matiereId,
  }) {
    final leconQuery = select(lecons)..where((l) => l.dateDel.isNull());

    if (query != null && query.isNotEmpty) {
      leconQuery.where((l) => l.titre.contains(query));
    }

    if (niveauId != null && niveauId.isNotEmpty) {
      leconQuery.where((l) => l.niveauId.equals(niveauId));
    }

    if (ecoleId != null && ecoleId.isNotEmpty) {
      leconQuery.where((l) => l.ecoleId.equals(ecoleId));
    }

    if (matiereId != null && matiereId.isNotEmpty) {
      leconQuery.where((l) => l.matiereId.equals(matiereId));
    }

    return leconQuery.get();
  }
}
