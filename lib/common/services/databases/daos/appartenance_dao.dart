import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'appartenance_dao.g.dart';

@DriftAccessor(tables: [Appartenances, Utilisateurs, Ecoles, Niveaux])
class AppartenanceDao extends DatabaseAccessor<AppDatabase>
    with _$AppartenanceDaoMixin {
  AppartenanceDao(super.db);

  Future<int> insert(AppartenancesCompanion data) =>
      into(appartenances).insert(data);

  Future<List<Appartenance>> getByUser(String userId) =>
      (select(appartenances)..where((a) => a.userId.equals(userId))).get();

  Stream<List<Appartenance>> watchByUser(String userId) =>
      (select(appartenances)..where((a) => a.userId.equals(userId))).watch();

  Future<void> updateData(AppartenancesCompanion data) =>
      update(appartenances).replace(data);

  Future<List<(Appartenance, Ecole, Niveau?)>> getFull(String userId) async {
    final query = select(appartenances).join([
      innerJoin(ecoles, ecoles.id.equalsExp(appartenances.ecoleId)),
      leftOuterJoin(niveaux, niveaux.id.equalsExp(appartenances.niveauId)),
    ])..where(appartenances.userId.equals(userId));

    final rows = await query.get();

    return rows.map((row) {
      return (
        row.readTable(appartenances),
        row.readTable(ecoles),
        row.readTableOrNull(niveaux),
      );
    }).toList();
  }
}
