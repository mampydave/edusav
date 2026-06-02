import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'niveau_dao.g.dart';

@DriftAccessor(tables: [Niveaux, Ecoles])
class NiveauDao extends DatabaseAccessor<AppDatabase> with _$NiveauDaoMixin {
  NiveauDao(super.db);

  /// 🔹 INSERT
  Future<int> insert(NiveauxCompanion data) => into(niveaux).insert(data);

  /// 🔹 GET BY ID
  Future<Niveau?> getById(String id) =>
      (select(niveaux)..where((n) => n.id.equals(id))).getSingleOrNull();

  /// 🔹 GET ALL
  Future<List<Niveau>> getAll() => select(niveaux).get();

  /// 🔹 WATCH
  Stream<List<Niveau>> watchAll() => select(niveaux).watch();

  /// 🔹 GET par école
  Future<List<Niveau>> getByEcole(String ecoleId) =>
      (select(niveaux)..where((n) => n.ecoleId.equals(ecoleId))).get();

  /// 🔹 UPDATE
  Future<bool> updateData(NiveauxCompanion data) =>
      update(niveaux).replace(data);

  /// 🔹 DELETE
  Future<int> deleteById(String id) =>
      (delete(niveaux)..where((n) => n.id.equals(id))).go();

  /// 🔥 JOIN avec école
  Future<List<(Niveau, Ecole)>> getWithEcole() async {
    final query = select(
      niveaux,
    ).join([innerJoin(ecoles, ecoles.id.equalsExp(niveaux.ecoleId))]);

    final rows = await query.get();

    return rows.map((row) {
      return (row.readTable(niveaux), row.readTable(ecoles));
    }).toList();
  }
}
